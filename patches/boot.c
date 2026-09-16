#include "patches.h"
#include "misc_funcs.h"
#include "blast_sched.h"

#define VIDEO_MSG 0
#define RSP_DONE_MSG 1
#define RDP_DONE_MSG 2
#define PRE_NMI_MSG 3
#define RSP_STATE_SUSPENDED 3

#define EXEC_IS_AUDIO 0
#define EXEC_IS_GFX 1

#define ASSERT_MESSAGE "\n\a --- ASSERTION FAULT - %s - %s, line %d\n\n"

s32 func_hd_code_802A1320(void);
void func_hd_code_80271E88(OSSched*);
void __scHandleGfxTask(OSSched*, void*);
void __scExecAudioIfIdle(OSSched*);
void __scRetraceDone(OSSched*);
void __scRspDone(OSSched*);
void __scRdpDone(OSSched*);
void __scExec(OSSched*, s32); /* extern */
void func_hd_front_end_801F58E8(void);
void func_hd_front_end_801F74B0(u8* arg0);
void Thread1(void* arg0);
extern u32 osDpGetStatus(void);
void rmonPrintf(const char* arg0, ...);
s32 func_hd_code_80271A84(OSSched*, OSScTask*); /* extern */
extern void osInitialize(void);
extern void osStartThread(OSThread*);
extern void osCreateThread(OSThread*, OSId, void (*)(void*), void*, void*, OSPri);
s32 __osPiRawStartDma(s32 direction, u32 devAddr, void* dramAddr, u32 size);
extern s32 boot_osPiRawStartDma(s32 direction, u32 devAddr, void* dramAddr, u32 size);
extern void osSyncPrintf(const char* fmt, ...);
extern OSTime osGetTime_recomp(void);
void yield_self_1ms(void);
void __scYield(OSSched* scheduler);
extern OSMesgQueue D_hd_code_80314D80;  // bss
extern OSMesg D_hd_code_80314D98[0xC2]; // bss
extern s64 g_Thread3Stack[0x400];       // size 0x2000;

extern void osSetThreadPri(OSThread*, OSPri);
void Thread3(void* arg0);
extern void osCreatePiManager(OSPri, OSMesgQueue*, OSMesg*, s32);
extern OSMesgQueue dl_complete_queue;
extern OSMesg dl_complete_queue_buf;

extern OSThread g_Thread1;
extern OSThread g_Thread3;
extern u8 g_Thread1Stack[0x200];
extern OSThread D_hd_front_end_80218D30;
extern u8 D_hd_front_end_80218EF8[0x1000];
extern u8 D_hd_front_end_80218740[16][0x28];
extern u8 D_hd_front_end_802189C0[16][0x11];
extern u8 D_hd_front_end_80218AD0[16][0x5];
extern OSPfsState D_hd_front_end_80218B20[16];
extern s32 D_hd_front_end_80218B20_pad;
extern s32 D_hd_front_end_80218D24;
extern s32 D_hd_front_end_80218D28;
extern s32 D_hd_front_end_80218D28_pad;
extern OSThread D_hd_front_end_80218D30;
extern s32 D_hd_front_end_80218EF0;
extern s32 D_hd_front_end_80218EF0_pad;
extern u8 D_hd_front_end_80218EF8[0x1000];
extern OSMesgQueue D_hd_front_end_80219EF8;
extern void* D_hd_front_end_80219F10[8];
extern OSMesgQueue D_hd_front_end_80219F30;
extern void* D_hd_front_end_80219F48;
extern s32 D_hd_front_end_80219F48_pad;
extern OSMesgQueue D_hd_front_end_80219F50;
extern void* D_hd_front_end_80219F68[8];
extern s32 D_hd_front_end_80219F88;
extern s32 D_hd_front_end_80219F88_pad;
extern u8 D_hd_front_end_80219F90[0x20];
extern u8 D_hd_front_end_80219FB0[0x20];
extern u8 D_hd_front_end_8020C000[0x14];
extern OSSched sc;
extern u8 D_hd_front_end_8020C014[8];
extern OSScClient D_hd_front_end_80218EE0;
extern s32 D_hd_code_8036BF10;
extern u32 D_hd_code_8036BFB8;
extern OSTime D_hd_code_8036BEF0;
extern OSTime D_hd_code_8036BEF8;
extern OSTime D_hd_code_8036BF00;
extern s32 D_hd_code_8036BF08;
extern s32 D_hd_code_8036BF0C;
extern OSTimer D_hd_code_8036BF78;
extern s32 D_hd_code_802FA254;
extern OSMesgQueue D_hd_code_803153D8;
extern u8 D_hd_code_8036E68C[4];
extern OSTime D_hd_code_8036BEF0;
extern OSTime D_hd_code_8036BEF8;
extern OSTime D_hd_code_8036BF00;
extern s32 D_hd_code_8036BF08;
extern s32 D_hd_code_8036BF0C;
extern s32 D_hd_code_8036BF10;
extern s32 g_nextRetrace;
extern s32 D_hd_code_8036BF18;
extern OSScTask* g_currentRdpTask;
extern u32 D_hd_code_8036BF20;
extern u32 D_hd_code_8036BF24;
extern u32 bss_pad_8036BF28;
extern u32 D_hd_code_8036BF2C;
extern u32 pad_8036BF30;
extern u32 pad_8036BF34;
extern OSTime D_hd_code_8036BF38;
extern u64 D_hd_code_8036BF40;
extern OSTime D_hd_code_8036BF48;
extern u64 D_hd_code_8036BF50;
extern u8 bss_pad_8036BF58[0x8036BF78 - 0x8036BF58];
extern OSTimer D_hd_code_8036BF78;
extern u8 bss_pad_8036BF98[0x8036BFB8 - 0x8036BF98];
extern u32 D_hd_code_8036BFB8;
extern s32 D_hd_code_8036BFBC;
extern s8 D_hd_code_802FA270;

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

static s32 sPendingDpDone = 0;
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
                break;
            case 4:
                __scExecAudioIfIdle(scheduler);
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


extern OSScTask D_hd_code_8036E698[5][2];
extern u8 D_hd_code_8036E68C[4];
extern void* D_hd_code_8036E660[6];
extern void* D_hd_code_8036E678[5];
extern u64 D_hd_code_80367750;
extern Gfx* g_gfxTaskOutputBuffer;
extern u64 D_hd_code_8036AFB0;
extern u16 D_80000400[][320 * 240]; // framebuffers
extern OSScClient g_gfxClient;
extern u8 D_hd_code_8035805C; // frame double-buffer index (0/1)

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
    // @recomp: remove osWritebackDCache calls
    osSendMesg(&sc.interruptQ, gfxTask, OS_MESG_BLOCK);
}

RECOMP_PATCH void Thread1(void* arg0) {
    osDpSetStatus(DPC_CLR_FREEZE);
    osCreatePiManager(150, &D_hd_code_80314D80, D_hd_code_80314D98, 0xC2);
    osCreateThread(&g_Thread3, 3, Thread3, arg0, (s64*) 0x80310d80 + 0x400, 0xA);
    osStartThread(&g_Thread3);

    // @recomp: remove duplicate osStartThread here

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
