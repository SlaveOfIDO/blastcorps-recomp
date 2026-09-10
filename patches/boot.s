.include "macro.inc"
#include "macro_float_reg.h"

/* assembler directives */
.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

.section .recomp_patch, "ax"

glabel Decompress_CodeSeg
//     /* 800098 8004B498 27BDEFD0 */  addiu      $sp, $sp, -0x1030
//     /* 80009C 8004B49C AFBF1028 */  sw         $ra, 0x1028($sp)
//     /* 8000A0 8004B4A0 3C03A480 */  lui        $v1, %hi(SI_STATUS_REG)
//     /* 8000A4 8004B4A4 34630018 */  ori        $v1, $v1, %lo(SI_STATUS_REG)
//     /* 8000A8 8004B4A8 3C05BFC0 */  lui        $a1, (0xBFC007FC >> 16)
//     /* 8000AC 8004B4AC 34A507FC */  ori        $a1, $a1, (0xBFC007FC & 0xFFFF)
//   .L8004B4B0:
//     /* 8000B0 8004B4B0 8C620000 */  lw         $v0, 0x0($v1)
//     /* 8000B4 8004B4B4 30420003 */  andi       $v0, $v0, 0x3
//     /* 8000B8 8004B4B8 1440FFFD */  bnez       $v0, .L8004B4B0
//     /* 8000BC 8004B4BC 00000000 */   nop
//     /* 8000C0 8004B4C0 8CA40000 */  lw         $a0, 0x0($a1)
//   .L8004B4C4:
//     /* 8000C4 8004B4C4 8C620000 */  lw         $v0, 0x0($v1)
//     /* 8000C8 8004B4C8 30420003 */  andi       $v0, $v0, 0x3
//     /* 8000CC 8004B4CC 1440FFFD */  bnez       $v0, .L8004B4C4
//     /* 8000D0 8004B4D0 34820008 */   ori       $v0, $a0, 0x8
//     /* 8000D4 8004B4D4 ACA20000 */  sw         $v0, 0x0($a1)

    lui $a0, 0x80
    ori $a0, $a0, 0x60
    lui $a1, 0x8004
    ori $a1, $a1, 0xB460
    lui $a2, 0x10
    jal recomp_load_overlays
    ori $a2, $a2, 0x8560

    /* 8000D8 8004B4D8 00002821 */  addu       $a1, $zero, $zero
    /* 8000DC 8004B4DC 3C048025 */  lui        $a0, %hi(D_8024B8A0)
    /* 8000E0 8004B4E0 2484B8A0 */  addiu      $a0, $a0, %lo(D_8024B8A0)
    /* 8000E4 8004B4E4 3C038005 */  lui        $v1, %hi(Boot_Setup)
    /* 8000E8 8004B4E8 2463B8A0 */  addiu      $v1, $v1, %lo(Boot_Setup)
  .L8004B4EC:
    /* 8000EC 8004B4EC 3C020003 */  lui        $v0, %hi(D_2DFE0)
    /* 8000F0 8004B4F0 2442DFE0 */  addiu      $v0, $v0, %lo(D_2DFE0)
    /* 8000F4 8004B4F4 04420001 */  bltzl      $v0, .L8004B4FC
    /* 8000F8 8004B4F8 24420003 */   addiu     $v0, $v0, 0x3
  .L8004B4FC:
    /* 8000FC 8004B4FC 00021083 */  sra        $v0, $v0, 2
    /* 800100 8004B500 00A2102A */  slt        $v0, $a1, $v0
    /* 800104 8004B504 10400006 */  beqz       $v0, .L8004B520
    /* 800108 8004B508 24A50001 */   addiu     $a1, $a1, 0x1
    /* 80010C 8004B50C 8C620000 */  lw         $v0, 0x0($v1)
    /* 800110 8004B510 24630004 */  addiu      $v1, $v1, 0x4
    /* 800114 8004B514 AC820000 */  sw         $v0, 0x0($a0)
    /* 800118 8004B518 08012D3B */  j          .L8004B4EC
    /* 80011C 8004B51C 24840004 */   addiu     $a0, $a0, 0x4
  .L8004B520:
    /* 800120 8004B520 3C088005 */  lui        $t0, %hi(Boot_Setup)
    /* 800124 8004B524 2508B8A0 */  addiu      $t0, $t0, %lo(Boot_Setup)
    /* 800128 8004B528 3C058025 */  lui        $a1, %hi(D_8024B8A8)
    /* 80012C 8004B52C 24A5B8A8 */  addiu      $a1, $a1, %lo(D_8024B8A8)
    /* 800130 8004B530 8CA20000 */  lw         $v0, 0x0($a1)
    /* 800134 8004B534 24030FED */  addiu      $v1, $zero, 0xFED
    /* 800138 8004B538 27A40FFD */  addiu      $a0, $sp, 0xFFD
    /* 80013C 8004B53C 2442FFF8 */  addiu      $v0, $v0, -0x8
    /* 800140 8004B540 00453021 */  addu       $a2, $v0, $a1
  .L8004B544:
    /* 800144 8004B544 A0800000 */  sb         $zero, 0x0($a0)
    /* 800148 8004B548 2463FFFF */  addiu      $v1, $v1, -0x1
    /* 80014C 8004B54C 0461FFFD */  bgez       $v1, .L8004B544
    /* 800150 8004B550 2484FFFF */   addiu     $a0, $a0, -0x1
    /* 800154 8004B554 8CAA0008 */  lw         $t2, 0x8($a1)
    /* 800158 8004B558 00005821 */  addu       $t3, $zero, $zero
    /* 80015C 8004B55C 19400031 */  blez       $t2, .L8004B624
    /* 800160 8004B560 24040FEE */   addiu     $a0, $zero, 0xFEE
    /* 800164 8004B564 27AC0010 */  addiu      $t4, $sp, 0x10
    /* 800168 8004B568 000B5843 */  sra        $t3, $t3, 1
  .L8004B56C:
    /* 80016C 8004B56C 31620100 */  andi       $v0, $t3, 0x100
    /* 800170 8004B570 14400005 */  bnez       $v0, .L8004B588
    /* 800174 8004B574 31620001 */   andi      $v0, $t3, 0x1
    /* 800178 8004B578 90C30000 */  lbu        $v1, 0x0($a2)
    /* 80017C 8004B57C 24C60001 */  addiu      $a2, $a2, 0x1
    /* 800180 8004B580 346BFF00 */  ori        $t3, $v1, 0xFF00
    /* 800184 8004B584 31620001 */  andi       $v0, $t3, 0x1
  .L8004B588:
    /* 800188 8004B588 1040000A */  beqz       $v0, .L8004B5B4
    /* 80018C 8004B58C 01841021 */   addu      $v0, $t4, $a0
    /* 800190 8004B590 90C30000 */  lbu        $v1, 0x0($a2)
    /* 800194 8004B594 24C60001 */  addiu      $a2, $a2, 0x1
    /* 800198 8004B598 24840001 */  addiu      $a0, $a0, 0x1
    /* 80019C 8004B59C 30840FFF */  andi       $a0, $a0, 0xFFF
    /* 8001A0 8004B5A0 254AFFFF */  addiu      $t2, $t2, -0x1
    /* 8001A4 8004B5A4 A0430000 */  sb         $v1, 0x0($v0)
    /* 8001A8 8004B5A8 A1030000 */  sb         $v1, 0x0($t0)
    /* 8001AC 8004B5AC 08012D87 */  j          .L8004B61C
    /* 8001B0 8004B5B0 25080001 */   addiu     $t0, $t0, 0x1
  .L8004B5B4:
    /* 8001B4 8004B5B4 90C90000 */  lbu        $t1, 0x0($a2)
    /* 8001B8 8004B5B8 24C60001 */  addiu      $a2, $a2, 0x1
    /* 8001BC 8004B5BC 90C70000 */  lbu        $a3, 0x0($a2)
    /* 8001C0 8004B5C0 24C60001 */  addiu      $a2, $a2, 0x1
    /* 8001C4 8004B5C4 30E200F0 */  andi       $v0, $a3, 0xF0
    /* 8001C8 8004B5C8 00021100 */  sll        $v0, $v0, 4
    /* 8001CC 8004B5CC 01224825 */  or         $t1, $t1, $v0
    /* 8001D0 8004B5D0 30E2000F */  andi       $v0, $a3, 0xF
    /* 8001D4 8004B5D4 24470002 */  addiu      $a3, $v0, 0x2
    /* 8001D8 8004B5D8 28E20000 */  slti       $v0, $a3, 0x0
    /* 8001DC 8004B5DC 1440000F */  bnez       $v0, .L8004B61C
    /* 8001E0 8004B5E0 00002821 */   addu      $a1, $zero, $zero
  .L8004B5E4:
    /* 8001E4 8004B5E4 01251021 */  addu       $v0, $t1, $a1
    /* 8001E8 8004B5E8 30420FFF */  andi       $v0, $v0, 0xFFF
    /* 8001EC 8004B5EC 01821021 */  addu       $v0, $t4, $v0
    /* 8001F0 8004B5F0 90430000 */  lbu        $v1, 0x0($v0)
    /* 8001F4 8004B5F4 01841021 */  addu       $v0, $t4, $a0
    /* 8001F8 8004B5F8 24840001 */  addiu      $a0, $a0, 0x1
    /* 8001FC 8004B5FC 30840FFF */  andi       $a0, $a0, 0xFFF
    /* 800200 8004B600 254AFFFF */  addiu      $t2, $t2, -0x1
    /* 800204 8004B604 24A50001 */  addiu      $a1, $a1, 0x1
    /* 800208 8004B608 A0430000 */  sb         $v1, 0x0($v0)
    /* 80020C 8004B60C A1030000 */  sb         $v1, 0x0($t0)
    /* 800210 8004B610 00E5102A */  slt        $v0, $a3, $a1
    /* 800214 8004B614 1040FFF3 */  beqz       $v0, .L8004B5E4
    /* 800218 8004B618 25080001 */   addiu     $t0, $t0, 0x1
  .L8004B61C:
    /* 80021C 8004B61C 1D40FFD3 */  bgtz       $t2, .L8004B56C
    /* 800220 8004B620 000B5843 */   sra       $t3, $t3, 1
  .L8004B624:
    /* 800224 8004B624 0C012D19 */  jal        Decompress_ClearCache
    /* 800228 8004B628 00000000 */   nop
    /* 80022C 8004B62C 0C012E28 */  jal        Boot_Setup
    /* 800230 8004B630 00000000 */   nop
    /* 800234 8004B634 8FBF1028 */  lw         $ra, 0x1028($sp)
    /* 800238 8004B638 27BD1030 */  addiu      $sp, $sp, 0x1030
    /* 80023C 8004B63C 03E00008 */  jr         $ra
    /* 800240 8004B640 00000000 */   nop
.size Decompress_CodeSeg, . - Decompress_CodeSeg