#include "patches.h"

extern s32 D_8017A908; // Demo transition effect

// Patch demo transitions so 4/3 only transitions don't get used in widescreen
void demo_widescreen_transition_fix(void) {
    const f32 original_aspect = 4.0f / 3.0f;
    const f32 target_aspect = recomp_get_target_aspect_ratio(original_aspect);

    if (target_aspect <= original_aspect) {
        return;
    }

    switch (D_8017A908) {
        // Force effects 0, 1, 4, 5 to use effect 2
        case 0:
        case 1:
        case 4:
        case 5:
            D_8017A908 = 2;
            break;

        // Force effects 6, 7 and 8 to use effect 3
        case 6:
        case 7:
        case 8:
            D_8017A908 = 3;
            break;

        default:
            break;
    }
}
