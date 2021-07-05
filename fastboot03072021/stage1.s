    .section .text, "ax", @progbits
    .set noreorder
    .align 2
    .global stage1
    .type stage1, @function

/* from stage2:

   0:	8ca70000 	lw	a3,0(a1)
   4:	24c6ffff 	addiu	a2,a2,-1
   8:	ac870000 	sw	a3,0(a0)
   c:	14c0fffc 	bnez	a2,0 <stage2>
  10:	24840004 	addiu	a0,a0,4
  14:	10000019 	b	7c <stage2+0x7c>
  18:	24090044 	li	t1,68
  1c:	40803800 	mtc0	zero,c0_hwrena
  20:	3c04801a 	lui	a0,0x801a
  24:	3c05bf00 	lui	a1,0xbf00
  28:	84a60000 	lh	a2,0(a1)
  2c:	1000fff4 	b	0 <stage2>
  30:	0080f825 	move	ra,a0

*/

stage1:
    lui   $t0, 0b1100101010000000
    li    $t1, 0x0314
    li    $t2, 0xffff
    mtc0  $t0, $7
    mtc0  $t1, $5
    mtc0  $t2, $9

    li    $t0, 0x8ca70000
    sw    $t0, 0x24($0)
    li    $t0, 0x24c6ffff
    sw    $t0, 0x28($0)
    li    $t0, 0xac870000
    sw    $t0, 0x2c($0)
    li    $t0, 0x14c0fffc
    sw    $t0, 0x30($0)
    li    $t0, 0x24840004
    sw    $t0, 0x34($0)
    li    $t0, 0x10000019
    sw    $t0, 0x38($0)
    li    $t0, 0x24090044
    sw    $t0, 0x3c($0)
    li    $t0, 0x40803800
    sw    $t0, 0x40($0)
    li    $t0, 0x3c04801a
    sw    $t0, 0x44($0)
    li    $t0, 0x3c05bf00
    sw    $t0, 0x48($0)
    li    $t0, 0x84a60000
    sw    $t0, 0x4c($0)
    li    $t0, 0x1000fff4
    sw    $t0, 0x50($0)
    li    $t0, 0x0080f825
    jr    $ra
    sw    $t0, 0x54($0)
