#!/usr/bin/env python3

import argparse
import struct
from hashlib import sha256
from io import BufferedWriter
from pathlib import Path
import gzip
from io import BytesIO

def verify_rom(romPath: Path) -> bool:
    hash = sha256(romPath.read_bytes()).hexdigest()
    return hash == "42e4d8cde3c106637a25bbfa62d74cc2e5c1eed1d64de5bbb0b1c4896b185927"

def extract_gzip(romData: bytes, offset: int, size: int) -> bytearray:
    compressed = romData[offset:offset + size]

    with gzip.GzipFile(fileobj=BytesIO(compressed), mode="rb") as f:
        return bytearray(f.read())

def decompress_rom(romPath: Path, decompressedPath: Path):
    def pad_to_n(w: BufferedWriter, align: int):
        pad = (align - (w.tell() % align)) % align
        w.write(b'\0' * pad)

    inputData = romPath.read_bytes()
    with decompressedPath.open("wb") as out:
        out.write(inputData)
        pad_to_n(out, 0x10)

        hd_code_text = extract_gzip(inputData, 0x787FD0, 0x4F3E4)
        print(f"Write hd_code text to {out.tell():06X}")
        out.write(hd_code_text)
        
        hd_code_data = extract_gzip(inputData, 0x7D73B4, 0xC71C)
        print(f"Write hd_code data to {out.tell():06X}")
        out.write(hd_code_data)
        pad_to_n(out, 0x10)


        hd_front_end_text = extract_gzip(inputData, 0x7E3AD0, 0x128D1)
        print(f"Write hd_front_end text to {out.tell():06X}")
        out.write(hd_front_end_text)
        
        hd_front_end_data = extract_gzip(inputData, 0x7F63A1, 0x383C)
        print(f"Write hd_front_end data to {out.tell():06X}")
        out.write(hd_front_end_data)
        pad_to_n(out, 0x10)

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
    args = parser.parse_args()

    if not verify_rom(Path(args.input_rom)):
        print("Invalid ROM hash")

    decompress_rom(Path(args.input_rom), Path(args.output_rom))

if __name__ == "__main__":
    main()
