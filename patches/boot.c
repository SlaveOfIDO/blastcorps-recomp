#include "patches.h"
#include "misc_funcs.h"
#include <PR/sched.h>
#include <hd_code/macros.h>
#include <hd_code/functions.h>
#include <hd_code/variables.h>

#define VIDEO_MSG 0
#define RSP_DONE_MSG 1
#define RDP_DONE_MSG 2
#define PRE_NMI_MSG 3
#define RSP_STATE_SUSPENDED 3

#define EXEC_IS_AUDIO 0
#define EXEC_IS_GFX 1

void __scHandleGfxTask(OSSched*, void*);
void __scExecAudioIfIdle(OSSched*);
void __scRetraceDone(OSSched*);
void __scRspDone(OSSched*);
void __scRdpDone(OSSched*);
void __scExec(OSSched*, s32); /* extern */
void func_hd_front_end_801F58E8(void);
void func_hd_front_end_801F74B0(u8* arg0);
extern s32 boot_osPiRawStartDma(s32 direction, u32 devAddr, void* dramAddr, u32 size);
void yield_self(void);
extern OSMesgQueue D_hd_code_80314D80;  // bss
extern OSMesg D_hd_code_80314D98[0xC2]; // bss

extern OSThread g_Thread1;
extern OSThread g_Thread3;
extern u8 g_Thread1Stack[0x200];
extern u8 D_hd_front_end_80218EF8[0x1000];
extern void* D_hd_front_end_80219F10[8];
extern OSMesgQueue D_hd_front_end_80219F30;
extern void* D_hd_front_end_80219F48;
extern void* D_hd_front_end_80219F68[8];
extern u8 D_hd_front_end_8020C000[0x14];
extern u8 D_hd_front_end_8020C014[8];
extern s32 D_hd_code_8036BF10;
extern u32 D_hd_code_8036BFB8;
extern OSTime D_hd_code_8036BEF8;
extern OSTime D_hd_code_8036BF00;
extern s32 D_hd_code_8036BF08;
extern s32 D_hd_code_8036BF0C;
extern OSTimer D_hd_code_8036BF78;
extern s32 g_nextRetrace;
extern s32 D_hd_code_8036BF18;
extern OSScTask* g_currentRdpTask;

static bool sGfxTaskPending = 0;


typedef struct AudioInfo_s {
    s16* data;
    s16 frameSamples;
    OSScTask task;
} AudioInfo;

typedef struct AudioManager_s {
    void* cmdList[2];  // @recomp: stubbed
    AudioInfo* audioInfo[3];
    u32 numberOutputBuffers;
    u8 audioThread[0x1C8 - 0x18]; // @recomp: stubbed
    OSMesgQueue frameMessageQueue;
    OSMesg frameMessageBuffer[8];
    OSMesgQueue replyMessageQueue;
    // @recomp: rest of the fields not included here
} AudioManager;


RECOMP_PATCH void MainJump() {
    // @recomp: removed osInitialize, removed debug args parsing

    // @recomp: inform the runtime that we're loading a new segment
    recomp_load_overlays((u32) 0x00800000, (u32*) 0x802447C0, 0x000CAEA0);

    osCreateThread(&g_Thread1, 1, Thread1, NULL, g_Thread1Stack + 0x200, 0xA);
    osStartThread(&g_Thread1);
}

RECOMP_PATCH void func_hd_front_end_801F57B0(void) {
    s32 sp24 = 0xDE0;

    // @recomp: inform the runtime that we're loading a new segment
    recomp_load_overlays((u32) 0x008CAEA0, (u32*) 0x801E7000, 0x00029E90);

    osCreateThread(&D_hd_front_end_80218D30, 2, func_hd_front_end_801F58E8, NULL, &D_hd_front_end_80218EF8[0x1000],
                   0xB);
    osCreateMesgQueue(&D_hd_front_end_80219EF8, &D_hd_front_end_80219F10, 8);
    osCreateMesgQueue(&D_hd_front_end_80219F30, &D_hd_front_end_80219F48, 1);
    osCreateMesgQueue(&D_hd_front_end_80219F50, &D_hd_front_end_80219F68, 8);
    func_hd_front_end_801F74B0(D_hd_front_end_8020C000);
    func_hd_front_end_801F74B0(D_hd_front_end_8020C014);
    rmonPrintf("current pak file size is %d bytes\n", sp24);
    rmonPrintf("current playerInfo size is %d bytes\n", 0x100);
    osScAddClient(&sc, &D_hd_front_end_80218EE0, &D_hd_front_end_80219F30, 1, 3);
    if (sp24 >= 0xE00) {
        rmonPrintf(ASSERT_MESSAGE, "filesize<PFS_FILE_SIZE", "pfsHandler.c", 0x68);
    }
    osStartThread(&D_hd_front_end_80218D30);
}

