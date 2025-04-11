/* link.ld */
ENTRY(_boot)

MEMORY {
    RAM (rwx) : ORIGIN = 0x80000000, LENGTH = 4K
}

SECTIONS {
    .text.boot : {
        *(.text.boot)  /* 确保启动代码在0x80000000 */
    } > RAM
    .text : {
        *(.text .text.*)
    } > RAM
    .data : { *(.data) }
    .bss : { *(.bss) }
    . = ALIGN(4);
    _heap_start = .;
    . += 1K;    /* 1KB堆 */
    _heap_end = .;
    . += 1K;    /* 1KB栈 */
    _stack_end = .;
}