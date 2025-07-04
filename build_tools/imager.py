from re import X
import sys
import shutil
import os
import mmap
from typing import IO, Any

def eprint(s):
    print(s, file=sys.stderr)


def eprint_usage():
    eprint("Usage: python imager.py <base.img> <offset> <target.bin>")


def read(tag, file: IO[Any], count=0):
    data = file.read() if count == 0 else file.read(count)
    size = len(data)
    eprint(f'[{tag}] Read {size} (0x{size}) bytes')
    return bytearray(data)


def write(tag, file: IO[Any], data: bytearray, offset: int):
    file.seek(offset)
    size = file.write(data)
    eprint(f'[{tag}] Write {size} (0x{size:X}) bytes at offset 0x{offset:X}')
    return


def write_to_offset(target: str, offset: int, base: str):
    eprint(f'Base  : {base}')
    eprint(f'Offset: 0x{offset:X}')
    eprint(f'Target: {target}')

    with open(target, 'rb') as target_file:
        target_data = read('target', target_file)
        with open(base, 'r+b') as base_file:
            write('base', base_file, target_data, offset)


def main():
    args = sys.argv[1:]
    eprint(sys.argv)
    if len(args) != 3:
        eprint_usage()
        sys.exit(-1)
    base = args[0]
    offset = int(args[1], 0)
    target = args[2]
    write_to_offset(target, offset, base)


if __name__ == "__main__":
    main()
