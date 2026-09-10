#!/usr/bin/env python3

import argparse
import struct
from hashlib import sha256
from io import BufferedWriter
from pathlib import Path

import lzhuf
import lzss


def verify_rom(romPath: Path) -> bool:
    hash = sha256(romPath.read_bytes()).hexdigest()
    return hash == "9e67bc574e40ef273759d587972655003d5213e625bfa68d3071dc9782d2071c"

# wrapper for lzss, reads meta data from ROM data
def extract_lzss(romData: bytes, base: int) -> bytearray:
    offset = base
    # only extracting one file at the moment, so count is ignored
    count, _ = struct.unpack_from(">II", romData, offset)
    offset += 0x8
    fileOffset, magic, destSize, sourceSize = struct.unpack_from(">I4sII", romData, offset)
    assert magic == b'LZSS', f"Invalid magic at {offset:x}: {magic}"
    romOffset = base + fileOffset
    compressedData = romData[romOffset : romOffset + sourceSize]
    binData = lzss.lzss_decompress(compressedData, destSize)
    return binData

def extract_lzhuf(romData: bytes, base: int) -> bytearray:
    destSize, = struct.unpack_from(">I", romData, base)
    compressedData = romData[base + 4:]
    binData = lzhuf.lzhuf_decompress(compressedData, destSize)
    return binData

# decompresses ROM containing:
# ROM Start | ROM End   | VRAM       | Description
# ----------|-----------|------------|-------------------------------
# 0x00_0000 | 0x80_0000 | N/A        | original ROM 0x0:0x800000
# 0x80_0000 | 0x80_04A0 | 0x8004B400 | original boot code from 0x1000:0x14A0
# 0x80_04A0 | 0x85_0498 | 0x8004B8A0 | decompressed LZSS block from 0x14A0
# 0x85_0498 | 0x90_85C0 | 0x8009B898 | decompressed LZHUF block from 0x2F480
def decompress_rom(romPath: Path, decompressedPath: Path, alignment: int = 8):
    def pad_to_n(w: BufferedWriter, align: int):
        pad = (align - (w.tell() % align)) % align
        w.write(b'\0' * pad)

    inputData = romPath.read_bytes()
    with decompressedPath.open("wb") as out:
        out.write(inputData)
        pad_to_n(out, alignment)

        out.write(inputData[0x1000:0x14A0])
        print(f"Write boot code to {out.tell():06X}")
        pad_to_n(out, alignment)

        lzss14A0 = extract_lzss(inputData, 0x0014A0)
        print(f"Write LZSS   14A0 to {out.tell():06X}")
        out.write(lzss14A0)
        pad_to_n(out, alignment)

        lzhuf2F480 = extract_lzhuf(inputData, 0x002F480)
        print(f"Write LZHUF 2F480 to {out.tell():06X}")
        out.write(lzhuf2F480)
        pad_to_n(out, alignment)
        pad_to_n(out, 0x10) # always pad end to at least 0x10

def parse_hex(literal: str) -> int:
    try:
        value = int(literal, 0)
    except ValueError as error:
        raise argparse.ArgumentTypeError(f"{literal!r} is not valid") from error
    return value

def main() -> None:
    parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)
    parser.add_argument("input_rom", help="input ROM")
    parser.add_argument("output_rom", help="decompressed ROM")
    parser.add_argument("-a", "--alignment", type=parse_hex, default=8, help="decompressed ROM section alignment")
    args = parser.parse_args()

    if not verify_rom(Path(args.input_rom)):
        print("Invalid ROM hash")

    decompress_rom(Path(args.input_rom), Path(args.output_rom), args.alignment)

if __name__ == "__main__":
    main()
