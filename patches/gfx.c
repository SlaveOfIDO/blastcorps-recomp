#include "patches.h"
#include "misc_funcs.h"
#include <PR/sched.h>
#include <hd_code/macros.h>
#include <hd_code/functions.h>
#include <hd_code/variables.h>

#define VIRTUAL_TO_PHYSICAL(addr) ((uintptr_t) (addr) & 0x1FFFFFFF)
extern void* D_hd_code_8035806C;
extern s16 D_hd_code_80364454; // camera pitch, 0..4095; proposed name: cameraPitch
extern s32 D_hd_code_80364458;
extern Gfx* D_hd_code_80358030[2];
extern Gfx* D_hd_code_80358038[2];
extern Gfx* D_hd_code_80358040[2];
extern Gfx* D_hd_code_80358048[2];
extern u8 D_hd_code_803643DC;
extern s32 D_hd_code_803649F4;
extern s32 D_hd_code_80364A44;
extern u8 D_hd_code_80364A48;
extern s16 D_hd_code_80364A4A;
extern s16 D_hd_code_80364A4C;
extern u8 D_hd_code_80364A4E;
extern u8 D_hd_code_80364A86;
extern u8 D_hd_code_80364AC1;

// @recomp: Enable extended RT64 commands in hdGameFrame
RECOMP_PATCH Gfx* func_hd_code_8024C414(struct Model1* arg0, s32* arg1) {
    Gfx* entry;
    u8 sp194[16];
    u8 sp184[16];
    s32 sp180;

    entry = &arg0->dp[0];

    gEXEnable(entry++);             // @recomp
    gEXSetRefreshRate(entry++, 30); // @recomp

    gSPSegment(entry++, 0x00, 0x00000000);
    gSPSegment(entry++, 0x02, osVirtualToPhysical(arg0));
    gSPSegment(entry++, 0x01, osVirtualToPhysical(D_hd_code_8035806C));
    gSPDisplayList(entry++, D_1000038);
    gSPDisplayList(entry++, D_1000010);
    gDPPipeSync(entry++);
    gDPSetCycleType(entry++, G_CYC_FILL);
    gSPClearGeometryMode(entry++, G_ZBUFFER);
    gDPSetDepthImage(entry++, (s32) D_hd_code_80358058);
    gDPSetColorImage(entry++, G_IM_FMT_RGBA, G_IM_SIZ_16b, 320, (s32) D_hd_code_80358058);
    gDPSetFillColor(entry++, 0xFFFCFFFC);
    gDPFillRectangle(entry++, 0, 0, 319, 239);

    guTranslate(&arg0->modelview, 0.f, 0.f, 0.f);
    guOrtho(&arg0->mtx1, 0, 319.f, 239.f, 0.0f, -20000.0f, 20000.0f, 1.0f);
    guOrtho(&arg0->mtx2, 0, 1279.f, 959.f, 0.0f, -20000.0f, 20000.0f, 1.0f);
    func_hd_code_802507C8(&arg0->projection2, &arg0->lookAt, &arg0->unk180);

    gDPSetColorImage(entry++, G_IM_FMT_RGBA, G_IM_SIZ_16b, 320, D_hd_code_80358050[D_hd_code_8035805C]);
    entry = func_hd_code_80271FD0(entry, arg0, g_currentLevel, D_hd_code_80364452, (s32) D_hd_code_80364454, &sp180);

    gDPPipeSync(entry++);
    gDPSetCycleType(entry++, G_CYC_FILL);

    switch (g_currentLevel) {
        case 0xD:
        case 0xE:
        case 0x10:
        case 0x34:
            gDPSetFillColor(entry++, 0xD55FD55F);
            break;
        case 0xF:
            gDPSetFillColor(entry++, 0x10511051);
            break;
        default:
            gDPSetFillColor(entry++, 0x00010001);
            break;
    }
    gDPPipeSync(entry++);

    gDPFillRectangle(entry++, 0, (sp180 < 1 ? 0 : (sp180 - 1)), 319, 239);
    gDPPipeSync(entry++);

    gSPLookAt(entry++, &D_2000000.lookAt);
    gSPMatrix(entry++, &D_2000000.projection, G_MTX_NOPUSH | G_MTX_LOAD | G_MTX_PROJECTION);
    gSPMatrix(entry++, &D_2000000.projection2, G_MTX_NOPUSH | G_MTX_MUL | G_MTX_PROJECTION);
    gSPMatrix(entry++, &D_2000000.modelview, G_MTX_NOPUSH | G_MTX_LOAD | G_MTX_MODELVIEW);
    gSPPerspNormalize(entry++, D_hd_code_8035807C);

    switch (g_currentGameState) {
        case 0x40:
        case 0x400:
            guPerspective(&arg0->projection, &D_hd_code_8035807C, D_hd_code_80364438, ASPECT_RATIO, 10.0f, 20000.0f,
                          1.0f);
            break;
        case 0x01:
        case 0x800:
        case 0x1000:
            guPerspective(&arg0->projection, &D_hd_code_8035807C, D_hd_code_80364438, ASPECT_RATIO, 10.0f, 10000.0f,
                          1.0f);
            break;
        default:
            guPerspective(&arg0->projection, &D_hd_code_8035807C, D_hd_code_80364438, ASPECT_RATIO, 10.0f, 10000.0f,
                          1.0f);
            break;
    }

    gDPSetColorDither(entry++, G_CD_MAGICSQ);
    gSPClipRatio(entry++, FRUSTRATIO_3);
    func_hd_code_8027F1F8(&entry, D_hd_code_8035805C, 0);

    gSPSegment(entry++, 0x08, VIRTUAL_TO_PHYSICAL(D_hd_code_80364458));
    gSPClearGeometryMode(entry++, 0xFFFFFFFF);

    gSPDisplayList(entry++, osVirtualToPhysical(D_hd_code_80358030[D_hd_code_8035805C]));
    gSPDisplayList(entry++, (s32) D_hd_code_803BE6E0);
    gSPClearGeometryMode(entry++, 0xFFFFFFFF);
    gSPSetGeometryMode(entry++, G_ZBUFFER);
    gSPDisplayList(entry++, osVirtualToPhysical(D_hd_code_80358038[D_hd_code_8035805C]));
    gSPDisplayList(entry++, (s32) D_hd_code_803BE6E4);

    if ((D_hd_code_803643D6 == 0) && (D_hd_code_803643D7 == 0)) {
        gSPClearGeometryMode(entry++, 0xFFFFFFFF);
        gSPSetGeometryMode(entry++, G_ZBUFFER | G_SHADE | G_CULL_BACK | G_LOD | G_SHADING_SMOOTH);

        gSPDisplayList(entry++, &D_2000000.unk21410);
        gDPPipeSync(entry++);
    }
    switch (D_hd_code_8035805C) { /* irregular */
        case 0:
            gSPSegment(entry++, 0x0A, osVirtualToPhysical(D_hd_code_803F7820));
            break;
        case 1:
            gSPSegment(entry++, 0x0A, osVirtualToPhysical(D_hd_code_803F7824));
            break;
    }
    gDPPipeSync(entry++);
    gSPSetGeometryMode(entry++, G_ZBUFFER | G_SHADE | G_CULL_BACK | G_SHADING_SMOOTH);
    gDPSetCycleType(entry++, G_CYC_1CYCLE);
    gDPSetCombineMode(entry++, G_CC_SHADE, G_CC_SHADE);
    gSPDisplayList(entry++, &D_2000000.unkA4E0);

    if (!(g_currentGameState & 0x440)) {
        func_hd_code_8027C4C8(&entry, arg0);
    }
    func_hd_code_802502EC();
    func_hd_code_8024E4F4(&entry, arg0, 0);
    func_hd_code_80258B78(&entry, arg0);
    if ((D_hd_code_802E8BD0 == 0) && (D_hd_code_80364AA8 != 0x40) && !(g_currentGameState & 0x440) &&
        (D_hd_code_80364A84 == 0)) {
        func_hd_code_80279EE8(&entry, arg0, D_hd_code_8035805C);
    }
    gSPClearGeometryMode(entry++, 0xFFFFFFFF);
    gSPSetGeometryMode(entry++, G_ZBUFFER | G_SHADE | G_CULL_BACK | G_LOD | G_SHADING_SMOOTH);
    gSPDisplayList(entry++, &D_2000000.unkA580);

    gDPPipeSync(entry++);

    entry = func_hd_code_802CEEFC(entry, D_hd_code_8035805C, &arg0->unkA3A0, &arg0->unk11C0);
    func_hd_code_8024E4F4(&entry, arg0, 1);
    if (D_hd_code_803643DC != 0) {
        func_hd_code_8024F520(&entry, arg0);
    }
    func_hd_code_802701A8(&entry, arg0);
    func_hd_code_80281E44(&entry);
    func_hd_code_8028E9E4(&entry, arg0);
    func_hd_code_802917B0(&entry, arg0);
    func_hd_code_80292EB8(&entry, arg0);
    func_hd_code_8028CB30(&entry, arg0);
    switch (D_hd_code_8035805C) { /* switch 1; irregular */
        case 0:                   /* switch 1 */
            gSPDisplayList(entry++, osVirtualToPhysical(&D_hd_code_803C5770));
            break;
        case 1: /* switch 1 */
            gSPDisplayList(entry++, osVirtualToPhysical(&D_hd_code_803C6370));
            break;
    }
    func_hd_code_80288DF0(&entry, D_hd_code_8035805C);
    if (!(g_currentGameState & 2) || D_hd_code_802E8BF0 == 0) {
        func_hd_code_8024FC2C(&entry, 0);
    }
    func_hd_code_802976E8(&entry);

    gSPClearGeometryMode(entry++, 0xFFFFFFFF);
    gSPSetGeometryMode(entry++, G_ZBUFFER);
    gSPDisplayList(entry++, osVirtualToPhysical(D_hd_code_80358040[D_hd_code_8035805C]));
    gSPDisplayList(entry++, (s32) D_hd_code_803BE6E8);
    if (!(g_currentGameState & 2) || D_hd_code_802E8BF0 == 0) {
        func_hd_code_8024FC2C(&entry, 1);
    }

    gSPClearGeometryMode(entry++, 0xFFFFFFFF);
    gSPSetGeometryMode(entry++, G_ZBUFFER);
    gSPDisplayList(entry++, osVirtualToPhysical(D_hd_code_80358048[D_hd_code_8035805C]));
    gSPDisplayList(entry++, (s32) D_hd_code_803BE6EC);

    gSPClearGeometryMode(entry++, 0xFFFFFFFF);
    gSPSetGeometryMode(entry++, G_ZBUFFER | G_SHADE | G_CULL_BACK | G_LOD | G_SHADING_SMOOTH);
    gSPDisplayList(entry++, &D_2000000.unkA918);
    gDPPipeSync(entry++);

    if ((D_hd_code_803643D6 == 0) && (D_hd_code_803643D7 == 0)) {
        gSPClearGeometryMode(entry++, 0xFFFFFFFF);
        gSPSetGeometryMode(entry++, G_ZBUFFER | G_SHADE | G_CULL_BACK | G_LOD | G_SHADING_SMOOTH);
        gSPDisplayList(entry++, &D_2000000.unk21478);
        gDPPipeSync(entry++);
    }
    if ((!(g_currentGameState & 2)) || (D_hd_code_802E8BF0 == 0)) {
        func_hd_code_8024FC2C(&entry, 2);
    }
    func_hd_code_80295120(&entry, arg0);
    if ((g_currentGameState & 0x2000001000003905)) {
        func_hd_code_80280F34(&entry, D_hd_code_8035805C);
    }
    func_hd_code_8027F1F8(&entry, D_hd_code_8035805C, 1);
    func_hd_code_8024E4F4(&entry, arg0, 2);
    if (D_hd_code_803643DC != 0) {
        func_hd_code_80266248(&entry, arg0);
    }
    switch (D_hd_code_8035805C) { /* switch 2; irregular */
        case 0:                   /* switch 2 */
            gSPDisplayList(entry++, osVirtualToPhysical(&D_hd_code_803C6F70));
            break;
        case 1: /* switch 2 */
            gSPDisplayList(entry++, osVirtualToPhysical(&D_hd_code_803C7B70));
            break;
    }
    if (D_hd_code_803643DB != 0) {
        func_hd_code_8028273C(&entry, D_hd_code_8035805C);
    }
    if ((D_hd_code_80364A68 != 0) && (g_currentGameState & 0x104)) {
        func_hd_code_80286C60(&entry, arg0, D_hd_code_8035805C, D_hd_code_80364456);
    }
    if ((g_currentGameState & 0x200000000400220C)) {
        func_hd_code_80278324(&entry, arg0, D_hd_code_8035805C);
    }
    if ((g_currentGameState == 0x100) && (D_hd_code_803643DB != 0)) {
        func_hd_code_80276E50(&entry, arg0, D_hd_code_8035805C, D_hd_code_803643E0, D_hd_code_803643E4,
                              D_hd_code_803643E8);
    }
    func_hd_code_80259450();
    if ((D_hd_code_80364A6A != 0) && ((g_currentGameState & 0x104))) {
        func_hd_code_80287530(&entry, arg0, D_hd_code_8035805C, D_hd_code_80364456);
    }
    if ((D_hd_code_80364A6C != 0) && ((g_currentGameState & 0x104))) {
        func_hd_code_80287C68(&entry, arg0, D_hd_code_8035805C, D_hd_code_80364456);
    }
    if ((g_currentGameState & 0x104)) {
        func_hd_code_80282224(&entry, D_hd_code_80364456);
    }
    if ((D_hd_code_80364AA8 & 1) && ((g_currentGameState & 0x0400030C))) {
        func_hd_code_8026A378(D_hd_code_803649F4, &sp194[1]);
        sp194[0] = 0x24;
        func_hd_code_80259CCC(arg0, &sp194, NULL, 1, 0, 0x118, 0x12, 0x14, 0x14, 0, 0xFF, 0xFF, 0xFF,
                              (s32) D_hd_code_80367BD0.unk6);
        if ((D_hd_code_80364A44 != 0) && (D_hd_code_802E8BD0 == 0)) {
            func_hd_code_8026A378(D_hd_code_80364A44, &sp184[1]);
            sp184[0] = 0x24;
            func_hd_code_80259CCC(arg0, &sp184, NULL, 1, 0, (s32) D_hd_code_80364A4A, (s32) D_hd_code_80364A4C, 0x23,
                                  0x23, (s32) D_hd_code_80364A4E, 0xFF, 0xFF, 0xFF, D_hd_code_80364A48);
        }
    }
    if ((g_currentGameState & 0x2000000000000104) &&
        (!(D_hd_code_80364AA8 & 0x81) || (D_hd_code_803643DB != 0) || (D_hd_code_80364AC1 != 0))) {
        func_hd_code_80275478(arg0, &entry,
                              g_currentGameState & 0x100 || D_hd_code_8036BB18 == 0x4D || D_hd_code_8036BB18 == 0x49);
    }
    if ((g_nextGameState == 0) && (areWeFading() == 0)) {
        if (!(g_currentGameState & 0x200000100400230C) &&
            ((u32) ((u32) (((u32) sc.retraceCount % 50U) * 0x3C) / 60U) >= 0x15U) && (D_hd_code_8036BB1C == 1) &&
            ((!(g_currentGameState & 2)) ||
             ((D_hd_code_802E8BEC != 0) && ((D_hd_code_80366A12 == 3) || (D_hd_code_802E8BEC == 1)))) &&
            ((g_currentGameState != 0x100000000000) || (D_hd_code_803A6B04 != 0)) &&
            ((!(g_currentGameState & 0x1801)) || (players[playerNumber].unk91 != 0)) && (g_currentLevel != 0x2F)) {
            func_hd_code_80259CCC(arg0, "PRESS START", NULL, 1, 0, 0x5C, 0xC4, 0x1A, 0x1A, 1, 0xFF, 0xFF, 0xFF, 0xFF);
        }
        if ((u32) ((u32) (((u32) sc.retraceCount % 40U) * 60) / 60U) >= 16U) {
            if (D_hd_code_802E8BD0 != 0) {
                if ((g_currentGameState == 0x2000000000000000) && (D_hd_code_8036BB1C == 2)) {
                    func_hd_code_80259CCC(arg0, "USE Z/R TO TURN PAGES", D_hd_code_8030491C, 0, 0, 0x18, 0x14, 0xF, 0xF,
                                          1, 0xFF, 0xFF, 0xFF, 0xFF);
                } else if ((g_currentGameState == 0x100) && (D_hd_code_8036BB18 == 0) && (D_hd_code_8036BB1C == 2) &&
                           (D_hd_code_803643DB != 0) && !(g_currentButtons & (Z_TRIG | R_TRIG))) {
                    func_hd_code_80259CCC(arg0, "USE Z/R TO MOVE MAP", D_hd_code_80304938, 0, 0, 0x18, 0x14, 0xF, 0xF,
                                          1, 0xFF, 0xFF, 0xFF, 0xFF);
                }
            } else if ((g_currentGameState == 0x100)) {
                if (D_hd_code_80364AC1 != 0) {
                    func_hd_code_80259CCC(arg0, "SHUTTLE VIEW", D_hd_code_80304904, 0, 0, 0x18, 0x14, 0xF, 0xF, 1, 0xFF,
                                          0xFF, 0xFF, 0xFF);
                } else {
                    func_hd_code_80259CCC(arg0, "MISSILE VIEW", D_hd_code_80304910, 0, 0, 0x18, 0x14, 0xF, 0xF, 1, 0xFF,
                                          0xFF, 0xFF, 0xFF);
                }
            }
        }
    }
    if (((g_currentGameState & 0x440) || (g_currentLevel == 0x26)) && (D_hd_code_8036BB1C == 1) &&
        (areWeFading() == 0)) {
        if (((g_currentGameState & 0x440)) && (D_hd_code_80364AA8 != 1)) {
            func_hd_code_80274B40(&entry, arg0, D_hd_code_80365580, 0x108, 0x12);
        } else {
            func_hd_code_80274B40(&entry, arg0, D_hd_code_80365580, 0x18, 0x12);
        }
    }
    if (((g_currentGameState & 0x104)) && (D_hd_code_80364410 != 0)) {
        func_hd_code_80274B40(&entry, arg0, D_hd_code_80364A86, 0x108, 0xBE);
    }
    if (((g_currentGameState & 0x104)) && (D_hd_code_80364AA8 == 1) && (D_hd_code_802E8BD0 == 0)) {
        func_hd_code_80285CC0();
    }
    if ((D_hd_code_803643DB != 0) && (g_currentGameState == 4)) {
        func_hd_code_80282C80(&entry, arg0, D_hd_code_803643E0, D_hd_code_803643E4, D_hd_code_803643E8,
                              D_hd_code_803EF6DC, D_hd_code_803EF6E0, D_hd_code_803EF6E4);
    }
    if ((D_hd_code_802E8F94[g_currentLevel].unk0 & 0x81) && (g_currentGameState == 4)) {
        if (g_currentLevel != 0x32 ||
            ((players[playerNumber].unk18[0x32] > 0 && players[playerNumber].unk18[0x32] < 6) ? 1 : 0)) {
            func_hd_code_8028376C(&entry, arg0, D_hd_code_8035805C, D_hd_code_803643E0, D_hd_code_803643E8,
                                  D_hd_code_803EF6DC, D_hd_code_803EF6E4);
        }
    }
    if ((D_hd_code_803643DB != 0) || (D_hd_code_80364AC1 != 0)) {
        switch (g_currentGameState) {
            case 0x4:
            case 0x100000000000:
            case 0x100:
            case 0x200:
                func_hd_code_8025E2CC(&entry, arg0, D_hd_code_8035805C);
                func_hd_code_8025E67C(&entry, arg0, D_hd_code_8035805C);
            case 0x400:
            case 0x40:
                if (((D_hd_code_803643D6 != 0) || (D_hd_code_803643D7 != 0) || (D_hd_code_803643D9 != 0) ||
                     (D_hd_code_803643DA != 0)) &&
                    ((g_currentGameState & 0x144))) {
                    func_hd_code_802A45D4(0x32);
                    if (g_currentGameState == 0x40) {
                        g_nextGameState = 1024;
                    } else {
                        g_nextGameState = 512;
                    }
                }
                break;
        }
    }
    func_hd_code_80259C24(&entry, arg0);
    *arg1 = (s32) (((s32) entry - (s32) arg0) - 0x48B0) >> 3;
    return entry;
}

