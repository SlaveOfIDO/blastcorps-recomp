#ifndef __OVERLAY_LOADING_H__
#define __OVERLAY_LOADING_H__

#include "patch_helpers.h"

DECLARE_FUNC(void, recomp_load_overlays_by_rom, u32 rom_addr, void* ram_addr, u32 size);

#endif
