#include "patches.h"
#include "sound.h"
#include "PR/libaudio.h"
#include "../lib/ultralib/src/audio/sndp.h"

extern f64 D_8004BD08;
extern f64 D_8004BD10;
extern f64 D_8004BD18;
extern void* D_80095D0C;
extern s32 D_80095D28; // gBgmVolume
extern s32 D_80095D3C; // gUpdateBgmVolume
extern void* D_80095D10;
extern u32 D_80095D24;
extern s32 D_80095D2C;
extern s32 D_80095D30;
extern s32 D_80095D34;
extern s32 D_80095D38;
extern OSMesgQueue D_80159BE8;
extern void D_80159F58;
extern u8* D_8015B50C;

extern ALSeqFile* D_8015B490;

#define ALIGN8(val) (((val) + 7)  & 0xFFF8)

RECOMP_PATCH void func_800592E8(void) {
    f64 temp_ft1;
    f64 var_fv1;
    f64 var_fv1_2;
    s16 var_a1;
    s32 temp_s0;
    s32 temp_v0;
    s32 temp_v0_2;
    u8* temp_s1;
    
    f32 bgm_volume = recomp_get_bgm_volume();
    static f32 prev_bgm_volume = 0.0f;

    // @recomp signal a bgm volume update if the user moved the bgm slider
    if (prev_bgm_volume != bgm_volume) {
        // recomp_printf("BGM VOLUME CHANGED: %f\n ",  recomp_get_bgm_volume());
        D_80095D3C = 1;
    }

    switch (D_80095D24) {
    case 2:
        break;
    case 0:
        if (D_80095D2C >= 0) {
            temp_s1 = D_8015B490->seqArray[D_80095D2C].offset;
            temp_s0 = (D_8015B490->seqArray[D_80095D2C].len + 7) & 0xFFF8;
            osInvalDCache(D_8015B50C, temp_s0);
            osPiStartDma(&D_80159F58, 0, 0, (u32) temp_s1, D_8015B50C, (u32) temp_s0, &D_80159BE8);
            osRecvMesg(&D_80159BE8, NULL, 1);
            alCSeqNew(D_80095D10, D_8015B50C);
            alCSPSetSeq(D_80095D0C, D_80095D10);
            alCSPPlay(D_80095D0C);
            D_80095D30 = 0;
            D_80095D24 = 1;
            D_80095D3C = 1;
        }
        break;

    case 1:
        D_80095D30 += D_80095D38;
        if (D_80095D30 >= 0x10000) {
            D_80095D24 = 2;
            D_80095D30 = 0x10000;
        }
        D_80095D3C = 1;
        break;

    case 3:
        D_80095D30 -= D_80095D34;
        if (D_80095D30 <= 0) {
            alCSPStop(D_80095D0C);
            D_80095D24 = 4;
            D_80095D30 = 0;
        }
        D_80095D3C = 1;
        break;

    case 4:
        if (alCSPGetState(D_80095D0C) == 0) {
            D_80095D24 = 0;
        }
        break;
    }

    if (D_80095D3C != 0) {
        temp_ft1 = (f64) D_80095D28 * ((f64) D_80095D30 * D_8004BD08);
        var_fv1 = temp_ft1 * D_8004BD10;
        if (!(var_fv1 <= D_8004BD18)) {
            var_fv1 = D_8004BD18;
        }
        var_a1 = 0;
        if (!(var_fv1 <= 0.0f)) {
            var_fv1_2 = temp_ft1 * D_8004BD10;
            if (!(var_fv1_2 <= D_8004BD18)) {
                var_fv1_2 = D_8004BD18;
            }
            var_a1 = (s16) (s32) var_fv1_2;
        }
        
        // @recomp update bgm volume with slider
        // alCSPSetVol(D_80095D0C, var_a1);
        alCSPSetVol(D_80095D0C, (s16)var_a1 * bgm_volume);
        D_80095D3C = 0;
    }

    // @recomp save the last slider state
    prev_bgm_volume = bgm_volume;
}

RECOMP_PATCH void alSndpSetVol(ALSndPlayer *sndp, s16 vol) 
{
    ALSndpEvent evt;
    ALSoundState  *sState = sndp->sndState;

    evt.vol.type = AL_SNDP_VOL_EVT;
    evt.vol.state = &sState[sndp->target];
    
    // @recomp update sfx volume with slider
    // evt.vol.vol = vol;
    evt.vol.vol = (s16)vol* recomp_get_sfx_volume();
    
    // recomp_printf("evt.vol.vol: %d\n", evt.vol.vol);
    alEvtqPostEvent(&sndp->evtq, (ALEvent *)&evt, 0);
}