// Since we named osPiRawStartDma inside the init portion of the rom InitosPiRawStartDma, we're just patching it its
// output here and redirecting its args to boot_osPiRawStartDma
RECOMP_PATCH s32 _osPiRawStartDma(s32 direction, u32 devAddr, void* dramAddr, u32 size) {
    // recomp_printf("osPiRawStartDma: direction %d, devAddr: %x, dramAddr %x, size: %x \n",
    //     direction, devAddr, dramAddr, size);
    boot_osPiRawStartDma(direction, devAddr, dramAddr, size);
}

// Since we named osPiGetStatus inside the init portion of the rom _osPiGetStatus, we're just stubbing its
// output here.
RECOMP_PATCH u32 _osPiGetStatus(void) {
    return 0;
}

void amClearDmaBuffers(void);
extern s32 g_FrameSize;
extern u32 g_MinFrameSize;
extern AudioManager g_AudioManager;
extern u32 g_CurrentAcmdList;
extern s32 g_CommandLength;
extern OSScClient g_AudioClient;

#define MAX_ACMD_SIZE 2750
#define EXTRA_SAMPLES 0x25
RECOMP_PATCH void amHandleFrameMessage(AudioInfo* info, AudioInfo* lastInfo) {
    s16* outBuffer;
    Acmd* cmdlp;
    u32 sp2C;
    OSScTask* task;

    sp2C = 0;
    amClearDmaBuffers();
    outBuffer = (s16*) osVirtualToPhysical(info->data);
    if (lastInfo != NULL) {
        osAiSetNextBuffer(lastInfo->data, lastInfo->frameSamples * 4);
    }
    sp2C = osAiGetLength() >> 2;

    // @recomp: osAiGetLength() could be larger than the frame size, then neededSamples get below zero, which caused
    // issues with unsigned casting
    // TODO: better skip when neededSamples is below zero?
    s32 neededSamples = g_FrameSize - sp2C;
    if (neededSamples < 1)
        neededSamples = 1;
    info->frameSamples = ((neededSamples) + 0x10 + EXTRA_SAMPLES) & ~0xF;
    if ((u32) info->frameSamples < (u32) g_MinFrameSize) {
        info->frameSamples = (s16) g_MinFrameSize;
    }
    cmdlp = alAudioFrame(g_AudioManager.cmdList[g_CurrentAcmdList], &g_CommandLength, outBuffer, info->frameSamples);
    if (g_CommandLength > MAX_ACMD_SIZE) {
        rmonPrintf(ASSERT_MESSAGE, "cmdLen <= MAX_RSP_CMDS", "audio.c", 0x150);
    }
    task = &info->task;
    info->task.next = NULL;
    task->msgQ = &g_AudioManager.replyMessageQueue;
    task->msg = (OSMesg) info;
    task->flags = OS_SC_NEEDS_RDP;
    task->client = &g_AudioClient;
    task->list.t.data_ptr = (u64*) g_AudioManager.cmdList[g_CurrentAcmdList];
    task->list.t.data_size = ((s32) ((s32) cmdlp - (s32) g_AudioManager.cmdList[g_CurrentAcmdList]) >> 3) * 8;
    task->list.t.type = M_AUDTASK;
    task->list.t.ucode_boot = (u64*) rspbootTextStart;
    task->list.t.ucode_boot_size = (s32) aspMainTextStart - (s32) rspbootTextStart;
    task->list.t.flags = 0;
    task->list.t.ucode = (u64*) aspMainTextStart;
    task->list.t.ucode_data = (u64*) aspMainDataStart;
    task->list.t.ucode_data_size = 0x800;
    task->list.t.yield_data_ptr = NULL;
    task->list.t.yield_data_size = 0;

    if (osSendMesg(&sc.cmdQ, (OSMesg) task, OS_MESG_NOBLOCK) == -1) {
        rmonPrintf(ASSERT_MESSAGE, "osSendMesg(osScGetCmdQ(&sc), (OSMesg) t, OS_MESG_NOBLOCK)!=-1", "audio.c", 0x169);
    }
    g_CurrentAcmdList ^= 1;
}

