#include "banjo_game.h"
#include <vector>
#include <cstdint>
#include <gzip/decompress.hpp>

std::vector<uint8_t> blast::decompress(std::span<const uint8_t> compressed_rom) {
    if (compressed_rom.size() != 0x800000) {
        assert(false);
        return {};
    }

    auto pad_to_n = [](std::vector<uint8_t>& out, size_t align) {
        size_t pad = (align - (out.size() % align)) % align;
        out.resize(out.size() + pad, 0);
    };

    auto extract_gzip = [&](size_t offset, size_t size) {
        return gzip::decompress(reinterpret_cast<const char*>(compressed_rom.data() + offset), size);
    };

    auto append = [](std::vector<uint8_t>& out, const std::string& s) { out.insert(out.end(), s.begin(), s.end()); };

    std::vector<uint8_t> out(compressed_rom.begin(), compressed_rom.end());
    pad_to_n(out, 0x10);

    append(out, extract_gzip(0x787FD0, 0x4F3E4));
    append(out, extract_gzip(0x7D73B4, 0xC71C));
    pad_to_n(out, 0x10);

    append(out, extract_gzip(0x7E3AD0, 0x128D1));
    append(out, extract_gzip(0x7F63A1, 0x383C));
    pad_to_n(out, 0x10);

    return out;
}
