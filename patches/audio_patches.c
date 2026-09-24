#include "patches.h"
#include "misc_funcs.h"
#include <PR/sched.h>
#include <hd_code/macros.h>
#include <hd_code/functions.h>
#include <hd_code/variables.h>

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

JUMPTABLE_FIX
