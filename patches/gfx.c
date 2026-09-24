#include "patches.h"
#include "misc_funcs.h"
#include "gfx_tagging.h"
#include <PR/sched.h>
#include <hd_code/macros.h>
#include <hd_code/functions.h>
#include <hd_code/variables.h>
#include <hd_code/yoshi.h>

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
    // @recomp: make rectangle fill whole frame
    gDPFillRectangle(entry++, 0, 0, 320, 240);

    guTranslate(&arg0->modelview, 0.f, 0.f, 0.f);
    // @recomp: make both orthos fill the whole frame
    guOrtho(&arg0->mtx1, 0, 320.f, 240.f, 0.0f, -20000.0f, 20000.0f, 1.0f);
    guOrtho(&arg0->mtx2, 0, 1280.f, 960.f, 0.0f, -20000.0f, 20000.0f, 1.0f);
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

    // @recomp: make rectangle fill whole frame
    gDPFillRectangle(entry++, 0, (sp180 < 1 ? 0 : (sp180 - 1)), 320, 240);
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
            gEXMatrixGroupSimpleNormal(entry++, TAG_VEHICLE(D_hd_code_80364460, arg1), G_EX_PUSH,
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

#define qu016(n) ((u16) ((n) * 0x10000))
extern s32 D_hd_code_803F7660;
extern u16 D_hd_code_802FCEB0[32 * 32];
extern Vtx D_hd_code_802FD9B8[10];


// @recomp: missile carrier arrow. wobbles in-game. This is fixed with tagging
RECOMP_PATCH void func_hd_code_80282C80(Gfx** gfx, struct Model1* arg1, s32 arg2, s32 arg3, s32 arg4, s32 arg5, s32 arg6, s32 arg7) {
    Gfx* entry = *gfx;
    f32 sp130;
    f32 sp12C;
    u8 sp12B;
    u8 sp12A;
    s16 sp128;
    f32 spE8[4][4];
    f32 spA8[4][4];
    s32 spA4;
    s32 spA0;
    u8 sp9F;

    arg2 >>= 5;
    arg3 >>= 5;
    arg4 >>= 5;
    arg5 >>= 5;
    arg6 >>= 5;
    arg7 >>= 5;

    spA4 = D_hd_code_803F7670 >> 5;
    spA0 = D_hd_code_803F7678 >> 5;
    sp130 = sqrtf((((spA4 - arg2) * (spA4 - arg2)) + ((spA0 - arg4) * (spA0 - arg4))));
    if (sp130 < 1.0) {
        sp130 = 1.0f;
    }
    if ((spA4 >= arg2) && (spA0 >= arg4)) {
        sp12C = (func_hd_code_802AD7D4((s32) (((spA4 - arg2) / sp130) * 65536.0)) >> 4);
    }
    if ((spA4 >= arg2) && (spA0 < arg4)) {
        sp12C = ((func_hd_code_802AD7D4((s32) (((arg4 - spA0) / sp130) * 65536.0)) >> 4) + 0x400);
    }
    if ((spA4 < arg2) && (spA0 < arg4)) {
        sp12C = ((func_hd_code_802AD7D4((s32) (((arg2 - spA4) / sp130) * 65536.0)) >> 4) + 0x800);
    }
    if ((spA4 < arg2) && (spA0 >= arg4)) {
        sp12C = ((func_hd_code_802AD7D4((s32) (((spA0 - arg4) / sp130) * 65536.0)) >> 4) + 0xC00);
    }
    sp12C = (sp12C * 0.08791208791208792);
    sp12C = ((360.0 - sp12C) - 45.0);
    sp12C = (sp12C + (((D_hd_code_80364452 * 360.0) / 4095.0) - 135.0));
    sp130 = sqrtf((((arg5 - spA4) * (arg5 - spA4)) + ((arg7 - spA0) * (arg7 - spA0))));
    if (sp130 > 1500.0f) {
        sp12A = 0xFF;
        sp12B = 0;
    } else if (sp130 < 500.0f) {
        sp12B = 0xFF;
        sp12A = 0;
    } else {
        sp128 = (s16) (s32) (((sp130 - 500.0f) / 1000.0f) * 511.0f);
        if ((s16) sp128 < 0x100) {
            sp12A = sp128, sp12B = 0xFF;
        } else {
            sp12A = 0xFF, sp12B = 0x1FE - sp128;
        }
    }
    if (sp130 < 250.0f) {
        sp9F = 1;
    } else {
        sp9F = 0;
    }

    if ((((D_hd_code_803156C4 % 30U) >= 0x10U) || (sp9F == 0)) && (D_hd_code_803F7660 != 0x98967F)) {
        guAlignF(spE8, 20.0f, 1.0f, 0.0f, 0.0f);
        guAlignF(spA8, -sp12C, 0.0f, 0.0f, 1.0f);
        guMtxCatF(spE8, spA8, spE8);
        guTranslateF(spA8, -150.0f, -230.0f, -800.0f);
        guMtxCatF(spE8, spA8, spE8);
        guMtxF2L(spE8, (Mtx*) arg1->unk1580);
        // @recomp Tag the transform.
        gEXMatrixGroupDecomposedNormal(entry++, TAG_MISSILE_ARROW, G_EX_PUSH, G_MTX_PROJECTION, G_EX_EDIT_ALLOW);

        gSPMatrix(entry++, (u32) &D_2000000.projection, G_MTX_NOPUSH | G_MTX_LOAD | G_MTX_PROJECTION);
        gSPPerspNormalize(entry++, D_hd_code_8035807C);


        gSPMatrix(entry++, D_2000000.unk1580, G_MTX_NOPUSH | G_MTX_LOAD | G_MTX_MODELVIEW);
        gSPClearGeometryMode(entry++, G_ZBUFFER | G_TEXTURE_ENABLE | G_SHADE | G_CULL_BOTH | G_FOG | G_LIGHTING |
                                          G_TEXTURE_GEN | G_TEXTURE_GEN_LINEAR | G_LOD | G_SHADING_SMOOTH | 0xFFE0CDF8);
        gSPSetGeometryMode(entry++, G_SHADE | G_CULL_FRONT | G_LIGHTING | G_TEXTURE_GEN | G_SHADING_SMOOTH);
        gDPPipeSync(entry++);
        gDPSetCycleType(entry++, G_CYC_1CYCLE);

        if (D_hd_code_80367BD6 == 0xFF) {
            gDPSetRenderMode(entry++, G_RM_RA_OPA_SURF, G_RM_RA_OPA_SURF2);
        } else {
            gDPSetRenderMode(entry++, G_RM_AA_XLU_SURF, G_RM_AA_XLU_SURF2);
        }
        gDPSetCombineMode(entry++, G_CC_MODULATEIA_PRIM, G_CC_MODULATEIA_PRIM);

        gDPSetPrimColor(entry++, 0, 0, sp12B, sp12A, 0, D_hd_code_80367BD6);
        gSPTexture(entry++, qu016(0.03028), qu016(0.03028), 0, G_TX_RENDERTILE, G_ON);
        gDPLoadTextureBlock(entry++, OS_PHYSICAL_TO_K0(&D_hd_code_802FCEB0), G_IM_FMT_RGBA, G_IM_SIZ_16b, 32, 32, 0,
                            G_TX_NOMIRROR | G_TX_CLAMP, G_TX_NOMIRROR | G_TX_CLAMP, G_TX_NOMASK, G_TX_NOMASK,
                            G_TX_NOLOD, G_TX_NOLOD);
        gSPVertex(entry++, osVirtualToPhysical(D_hd_code_802FD9B8), 10, 0);
        gSP1Triangle(entry++, 0, 1, 2, 0);
        gSP1Triangle(entry++, 0, 2, 3, 0);
        gSP1Triangle(entry++, 3, 1, 0, 0);
        gSP1Triangle(entry++, 1, 4, 2, 0);
        gSP1Triangle(entry++, 4, 5, 2, 0);
        gSP1Triangle(entry++, 5, 3, 2, 0);
        gSP1Triangle(entry++, 6, 7, 8, 0);
        gSP1Triangle(entry++, 9, 6, 8, 0);
        gSP1Triangle(entry++, 7, 9, 8, 0);
        gDPPipeSync(entry++);

        // @recomp Pop the transform id.
        gEXPopMatrixGroup(entry++, G_MTX_PROJECTION);
    }
    *gfx = entry;
}

// @recomp: white-out fade is not full-screen. fixed this by tagging this
RECOMP_PATCH void func_hd_code_8025E67C(Gfx** arg0, struct Model1* arg1, u8 arg2) {
    Gfx* entry;
    u32 sp60;
    u32 sp5C;
    u32 sp58;
    u32 pad54;
    u32 sp50;

    entry = *arg0;
    sp60 = sc.retraceCount;
    if (D_hd_code_803643D6 != 0) {
        if (D_hd_code_803643D8 == 0) {
            sndDeactivateAllSfxByFlag_1();
            func_hd_code_802C1DD0(D_hd_code_802E8F94[g_currentLevel].unk0 == 0x20 ||
                                  D_hd_code_802E8F94[g_currentLevel].unk0 == 0x80);
            switch (g_currentLevel) { /* switch 1; irregular */
                case 49:              /* switch 1 */
                    sndPlaySfx(D_hd_code_80367738, 0x31U, NULL);
                    func_hd_code_80261570(0.0f);
                    break;
                case 50: /* switch 1 */
                    D_hd_code_8036BB1A = -1;
                    func_hd_code_8026AF6C(0xA00EU);
                    func_hd_code_80261570(0.0f);
                    break;
                default: /* switch 1 */
                    sndPlaySfx(D_hd_code_80367738, 0x31U, NULL);
                    D_hd_code_802E8BD8 = 1;
                    if ((D_hd_code_8036BB18 != -1) || (func_hd_code_8026B10C() != 0)) {
                        func_hd_code_8026AF6C(0x4000U);
                    }
                    D_hd_code_8036BB1A = -1;
                    func_hd_code_80261570(0.0f);
                    break;
            }
            D_hd_code_80366BB8 = sp60;
            D_hd_code_80366BC4.unk1 = 0U;
        }
        sp5C = sp60 - D_hd_code_80366BB8;
        if (sp5C >= 0xB4U) {
            switch (g_currentLevel) { /* switch 2; irregular */
                case 49:              /* switch 2 */
                    if (D_hd_code_80366BC4.unk1 == 0) {
                        sndPlaySfx(D_hd_code_80367738, 0x32U, NULL);
                        D_hd_code_80366BC4.unk1 = 1U;
                    }
                    break;
                case 50: /* switch 2 */
                    if ((D_hd_code_8036BB1C == 1) && (areWeFading() == 0)) {
                        if ((((s32) players[playerNumber].unk18[g_currentLevel] > 0) &&
                                     ((s32) players[playerNumber].unk18[g_currentLevel] < 6)
                                 ? 1
                                 : 0) != 0) {
                            func_hd_code_80275390(0x08000000);
                        } else {
                            func_hd_code_80275390(0x40);
                        }
                    }
                    break;
                default: /* switch 2 */
                    if (D_hd_code_80366BC4.unk1 == 0) {
                        sndPlaySfx(D_hd_code_80367738, 0x32U, NULL);
                        D_hd_code_80366BC4.unk1 = 1U;
                    }

                    gEXMatrixGroupSkipAllAspect(entry++, TAG_FADE_SCREEN, G_EX_PUSH, G_MTX_PROJECTION, G_EX_EDIT_ALLOW,
                                                G_EX_ASPECT_STRETCH); // @recomp: force stretching
                    
                    gSPMatrix(entry++, &D_2000000.mtx1, G_MTX_NOPUSH | G_MTX_LOAD | G_MTX_PROJECTION);
                    gSPMatrix(entry++, &D_2000000.modelview, G_MTX_NOPUSH | G_MTX_LOAD | G_MTX_MODELVIEW);
                    gDPPipeSync(entry++);
                    gDPSetRenderMode(entry++, G_RM_CLD_SURF, G_RM_CLD_SURF2);
                    gDPSetCombineMode(entry++, G_CC_SHADE, G_CC_SHADE);
                    gSPSetGeometryMode(entry++, G_SHADE | G_SHADING_SMOOTH);
                    gSPTexture(entry++, qu016(0.999985), qu016(0.999985), 0, G_TX_RENDERTILE, G_OFF);
                    gSPVertex(entry++, OS_PHYSICAL_TO_K0(&D_hd_code_802FA8B0[arg2]), 4, 0);
                    gSP1Triangle(entry++, 0, 1, 2, 0);
                    gSP1Triangle(entry++, 0, 2, 3, 0);
                    gDPPipeSync(entry++);
                    gEXPopMatrixGroup(entry++, G_MTX_PROJECTION); // @recomp: reset stretching


                    if (!areWeFading()) {
                        if ((sp60 - D_hd_code_80366BB8) - 0xB4 < 0x5AU) {
                            sp50 = (u32) (((sp60 - D_hd_code_80366BB8) - 0xB4) * 2.8333333333333335);
                            for (sp5C = 0; sp5C < 4U; sp5C++) {
                                for (sp58 = 0; sp58 < 4U; sp58++) {
                                    D_hd_code_802FA8B0[arg2].v[sp5C].v.cn[sp58] = sp50;
                                }
                            }
                        } else if ((u32) ((sp60 - D_hd_code_80366BB8) - 0x10E) >= 0x2EU) {
                            if ((g_currentGameState == 0x100000000000)) {
                                g_nextGameState = 0x200000000000;
                            } else {
                                if ((((s32) players[playerNumber].unk18[g_currentLevel] > 0) &&
                                     ((s32) players[playerNumber].unk18[g_currentLevel] < 6))
                                        ? 1
                                        : 0 != 0) {
                                    func_hd_code_80275390(0x08000000);
                                } else {
                                    func_hd_code_80275390(0x40);
                                }
                            }
                        } else {
                            for (sp5C = 0; sp5C < 4U; sp5C++) {
                                for (sp58 = 0; sp58 < 4U; sp58++) {
                                    D_hd_code_802FA8B0[arg2].v[sp5C].v.cn[sp58] = 0xFF;
                                }
                            }
                        }
                    }
                    break;
            }
        }
    }
    *arg0 = entry;
}

extern u16 D_hd_code_802FA8A0[2];
extern f32 D_hd_code_8036BFC0;
extern u8 D_hd_code_8036BFC4;
extern u8 D_hd_code_8036BFC5;
extern f32 D_hd_code_8036BFC8;
extern f32 D_hd_code_8036BFCC;
extern f32 D_hd_code_8036BFD0;
extern Vtx D_hd_code_802FA820[2][4];
extern struct S_802FA280 D_hd_code_802FA280[60][2];
#define qu102(n) ((u16) ((n) * 0x0004))
// @recomp: The sky-quad (yes no skybox) is tied to 4:3 ratio. This code fixes it for all aspect ratios
RECOMP_PATCH Gfx* func_hd_code_80271FD0(Gfx* arg0, struct Model1* arg1, u16 arg2, s16 arg3, s16 arg4, s32* arg5) {
    Gfx* entry = arg0;
    INIT_FROM_ARRAY(u16 sp78[2], sp78, D_hd_code_802FA8A0);
    s32 sp74;
    struct S_802FA280* sp70;
    f32 sp6C;
    f32 sp68;
    f32 sp64;
    f32 sp60;
    f32 sp5C;

    // @recomp: get aspect ratio
    f32 ratio = recomp_get_target_aspect_ratio(4.0f/3.0f);
    f32 offset = ((ratio * 960.0f) - 1280.0f) / 1280.0f;


    if (D_hd_code_8036BFC4 == 0) {
        *arg5 = 0;
        return entry;
    }
    sp6C = (120.0 - ((f32) arg4 * 0.22)) + D_hd_code_8036BFC0;

    D_hd_code_8036BFCC = MAX(0.0, sp6C);
    D_hd_code_8036BFD0 = MAX(0.0, -sp6C);

    *arg5 = D_hd_code_8036BFCC;
    if (*arg5 <= 0) {
        return entry;
    }
    D_hd_code_8036BFC8 = ((arg3 - 2048.0) * 0.5);

    D_hd_code_802FA820[D_hd_code_8036BFC5][2].v.ob[1] = (D_hd_code_8036BFCC * 4.0) - 1.0;
    D_hd_code_802FA820[D_hd_code_8036BFC5][3].v.ob[1] = (D_hd_code_8036BFCC * 4.0) - 1.0;

    // @recomp: calculate new skybox sizes
    D_hd_code_802FA820[D_hd_code_8036BFC5][0].v.ob[0] = -offset * 1280;
    D_hd_code_802FA820[D_hd_code_8036BFC5][1].v.ob[0] = 1280 + offset * 1280;
    D_hd_code_802FA820[D_hd_code_8036BFC5][2].v.ob[0] = -offset * 1280.0f;
    D_hd_code_802FA820[D_hd_code_8036BFC5][3].v.ob[0] = 1280 + offset * 1280;


    gSPClearGeometryMode(entry++, -1);
    gSPSetGeometryMode(entry++, G_SHADE | G_SHADING_SMOOTH);
    gSPTexture(entry++, qu016(0.5), qu016(0.5), 0, G_TX_RENDERTILE, G_ON);
    gDPPipeSync(entry++);
    gDPSetCombineLERP(entry++, TEXEL1, TEXEL0, TEXEL1_ALPHA, TEXEL0, TEXEL1, TEXEL0, TEXEL0, TEXEL0, 0, 0, 0, COMBINED,
                      0, 0, 0, COMBINED);
    gDPSetCycleType(entry++, G_CYC_2CYCLE);
    gDPSetRenderMode(entry++, G_RM_OPA_SURF, G_RM_OPA_SURF2);
    gDPSetTextureFilter(entry++, G_TF_BILERP);

    for (sp74 = 0; sp74 < 2; sp74++) {
        sp70 = &D_hd_code_802FA280[arg2][sp74];

        gDPSetTextureImage(entry++, G_IM_FMT_RGBA, G_IM_SIZ_16b, 1, sp70->unk4);
        gDPTileSync(entry++);
        gDPSetTile(entry++, G_IM_FMT_RGBA, G_IM_SIZ_16b, 0, sp74 << 8, G_TX_LOADTILE, 0, G_TX_NOMIRROR | G_TX_WRAP,
                   G_TX_NOMASK, G_TX_NOLOD, G_TX_NOMIRROR | G_TX_WRAP, G_TX_NOMASK, G_TX_NOLOD);
        gDPLoadSync(entry++);
        gDPLoadBlock(entry++, G_TX_LOADTILE, 0, 0, 1023, 256);
    }

    gSPMatrix(entry++, OS_PHYSICAL_TO_K0(&arg1->mtx2), G_MTX_NOPUSH | G_MTX_LOAD | G_MTX_PROJECTION);
    gSPMatrix(entry++, OS_PHYSICAL_TO_K0(&arg1->modelview), G_MTX_NOPUSH | G_MTX_LOAD | G_MTX_MODELVIEW);
    gDPTileSync(entry++);
    gDPSetTextureLOD(entry++, G_TL_TILE);

    for (sp74 = 0; sp74 < 2; sp74++) {
        sp70 = &D_hd_code_802FA280[arg2][sp74];

        gDPSetTile(entry++, sp78[sp74], G_IM_SIZ_16b, 8, sp74 << 8, sp74, 0, (sp70->unkB & 0x3), 5, sp74,
                   (sp70->unkA & 0x3), 5, sp74);
        gDPSetTileSize(entry++, sp74, 0, 0, qu102(31), qu102(31));
    }

    sp68 = (D_hd_code_8036BFC8 + 16.0f) / (f32) (1 << sp70->unk8);
    sp60 = (f32) (319.0 / (f64) (f32) (1 << sp70->unk8));

    // @recomp: adapt texture size in width
    D_hd_code_802FA820[D_hd_code_8036BFC5][0].v.tc[0] = (sp68 - offset * 319) * 32.0;
    D_hd_code_802FA820[D_hd_code_8036BFC5][1].v.tc[0] = (sp68 + sp60 + offset * 319) * 32.0;
    D_hd_code_802FA820[D_hd_code_8036BFC5][2].v.tc[0] = (sp68 - offset * 319) * 32.0;
    D_hd_code_802FA820[D_hd_code_8036BFC5][3].v.tc[0] = (sp68 + sp60 + offset * 319) * 32.0;

    sp64 = ((D_hd_code_8036BFCC - D_hd_code_8036BFC0) - D_hd_code_8036BFD0) / (f32) (1 << sp70->unk9);
    sp5C = (f32) (((f64) D_hd_code_8036BFCC - 1.0) / (f64) (f32) (1 << sp70->unk9));
    D_hd_code_802FA820[D_hd_code_8036BFC5][0].v.tc[1] = sp64 * 32.0;
    D_hd_code_802FA820[D_hd_code_8036BFC5][1].v.tc[1] = sp64 * 32.0;
    D_hd_code_802FA820[D_hd_code_8036BFC5][2].v.tc[1] = (sp64 - sp5C) * 32.0;
    D_hd_code_802FA820[D_hd_code_8036BFC5][3].v.tc[1] = (sp64 - sp5C) * 32.0;

    gSPVertex(entry++, D_hd_code_802FA820[D_hd_code_8036BFC5], 4, 0);
    gDPPipeSync(entry++);
    gSP1Triangle(entry++, 0, 1, 2, 0);
    gSP1Triangle(entry++, 1, 2, 3, 0);

    D_hd_code_8036BFC5 ^= 1;
    return entry;
}
