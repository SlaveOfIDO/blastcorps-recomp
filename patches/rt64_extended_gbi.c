#include "patches.h"

extern Gfx* gMasterDisp[];
extern Vp D_800970B8;

void EG_gEXEnable(void) {
    gEXEnable(gMasterDisp[0]++);
}

void EG_gEXSetScissor(void) {
    gEXSetScissor(gMasterDisp[0]++, G_SC_NON_INTERLACE, G_EX_ORIGIN_LEFT, G_EX_ORIGIN_RIGHT, 0, 0, 0, 240);
}

void EG_RectAlign_Origin_Left_Left(void) {
    gEXSetRectAlign(gMasterDisp[0]++, G_EX_ORIGIN_LEFT, G_EX_ORIGIN_LEFT, 0, 0, 0, 0);
}

void EG_RectAlign_Origin_Right_Right(void) {
    gEXSetRectAlign(gMasterDisp[0]++, G_EX_ORIGIN_RIGHT, G_EX_ORIGIN_RIGHT, -(320) * 4, 0, -(320) * 4, 0);
}

void EG_RectAlign_Origin_None_None(void) {
    gEXSetRectAlign(gMasterDisp[0]++, G_EX_ORIGIN_NONE, G_EX_ORIGIN_NONE, 0, 0, 0, 0);
}

void EG_gEXViewportOrigin_Left(void) {
    gEXViewport(gMasterDisp[0]++, G_EX_ORIGIN_LEFT, &D_800970B8);
}

void EG_gEXViewportOrigin_Right(void) {
    gEXViewport(gMasterDisp[0]++, G_EX_ORIGIN_RIGHT, &D_800970B8);
}

void EG_gEXSetViewportAlign_Left(void) {
    gEXSetViewportAlign(gMasterDisp[0]++, G_EX_ORIGIN_LEFT, 0, 0);
}

void EG_gEXSetViewportAlign_Right(void) {
    gEXSetViewportAlign(gMasterDisp[0]++, G_EX_ORIGIN_RIGHT, -320 * 4, 0);
}

void EG_gEXSetViewportAlign_None(void) {
    gEXSetViewportAlign(gMasterDisp[0]++, G_EX_ORIGIN_NONE, 320, 240);
}

void EG_gEXViewportOrigin_None(void) {
    gEXViewport(gMasterDisp[0]++, G_EX_ORIGIN_NONE, &D_800970B8);
}