extern u8 D_hd_code_80364AC1;
extern u8 D_hd_code_803649EC;
extern u8 D_hd_code_803156F5;
// @recomp: Tag Vehicle transforms like wheels. Prevents wobbly wheels
RECOMP_PATCH void func_hd_code_8024FC2C(Gfx** arg0, u8 arg1) {
    Gfx* entry;
    s32 sp60;
    u8 pad;
    u8 sp5E;
    u8 sp5D;

    entry = *arg0;

    sp5D = D_hd_code_803649E8 == 0 && (D_hd_code_803649EC != 0 || g_currentGameState & 0x1801);
    sp60 = 0;
    while (&D_hd_code_80364460[sp60] != D_hd_code_803649D0) {
        if (((D_hd_code_80364460[sp60].unk5C != 0) || (sp5D != 0)) &&
            ((D_hd_code_80364460[sp60].unk5C != 0xFF) || (D_hd_code_803EF6FF == 0)) &&
            ((D_hd_code_80364460[sp60].unk5C == 0xFD) || (D_hd_code_80364A84 == 0) || (D_hd_code_80364AC1 == 0))) {

            // @recomp Tag the transform.
            gEXMatrixGroupSimpleNormal(entry++, (u32) &D_hd_code_80364460[sp60] | arg1 << 24, G_EX_PUSH,
                                       G_MTX_MODELVIEW, G_EX_EDIT_ALLOW);

            gSPSegment(entry++, 0x06, osVirtualToPhysical((void*) D_hd_code_80364460[sp60].unk0));
            if (((g_currentGameState & 0x1801)) &&
                (((D_hd_code_80364460[sp60].unk5C == 0xFE)) || (D_hd_code_80364460[sp60].unk5C == 0))) {
                sp5E = D_hd_code_8035805C;
            } else {
                sp5E = D_hd_code_803156F5;
            }
            if (sp5E != 0) {
                gSPSegment(entry++, 0x07, osVirtualToPhysical((void*) D_hd_code_80364460[sp60].unk4));
            } else {
                gSPSegment(entry++, 0x07, osVirtualToPhysical((void*) D_hd_code_80364460[sp60].unk8));
            }
            gDPPipeSync(entry++);
            gDPSetEnvColor(entry++, 0x00, 0x00, 0x00, D_hd_code_80364460[sp60].unk60);
            gSPClearGeometryMode(entry++, 0xFFFFFFFF);
            if ((D_hd_code_803643D6 != 0) && !(D_hd_code_80364AA8 & 0x81) &&
                (D_hd_code_80364460[sp60].unk5C == D_hd_code_80364456)) {
                gSPMatrix(entry++, &D_2000000.unk1500, G_MTX_NOPUSH | G_MTX_LOAD | G_MTX_MODELVIEW);
            }
            if (sp5E != 0) {
                switch (arg1) { /* switch 1; irregular */
                    case 0:     /* switch 1 */
                        gSPDisplayList(entry++, osVirtualToPhysical((void*) D_hd_code_80364460[sp60].unkC));
                        break;
                    case 1: /* switch 1 */
                        gSPDisplayList(entry++, osVirtualToPhysical((void*) D_hd_code_80364460[sp60].unk10));
                        break;
                    case 2: /* switch 1 */
                        gSPDisplayList(entry++, osVirtualToPhysical((void*) D_hd_code_80364460[sp60].unk14));
                        break;
                }
            } else {
                switch (arg1) { /* irregular */
                    case 0:
                        gSPDisplayList(entry++, osVirtualToPhysical((void*) D_hd_code_80364460[sp60].unk30));
                        break;
                    case 1:
                        gSPDisplayList(entry++, osVirtualToPhysical((void*) D_hd_code_80364460[sp60].unk34));
                        break;
                    case 2:
                        gSPDisplayList(entry++, osVirtualToPhysical((void*) D_hd_code_80364460[sp60].unk38));
                        break;
                }
            }
            gSPMatrix(entry++, &D_2000000.modelview, G_MTX_NOPUSH | G_MTX_LOAD | G_MTX_MODELVIEW);

            // @recomp Pop the transform id.
            gEXPopMatrixGroup(entry++, G_MTX_MODELVIEW);
        }
        sp60++;
    }
    *arg0 = entry;
}