void __scAppendList(OSSched*, OSScTask*); /* extern */
s32 __scSendMesg(OSMesgQueue* messageQueue, OSMesg message, s32 flags); /* extern */

// @recomp: osGetTime()/osGetCount() counts at 46875000 ticks/sec
#define OS_COUNTS_PER_SEC 46875000U //
static u32 sLastRetraceTime = 0;
RECOMP_PATCH void __scRetraceDone(OSSched* scheduler) {
    OSScTask* rspTask;
    OSScClient* client;
    s32 sp3C;
    s32 sp38;

    // @recomp: cap incrementing retrace counter to 60fps. Unsure whether this is necessary
    OSTime elapsedTime = osGetCount() - sLastRetraceTime;

    s32 retraceTargetFps = 60;
    if (elapsedTime > OS_COUNTS_PER_SEC / retraceTargetFps) {
        scheduler->retraceCount++;
        if (D_hd_code_802E8BD0 == 0) {
            scheduler->unk803156C0++;
        }
        sLastRetraceTime = osGetCount();
    }

    D_hd_code_8036BF38 = osGetTime();
    if (g_currentRdpTask != NULL) {
        osViSwapBuffer(g_currentRdpTask->framebuffer);
        D_hd_code_8036BF18 = g_nextRetrace;
        g_nextRetrace = scheduler->retraceCount + 1;
        osDpSetStatus(DPC_SET_FREEZE);
        if (g_currentRdpTask->msgQ != NULL) {
            __scSendMesg(g_currentRdpTask->msgQ, g_currentRdpTask->msg, OS_MESG_NOBLOCK);
        }
        g_currentRdpTask = NULL;
    } else {
        if (osViGetCurrentFramebuffer() == osViGetNextFramebuffer() && (osDpGetStatus() & 2)) {
            scheduler->unk803156C8 = osGetTime();
            osDpSetStatus(DPC_CLR_FREEZE);
        }
    }


    for (sp38 = scheduler->cmdQ.validCount, sp3C = 0; sp3C < sp38; sp3C++) {
        if (osRecvMesg(&scheduler->cmdQ, (OSMesg*) &rspTask, OS_MESG_NOBLOCK) == -1) {
            rmonPrintf(ASSERT_MESSAGE, "osRecvMesg(&sc->cmdQ, (OSMesg *)&rspTask, OS_MESG_NOBLOCK) != -1", "sched.c",
                       0x1BD);
        }

        // @recomp: Ignore empty audio tasks and answer them directly as completed. Potentially not needed anymore. TODO: Need to recheck
        if (rspTask->list.t.data_size == 0) {
            rmonPrintf("WARNING: empty audio task received!\n");
            osSendMesg(rspTask->msgQ, rspTask->msg, OS_MESG_NOBLOCK);
            continue;
        }

        // @recomp: append audio task to the audio task list
        __scAppendList(scheduler, rspTask);
    }

    for(client = scheduler->clientList; client != NULL; client = client->next) {
        if (client->unkC == 3) {
            // This is needed for unblocking hd_front_end pak things
            osSendMesg(client->msgQ, (void* )0x29A, OS_MESG_NOBLOCK);
        }
    }
}

static s32 sPendingDpDone = 0;
static s32 sAudioFrame = 0;

