#include "patches.h"
#include "misc_funcs.h"
#include <PR/sched.h>
#include <hd_code/macros.h>
#include <hd_code/functions.h>
#include <hd_code/variables.h>

void func_hd_front_end_801F58E8(void);
void func_hd_front_end_801F74B0(u8* arg0);
extern s32 boot_osPiRawStartDma(s32 direction, u32 devAddr, void* dramAddr, u32 size);
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

JUMPTABLE_FIX
