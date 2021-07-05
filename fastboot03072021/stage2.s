    .section .text, "ax", @progbits
    .set noreorder
    .align 2
    .global stage2
    .type stage2, @function

stage2:
1:
/* 24 */    lw    $a3, 0($a1)
/* 28 */    addiu $a2, -1
/* 2c */    sw    $a3, 0($a0)
/* 30 */    bnez  $a2, 1b
/* 34 */    addiu $a0, 4

/* 38 */    b     0x34 /* relative branch going to 0xa0 */
/* 3c */    li    $t1, 0x44

/* 40 */    mtc0  $0, $7
/* 44 */    lui   $a0, 0x801a
/* 48 */    lui   $a1, 0xbf00
/* 4c */    lh    $a2, 0($a1)
/* 50 */    b     1b
/* 54 */    move  $ra, $a0
