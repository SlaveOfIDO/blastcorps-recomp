#pragma once

#define TAG_MISSILE_ARROW 0x100
#define TAG_FADE_SCREEN 0x200
#define TAG_VEHICLE(addr, arg1) ((u32)(addr) | (arg1) << 24)