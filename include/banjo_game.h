#ifndef __BANJO_GAME_H__
#define __BANJO_GAME_H__

#include <cstdint>
#include <span>
#include <vector>
#include "recomp.h"

namespace blast {
    std::vector<uint8_t> decompress(std::span<const uint8_t> compressed_rom);
};

#endif
