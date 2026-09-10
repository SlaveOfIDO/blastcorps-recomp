.include "macro.inc"
#include "macro_float_reg.h"

/* assembler directives */
.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

.section .recomp_patch, "ax"

glabel NameEntry_CheckForCheats
    /* 88FF28 800DB328 27BDFFD0 */  addiu      $sp, $sp, -0x30
    /* 88FF2C 800DB32C 3C048011 */  lui        $a0, %hi(gCheatList)
    /* 88FF30 800DB330 2484C45C */  addiu      $a0, $a0, %lo(gCheatList)
    /* 88FF34 800DB334 AFBF002C */  sw         $ra, 0x2C($sp)
    /* 88FF38 800DB338 AFB20028 */  sw         $s2, 0x28($sp)
    /* 88FF3C 800DB33C AFB10024 */  sw         $s1, 0x24($sp)
    /* 88FF40 800DB340 AFB00020 */  sw         $s0, 0x20($sp)
    /* 88FF44 800DB344 8C820000 */  lw         $v0, 0x0($a0)
    /* 88FF48 800DB348 10400045 */  beqz       $v0, .L800DB460
    /* 88FF4C 800DB34C 00008021 */   addu      $s0, $zero, $zero
    /* 88FF50 800DB350 3C118009 */  lui        $s1, %hi(D_80095F6C)
    /* 88FF54 800DB354 26315F6C */  addiu      $s1, $s1, %lo(D_80095F6C)
    /* 88FF58 800DB358 24120001 */  addiu      $s2, $zero, 0x1
    /* 88FF5C 800DB35C 00003821 */  addu       $a3, $zero, $zero
  .L800DB360:
    /* 88FF60 800DB360 3C068018 */  lui        $a2, %hi(D_8017A950)
    /* 88FF64 800DB364 24C6A950 */  addiu      $a2, $a2, %lo(D_8017A950)
    /* 88FF68 800DB368 90C30000 */  lbu        $v1, 0x0($a2)
    /* 88FF6C 800DB36C 00E41021 */  addu       $v0, $a3, $a0
    /* 88FF70 800DB370 8C450000 */  lw         $a1, 0x0($v0)
    /* 88FF74 800DB374 10600010 */  beqz       $v1, .L800DB3B8
    /* 88FF78 800DB378 00000000 */   nop
  .L800DB37C:
    /* 88FF7C 800DB37C 90C40000 */  lbu        $a0, 0x0($a2)
    /* 88FF80 800DB380 90A30000 */  lbu        $v1, 0x0($a1)
    /* 88FF84 800DB384 2482FFBF */  addiu      $v0, $a0, -0x41
    /* 88FF88 800DB388 2C42001A */  sltiu      $v0, $v0, 0x1A
    /* 88FF8C 800DB38C 54400001 */  bnel       $v0, $zero, .L800DB394
    /* 88FF90 800DB390 24840020 */   addiu     $a0, $a0, 0x20
  .L800DB394:
    /* 88FF94 800DB394 2462FFBF */  addiu      $v0, $v1, -0x41
    /* 88FF98 800DB398 2C42001A */  sltiu      $v0, $v0, 0x1A
    /* 88FF9C 800DB39C 54400001 */  bnel       $v0, $zero, .L800DB3A4
    /* 88FFA0 800DB3A0 24630020 */   addiu     $v1, $v1, 0x20
  .L800DB3A4:
    /* 88FFA4 800DB3A4 14830019 */  bne        $a0, $v1, .L800DB40C
    /* 88FFA8 800DB3A8 24C60001 */   addiu     $a2, $a2, 0x1
    /* 88FFAC 800DB3AC 90C20000 */  lbu        $v0, 0x0($a2)
    /* 88FFB0 800DB3B0 1440FFF2 */  bnez       $v0, .L800DB37C
    /* 88FFB4 800DB3B4 24A50001 */   addiu     $a1, $a1, 0x1
  .L800DB3B8:
    /* 88FFB8 800DB3B8 90A20000 */  lbu        $v0, 0x0($a1)
    /* 88FFBC 800DB3BC 1440FFEF */  bnez       $v0, .L800DB37C
    /* 88FFC0 800DB3C0 00001021 */   addu      $v0, $zero, $zero
  .L800DB3C4:
    /* 88FFC4 800DB3C4 5440001F */  bnel       $v0, $zero, .L800DB444
    /* 88FFC8 800DB3C8 24E70004 */   addiu     $a3, $a3, 0x4
    # Disable Wireframe cheat: if (s0 == 4) ("wired"), reject it
    addiu $v0, $s0, -4
    beqz  $v0, .L800DB460
    nop
    /* 88FFCC 800DB3CC 8E220000 */  lw         $v0, 0x0($s1)
    /* 88FFD0 800DB3D0 02021007 */  srav       $v0, $v0, $s0
    /* 88FFD4 800DB3D4 30420001 */  andi       $v0, $v0, 0x1
    /* 88FFD8 800DB3D8 1040000E */  beqz       $v0, .L800DB414
    /* 88FFDC 800DB3DC 24040029 */   addiu     $a0, $zero, 0x29
    /* 88FFE0 800DB3E0 3C053F80 */  lui        $a1, (0x3F800000 >> 16)
    /* 88FFE4 800DB3E4 3C060001 */  lui        $a2, (0x10000 >> 16)
    /* 88FFE8 800DB3E8 24070040 */  addiu      $a3, $zero, 0x40
    /* 88FFEC 800DB3EC 0C016561 */  jal        func_80059584
    /* 88FFF0 800DB3F0 AFA00010 */   sw        $zero, 0x10($sp)
    /* 88FFF4 800DB3F4 8E230000 */  lw         $v1, 0x0($s1)
    /* 88FFF8 800DB3F8 02121004 */  sllv       $v0, $s2, $s0
    /* 88FFFC 800DB3FC 00021027 */  nor        $v0, $zero, $v0
    /* 890000 800DB400 00621824 */  and        $v1, $v1, $v0
    /* 890004 800DB404 08036D0F */  j          .L800DB43C
    /* 890008 800DB408 AE230000 */   sw        $v1, 0x0($s1)
  .L800DB40C:
    /* 89000C 800DB40C 08036CF1 */  j          .L800DB3C4
    /* 890010 800DB410 2402FFFF */   addiu     $v0, $zero, -0x1
  .L800DB414:
    /* 890014 800DB414 24040022 */  addiu      $a0, $zero, 0x22
    /* 890018 800DB418 3C053F80 */  lui        $a1, (0x3F800000 >> 16)
    /* 89001C 800DB41C 3C060001 */  lui        $a2, (0x10000 >> 16)
    /* 890020 800DB420 24070040 */  addiu      $a3, $zero, 0x40
    /* 890024 800DB424 0C016561 */  jal        func_80059584
    /* 890028 800DB428 AFA00010 */   sw        $zero, 0x10($sp)
    /* 89002C 800DB42C 8E220000 */  lw         $v0, 0x0($s1)
    /* 890030 800DB430 02121804 */  sllv       $v1, $s2, $s0
    /* 890034 800DB434 00431025 */  or         $v0, $v0, $v1
    /* 890038 800DB438 AE220000 */  sw         $v0, 0x0($s1)
  .L800DB43C:
    /* 89003C 800DB43C 08036D19 */  j          .L800DB464
    /* 890040 800DB440 24020001 */   addiu     $v0, $zero, 0x1
  .L800DB444:
    /* 890044 800DB444 3C018011 */  lui        $at, %hi(gCheatList)
    /* 890048 800DB448 00270821 */  addu       $at, $at, $a3
    /* 89004C 800DB44C 8C22C45C */  lw         $v0, %lo(gCheatList)($at)
    /* 890050 800DB450 3C048011 */  lui        $a0, %hi(gCheatList)
    /* 890054 800DB454 2484C45C */  addiu      $a0, $a0, %lo(gCheatList)
    /* 890058 800DB458 1440FFC1 */  bnez       $v0, .L800DB360
    /* 89005C 800DB45C 26100001 */   addiu     $s0, $s0, 0x1
  .L800DB460:
    /* 890060 800DB460 00001021 */  addu       $v0, $zero, $zero
  .L800DB464:
    /* 890064 800DB464 8FBF002C */  lw         $ra, 0x2C($sp)
    /* 890068 800DB468 8FB20028 */  lw         $s2, 0x28($sp)
    /* 89006C 800DB46C 8FB10024 */  lw         $s1, 0x24($sp)
    /* 890070 800DB470 8FB00020 */  lw         $s0, 0x20($sp)
    /* 890074 800DB474 27BD0030 */  addiu      $sp, $sp, 0x30
    /* 890078 800DB478 03E00008 */  jr         $ra
    /* 89007C 800DB47C 00000000 */   nop
.size NameEntry_CheckForCheats, . - NameEntry_CheckForCheats