RECOMP_PATCH void __scMain(void* params) {
    OSMesg msg;
    OSSched* scheduler;
    OSScClient* client;

    scheduler = (OSSched*)params;
    while (1) {
        osRecvMesg(&scheduler->interruptQ, &msg, OS_MESG_BLOCK);

        switch ((s32) msg - 0x29A) {
            case VIDEO_MSG:
                D_hd_code_8036BFB8++;
                if ((D_hd_code_8036BFB8 % 480U) == 0) {
                    D_hd_code_8036BEF8 = D_hd_code_8036BF00;
                    D_hd_code_8036BF08 = D_hd_code_8036BF0C;
                }
                if (sPendingDpDone > 0) {
                    sPendingDpDone--;
                    __scRdpDone(scheduler);
                }
                __scRetraceDone(scheduler);

                // @recomp: For every second retrace we tell the audio thread to prepare an audio task
                if (sAudioFrame % 2 == 0) {     
                    osSendMesg(&g_AudioManager.frameMessageQueue, (OSMesg) 5, OS_MESG_NOBLOCK);
                    
                }
                sAudioFrame++;

                // @recomp: If there is audio pending, run it. curRSP should be null
                if (scheduler->audioListHead != NULL) {
                    __scExecAudioIfIdle(scheduler);
                }

                break;
            case 4:
                // __scExecAudioIfIdle(scheduler);
                break;
            case RSP_DONE_MSG:
                __scRspDone(scheduler);
                break;
            case RDP_DONE_MSG:
                sPendingDpDone++;
                break;
            case 5:
                osSendMesg(D_hd_code_8036BF78.mq, D_hd_code_8036BF78.msg, 1);
                break;
            case PRE_NMI_MSG:
                for (client = scheduler->clientList; client != NULL; client = client->next) {
                    osSendMesg(client->msgQ, (void*) 0x29D, 0);
                }
                D_hd_code_8036BF10 = 1;
                osViBlack(TRUE);
                rmonPrintf("%x\n", osDpGetStatus());
                osDpSetStatus(DPC_CLR_FREEZE);
                rmonPrintf("%x\n", osDpGetStatus());
                while (1)
                    ;
            case 6:
                rmonPrintf(" *** CPU FAULT *** - UNFREEZING RDP?\n");
                while (osViGetCurrentFramebuffer() != osViGetNextFramebuffer()) {}
                osDpSetStatus(DPC_CLR_FREEZE);
                while (1)
                    ;
            default:
                __scHandleGfxTask(scheduler, (OSScTask*) msg);
                break;
        }
    }
}


#if 1
static u32 sLastMainGfxWaited = 0;
RECOMP_PATCH void gfxWaitForTask(u32 arg0) {
    u32 sp1C;

    // rmonPrintf("D_hd_code_80364A90: %llx\n", D_hd_code_80364A90);
    do {
        osRecvMesg(&D_hd_code_803153D8, (OSMesg) &sp1C, 1);
        D_hd_code_8036E68C[sp1C >> 16] = 0;
        sp1C &= 0xFFFF;
#if 1
        // if (D_hd_code_80364A90 == 0x10 || D_hd_code_80364A90 == 0x20 || D_hd_code_80364A90 ==  0x4000) {
        if (D_hd_code_80364A90 & 0xC9FD0FE79BFF80B0) {
            // targetFps = 60;
            //  TODO: Is this the right approach?
            goto skip;
        }
        // @recomp: block here until at least 1/30s has passed since the last completed
        // gfx task, capping the render rate at 30fps on modern hardware. This is not done
        // when the nintendo or rare logo is rendered. This renders much faster on the N64 than the game
        if (sGfxTaskPending) {
            // Wait only for the main task.
            u32 targetFps = 35; 

            while ((u32)osGetCount() - (u32)sLastMainGfxWaited < (OS_COUNTS_PER_SEC / targetFps)) {
                yield_self();
            }
            sLastMainGfxWaited = osGetCount();
            sGfxTaskPending = 0;
        }
#endif

    skip:

        if (sp1C != arg0) {
            rmonPrintf("Task %d received message %d\n", arg0, sp1C);
        }
    } while (sp1C != arg0);
}
#endif


// @recomp: no yielding here. Perhaps not needed anymore
RECOMP_PATCH void __scExecAudioIfIdle(OSSched* scheduler) {
    if (scheduler->curRSPTask == NULL) {
        D_hd_code_8036BF00 = 0;
        __scExec(scheduler, EXEC_IS_AUDIO);
    }
}

extern OSScTask D_hd_code_8036E698[5][2];
extern void* D_hd_code_8036E660[6];
extern void* D_hd_code_8036E678[5];
extern u64 D_hd_code_80367750;
extern u64 D_hd_code_8036AFB0;

