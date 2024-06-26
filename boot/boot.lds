OUTPUT_FORMAT("elf64-littleaarch64")
OUTPUT_ARCH(aarch64)

SECTIONS
{
    . = 0x200000;

    .boot : {
        KEEP (*(.boot))
    }

    /* text/read-only data */
    .text : {
        *(.text*)
    }

    .data : {
        *(.data .data.*)
        *(.rodata .rodata.*)
    }

     /DISCARD/ : {
        *(.comment .note)
    }
}
