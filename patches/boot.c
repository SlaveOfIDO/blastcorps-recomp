#include "patches.h"
#include "misc_funcs.h"
#include "sched.h"

#define VIDEO_MSG 0
#define RSP_DONE_MSG 1
#define RDP_DONE_MSG 2
#define PRE_NMI_MSG 3
#define RSP_STATE_SUSPENDED 3

#define ASSERT_MESSAGE "\n\a --- ASSERTION FAULT - %s - %s, line %d\n\n"

s32 func_hd_code_802A1320(void);
void func_hd_code_802712B4(OSSched* arg0, void* arg1);
void func_hd_code_80271E88(OSSched*);
void func_hd_code_802712B4(OSSched*, void*);
void func_hd_code_802712FC(OSSched*);
void func_hd_code_80271358(OSSched*);
void func_hd_code_802715DC(OSSched*);
void func_hd_code_80271904(OSSched*);
void func_hd_front_end_801F58E8(void);
void func_hd_front_end_801F74B0(u8* arg0);
void Thread1(void* arg0);
extern u32 osDpGetStatus(void);
void rmonPrintf(const char* arg0, ...);
extern void osInitialize(void);
extern void osStartThread(OSThread*);
extern void osCreateThread(OSThread*, OSId, void (*)(void*), void*, void*, OSPri);
s32 __osPiRawStartDma(s32 direction, u32 devAddr, void* dramAddr, u32 size);
extern s32 boot_osPiRawStartDma(s32 direction, u32 devAddr, void* dramAddr, u32 size);
extern void osSyncPrintf(const char* fmt, ...);
extern OSTime osGetTime_recomp(void);
void yield_self_1ms(void);
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

RECOMP_PATCH void MainJump() {
    u32 sp74;
    s32 pad[2];
    u32* sp68;
    u32 sp28[0x10];
    s32 pad2[0x2];

    // This does nothing
    // osInitialize();

    // We shouldn't need this, it's some leftover arg parsing for debugging
#if 0
  for (sp68 = (u32*)0xFFB000, sp74 = 0; sp74 < 0x10; sp74++, sp68++) {
    osPiRawReadIo((u32)sp68, &sp28[sp74]);
  }
  func_hd_code_80270AE0(sp28);
#endif
    // D_hd_code_802FA254 = 1;
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

// Since we named osPiGetStatus inside the init portion of the rom InitosPiGetStatus, we're just patching it its
// output here.
RECOMP_PATCH u32 _osPiGetStatus(void) {
    return 0;
}

#if 1
RECOMP_PATCH void __scMain(void* arg0) {
    OSMesg sp34;
    OSSched* sp30;
    OSScClient* sp2C;

    sp30 = arg0;
    while (1) {
        osRecvMesg(&sp30->interruptQ, &sp34, OS_MESG_BLOCK);

        // @recomp error handling code that cheks RSP registers directly, not supported so we disable it.
        if (0 /*!(func_hd_code_802A1320() & 0x1000)*/) {

            for (sp2C = sp30->clientList; sp2C != NULL; sp2C = sp2C->next) {
                osSendMesg(sp2C->msgQ, (void*) 0x29D, 0);
            }
            D_hd_code_8036BF10 = 1;
            osViBlack(1U);
            rmonPrintf("GO %x\n", osDpGetStatus());
            osDpSetStatus(4U);

            // @recomp: Comment out these IO_READ's
            // RCP_STAT_PRINT;
            rmonPrintf("GO %x\n", osDpGetStatus());
            while (1) {};
        }
        switch ((s32) sp34 - 0x29A) {
            case VIDEO_MSG:
                D_hd_code_8036BFB8++;
                if ((D_hd_code_8036BFB8 % 480U) == 0) {
                    D_hd_code_8036BEF8 = D_hd_code_8036BF00;
                    D_hd_code_8036BF08 = D_hd_code_8036BF0C;
                }
                func_hd_code_80271358(sp30);
                break;

            case 4:
                func_hd_code_802712FC(sp30);
                break;

            case RSP_DONE_MSG:
                // @recomp check if we're getting sp30->curRSPTask, trying to prevent a crash if we do
                // while informing via console, these checks should be removed once the game is fully stable.
                if (sp30->curRSPTask != NULL) {
                    func_hd_code_802715DC(sp30);
                } else {
                    rmonPrintf("NULL sp30->curRSPTask!!!!!!!!!!!   RSP   !!!!!!!!!!\n");
                }
                break;
            case RDP_DONE_MSG:
                // @recomp check if we're getting sp30->curRDPTask, trying to prevent a crash if we do
                // while informing via console, these checks should be removed once the game is fully stable.
                if (sp30->curRDPTask != NULL) {
                    func_hd_code_80271904(sp30);
                } else {
                    rmonPrintf("NULL sp30->curRDPTask!!!!!!!!!!!   RDP   !!!!!!!!!!\n");
                }
                break;
            case 5:
                osSendMesg(D_hd_code_8036BF78.mq, D_hd_code_8036BF78.msg, 1);
                break;
            case PRE_NMI_MSG:
                for (sp2C = sp30->clientList; sp2C != NULL; sp2C = sp2C->next) {
                    osSendMesg(sp2C->msgQ, (void*) 0x29D, 0);
                }
                D_hd_code_8036BF10 = 1;
                osViBlack(TRUE);
                rmonPrintf("%x\n", osDpGetStatus());
                osDpSetStatus(4U);
                // @recomp: Comment out these IO_READ's
                // RCP_STAT_PRINT;
                rmonPrintf("%x\n", osDpGetStatus());
                while (1) {}
            case 6:
                rmonPrintf(" *** CPU FAULT *** - UNFREEZING RDP?\n");
                while (osViGetCurrentFramebuffer() != osViGetNextFramebuffer()) {}
                osDpSetStatus(4U);
                while (1) {}
            default:
                func_hd_code_802712B4(sp30, sp34);
                break;
        }
    }
}
#endif

#if 1
RECOMP_PATCH void Thread1(void* arg0) {
    osDpSetStatus(DPC_CLR_FREEZE);
    osCreatePiManager(150, &D_hd_code_80314D80, D_hd_code_80314D98, 0xC2);
    osCreateThread(&g_Thread3, 3, Thread3, arg0, (s64*) 0x80310d80 + 0x400, 0xA);
    osStartThread(&g_Thread3);
    if (0) {
        osStartThread(&g_Thread3);
    }
    osSetThreadPri(0, 0);
    while (1) {}
}
#endif

#if 1
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
#endif