RECOMP_PATCH void gfxSubmitTask(Gfx* displayList, s32 displayListEntries, u8 arg2, s32 arg3, s32 gfxTaskId, s32 arg5) {
    // @recomp: return early on line call draws. currently not supported
    if (arg2 == 0) {
        return;
    }

    OSScTask* gfxTask;
    s32 displayListSize;

    displayListSize = displayListEntries * sizeof(Gfx);
    gfxTask = &D_hd_code_8036E698[arg2][D_hd_code_8035805C];
    D_hd_code_8036E68C[(u8) arg2] = 1;
    gfxTask->list.t.type = M_GFXTASK;
    if ((u8) arg2 == 4) {
        gfxTask->list.t.flags = OS_TASK_DP_WAIT;
    } else {
        gfxTask->list.t.flags = 0;
    }
    gfxTask->list.t.ucode_boot = (u64*) rspbootTextStart;
    gfxTask->list.t.ucode_boot_size = (u32) aspMainTextStart - (u32) rspbootTextStart;
    gfxTask->list.t.ucode = (u64*) D_hd_code_8036E660[(u8) arg2];
    gfxTask->list.t.ucode_data = (u64*) D_hd_code_8036E678[(u8) arg2];
    gfxTask->list.t.ucode_size = 0x1000;
    gfxTask->list.t.ucode_data_size = 0x800;
    gfxTask->list.t.dram_stack = &D_hd_code_80367750;
    gfxTask->list.t.dram_stack_size = 0x400;
    gfxTask->list.t.output_buff = (u64*) g_gfxTaskOutputBuffer;
    gfxTask->list.t.output_buff_size = (u64*) (g_gfxTaskOutputBuffer + 0x1400);
    gfxTask->list.t.data_ptr = (u64*) displayList;
    gfxTask->list.t.data_size = (u32) displayListSize;
    gfxTask->list.t.yield_data_ptr = &D_hd_code_8036AFB0;
    gfxTask->list.t.yield_data_size = 0x900;
    gfxTask->next = NULL;
    gfxTask->msgQ = &D_hd_code_803153D8;
    gfxTask->msg = (OSMesg) ((arg2 << 0x10) | gfxTaskId);
    gfxTask->flags = OS_SC_NEEDS_RDP | OS_SC_NEEDS_RSP;
    if ((u8) arg3 != 0) {
        gfxTask->flags |= OS_SC_SWAPBUFFER;
    }
    gfxTask->framebuffer = D_80000400[D_hd_code_8035805C];
    gfxTask->client = &g_gfxClient;

    // @recomp: gfx task is pending. apply fps limiter
    sGfxTaskPending = 1;

    // @recomp: removed osWritebackDCache calls
    osSendMesg(&sc.interruptQ, gfxTask, OS_MESG_BLOCK);
}

RECOMP_PATCH void Thread1(void* arg0) {
    osDpSetStatus(DPC_CLR_FREEZE);
    osCreatePiManager(150, &D_hd_code_80314D80, D_hd_code_80314D98, 0xC2);
    osCreateThread(&g_Thread3, 3, Thread3, arg0, (s64*) 0x80310d80 + 0x400, 0xA);
    osStartThread(&g_Thread3);

    // @recomp: removed duplicate osStartThread here

    osSetThreadPri(0, 0);
    while (1) {}
}

RECOMP_PATCH u8 func_hd_code_8028FCD4(OSMesgQueue* arg0, u8* arg1) {
    OSContStatus sp20[4];
    s32 sp1C;

    // @recomp there is no osContStartQuery implemented in the runtime,
    // this is a check for the presence of the controller pak, likely before any of the pfs implementation
    // in libultra existed, this game supports eeprom saving so we won't be needing it.
    return 0;

    *arg1 = 0;
    osContStartQuery(arg0);
    while (arg0->validCount == 0) {}
    osRecvMesg(arg0, NULL, 0);
    osContGetQuery(sp20);

    for (sp1C = 0; sp1C < 4; sp1C++) {
        if ((sp20[sp1C].status & 1) && (sp20[sp1C].errno == 0)) {
            *arg1 |= 1 << sp1C;
        }
    }

    return sp20[0].errno;
}

RECOMP_PATCH s32 func_hd_front_end_801F76E4(u8* arg0, s32 arg1) {
    // @recomp: This is a check for the integrity of the eeprom save. We will assume that our HDDs will not fail ;)
    return 0;
}
