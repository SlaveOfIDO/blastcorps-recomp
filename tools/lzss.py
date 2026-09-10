# LZSS decompression, derived from rotm tools
# https://github.com/hack64-net/rotm
def lzss_decompress(src: bytes, dstSize: int) -> bytearray:
    dst = bytearray()
    windowBuf = bytearray(0x1000)

    srcOffset = 0
    windowIdx = 0x0FEE
    flags = 0

    while (len(dst) < dstSize):
        flags >>= 1

        if (flags & 0x0100) == 0:
            flags = 0xFF00 | src[srcOffset]
            srcOffset += 1

        if (flags & 0x0001) != 0:
            value = src[srcOffset]
            srcOffset += 1
            dst.append(value)
            windowBuf[windowIdx] = value
            windowIdx += 1
            windowIdx %= len(windowBuf)
        else:
            pair = src[srcOffset:srcOffset+2]
            srcOffset += 2

            offset = pair[0] | ((pair[1] & 0xF0) << 4)
            length = (pair[1] & 0x0F) + 3

            for i in range(length):
                window_offset = (offset + i) % len(windowBuf)
                value = windowBuf[window_offset]
                dst.append(value)
                windowBuf[windowIdx] = value
                windowIdx += 1
                windowIdx %= len(windowBuf)
    return dst
