.include "macro.inc"
#include "macro_float_reg.h"

.set noat
.set noreorder

.extern recomp_get_target_aspect_ratio

.section .recomp_patch, "ax"

glabel func_800E6A08
    jal EG_gEXEnable
    nop

    jal EG_gEXSetScissor
    nop

    /* 89B608 800E6A08 27BDFF98 */  addiu      $sp, $sp, -0x68
    /* 89B60C 800E6A0C AFB00040 */  sw         $s0, 0x40($sp)
    /* 89B610 800E6A10 00808021 */  addu       $s0, $a0, $zero
    /* 89B614 800E6A14 AFBF0064 */  sw         $ra, 0x64($sp)
    /* 89B618 800E6A18 AFBE0060 */  sw         $fp, 0x60($sp)
    /* 89B61C 800E6A1C AFB7005C */  sw         $s7, 0x5C($sp)
    /* 89B620 800E6A20 AFB60058 */  sw         $s6, 0x58($sp)
    /* 89B624 800E6A24 AFB50054 */  sw         $s5, 0x54($sp)
    /* 89B628 800E6A28 AFB40050 */  sw         $s4, 0x50($sp)
    /* 89B62C 800E6A2C AFB3004C */  sw         $s3, 0x4C($sp)
    /* 89B630 800E6A30 AFB20048 */  sw         $s2, 0x48($sp)
    /* 89B634 800E6A34 AFB10044 */  sw         $s1, 0x44($sp)

    jal        bike_select_get_aspect_metrics
    nop
    addiu      $t9, $zero, 0xA0
    subu       $s4, $t9, $v0
    addu       $s2, $t9, $v0

    /* 89B638 800E6A38 C60E0010 */  lwc1       $fa1, 0x10($s0)
    /* 89B63C 800E6A3C C60C0014 */  lwc1       $fa0, 0x14($s0)
    /* 89B640 800E6A40 460C7080 */  add.s      $fv1, $fa1, $fa0
    /* 89B644 800E6A44 3C01800A */  lui        $at, %hi(D_8009E654)
    /* 89B648 800E6A48 C426E654 */  lwc1       $ft1, %lo(D_8009E654)($at)
    /* 89B64C 800E6A4C C60A0018 */  lwc1       $ft3, 0x18($s0)
    /* 89B650 800E6A50 46061080 */  add.s      $fv1, $fv1, $ft1
    /* 89B654 800E6A54 C608001C */  lwc1       $ft2, 0x1C($s0)
    /* 89B658 800E6A58 3C01800A */  lui        $at, %hi(D_8009E658)
    /* 89B65C 800E6A5C C424E658 */  lwc1       $ft0, %lo(D_8009E658)($at)
    /* 89B660 800E6A60 46085000 */  add.s      $fv0, $ft3, $ft2
    /* 89B664 800E6A64 46041082 */  mul.s      $fv1, $fv1, $ft0
    /* 89B668 800E6A68 46060000 */  add.s      $fv0, $fv0, $ft1
    /* 89B66C 800E6A6C 46040002 */  mul.s      $fv0, $fv0, $ft0
    /* 89B670 800E6A70 4600110D */  trunc.w.s  $ft0, $fv1
    /* 89B674 800E6A74 441E2000 */  mfc1       $fp, $ft0
    /* 89B678 800E6A78 4600008D */  trunc.w.s  $fv1, $fv0
    /* 89B67C 800E6A7C 44171000 */  mfc1       $s7, $fv1
    /* 89B680 800E6A80 4600700D */  trunc.w.s  $fv0, $fa1
    /* RECOMP ASPECT MOD */               nop
    /* 89B688 800E6A88 4600600D */  trunc.w.s  $fv0, $fa0
    /* RECOMP ASPECT MOD */               nop
    /* 89B690 800E6A90 3C028009 */  lui        $v0, %hi(D_80095690)
    /* 89B694 800E6A94 8C425690 */  lw         $v0, %lo(D_80095690)($v0)
    /* 89B698 800E6A98 4600500D */  trunc.w.s  $fv0, $ft3
    /* 89B69C 800E6A9C 44130000 */  mfc1       $s3, $fv0
    /* 89B6A0 800E6AA0 4600400D */  trunc.w.s  $fv0, $ft2
    /* 89B6A4 800E6AA4 44150000 */  mfc1       $s5, $fv0
    /* 89B6A8 800E6AA8 00021100 */  sll        $v0, $v0, 4
    /* 89B6AC 800E6AAC 24420080 */  addiu      $v0, $v0, 0x80
    /* 89B6B0 800E6AB0 02024021 */  addu       $t0, $s0, $v0
    /* 89B6B4 800E6AB4 2642FFFC */  addiu      $v0, $s2, -0x4
    /* 89B6B8 800E6AB8 0282102A */  slt        $v0, $s4, $v0
    /* 89B6BC 800E6ABC 10400194 */  beqz       $v0, .L800E7110
    /* 89B6C0 800E6AC0 26A2FFFC */   addiu     $v0, $s5, -0x4
    /* 89B6C4 800E6AC4 0262102A */  slt        $v0, $s3, $v0
    /* 89B6C8 800E6AC8 10400191 */  beqz       $v0, .L800E7110
    /* 89B6CC 800E6ACC 240701FF */   addiu     $a3, $zero, 0x1FF
    /* 89B6D0 800E6AD0 460E6001 */  sub.s      $fv0, $fa0, $fa1
    /* 89B6D4 800E6AD4 46000000 */  add.s      $fv0, $fv0, $fv0
    /* 89B6D8 800E6AD8 4600008D */  trunc.w.s  $fv1, $fv0
    /* 89B6DC 800E6ADC 44021000 */  mfc1       $v0, $fv1
    /* 89B6E0 800E6AE0 A5020000 */  sh         $v0, 0x0($t0)
    /* 89B6E4 800E6AE4 C600001C */  lwc1       $fv0, 0x1C($s0)
    /* 89B6E8 800E6AE8 C6020018 */  lwc1       $fv1, 0x18($s0)
    /* 89B6EC 800E6AEC 46020001 */  sub.s      $fv0, $fv0, $fv1
    /* 89B6F0 800E6AF0 46000000 */  add.s      $fv0, $fv0, $fv0
    /* 89B6F4 800E6AF4 A5070004 */  sh         $a3, 0x4($t0)
    /* 89B6F8 800E6AF8 A5000006 */  sh         $zero, 0x6($t0)
    /* 89B6FC 800E6AFC 4600008D */  trunc.w.s  $fv1, $fv0
    /* 89B700 800E6B00 44021000 */  mfc1       $v0, $fv1
    /* 89B704 800E6B04 A5020002 */  sh         $v0, 0x2($t0)
    /* 89B708 800E6B08 C6000010 */  lwc1       $fv0, 0x10($s0)
    /* 89B70C 800E6B0C C6020014 */  lwc1       $fv1, 0x14($s0)
    /* 89B710 800E6B10 46020000 */  add.s      $fv0, $fv0, $fv1
    /* 89B714 800E6B14 3C160380 */  lui        $s6, (0x3800010 >> 16)
    /* 89B718 800E6B18 46000000 */  add.s      $fv0, $fv0, $fv0
    /* 89B71C 800E6B1C 36D60010 */  ori        $s6, $s6, (0x3800010 & 0xFFFF)
    /* 89B720 800E6B20 26650001 */  addiu      $a1, $s3, 0x1
    /* 89B724 800E6B24 00053027 */  nor        $a2, $zero, $a1
    /* 89B728 800E6B28 4600008D */  trunc.w.s  $fv1, $fv0
    /* 89B72C 800E6B2C 44021000 */  mfc1       $v0, $fv1
    /* 89B730 800E6B30 A5020008 */  sh         $v0, 0x8($t0)
    /* 89B734 800E6B34 C6000018 */  lwc1       $fv0, 0x18($s0)
    /* 89B738 800E6B38 C602001C */  lwc1       $fv1, 0x1C($s0)
    /* 89B73C 800E6B3C 000637C3 */  sra        $a2, $a2, 31
    /* 89B740 800E6B40 3C118017 */  lui        $s1, %hi(gMasterDisp)
    /* 89B744 800E6B44 263189EC */  addiu      $s1, $s1, %lo(gMasterDisp)
    /* 89B748 800E6B48 46020000 */  add.s      $fv0, $fv0, $fv1
    /* 89B74C 800E6B4C 3C01800A */  lui        $at, %hi(D_8009E65C)
    /* 89B750 800E6B50 C426E65C */  lwc1       $ft1, %lo(D_8009E65C)($at)
    /* 89B754 800E6B54 26830001 */  addiu      $v1, $s4, 0x1
    /* 89B758 800E6B58 00032027 */  nor        $a0, $zero, $v1
    /* 89B75C 800E6B5C 46000000 */  add.s      $fv0, $fv0, $fv0
    /* 89B760 800E6B60 000427C3 */  sra        $a0, $a0, 31
    /* 89B764 800E6B64 00641824 */  and        $v1, $v1, $a0
    /* 89B768 800E6B68 A507000C */  sh         $a3, 0xC($t0)
    /* 89B76C 800E6B6C 4600008D */  trunc.w.s  $fv1, $fv0
    /* 89B770 800E6B70 44021000 */  mfc1       $v0, $fv1
    /* 89B774 800E6B74 44831000 */  mtc1       $v1, $fv1
    /* 89B778 800E6B78 468010A0 */  cvt.s.w    $fv1, $fv1
    /* 89B77C 800E6B7C 46061082 */  mul.s      $fv1, $fv1, $ft1
    /* 89B780 800E6B80 00A62824 */  and        $a1, $a1, $a2
    /* 89B784 800E6B84 A500000E */  sh         $zero, 0xE($t0)
    /* 89B788 800E6B88 A502000A */  sh         $v0, 0xA($t0)
    /* 89B78C 800E6B8C 8E270000 */  lw         $a3, 0x0($s1)
    /* 89B790 800E6B90 44850000 */  mtc1       $a1, $fv0
    /* 89B794 800E6B94 46800020 */  cvt.s.w    $fv0, $fv0
    /* 89B798 800E6B98 46060002 */  mul.s      $fv0, $fv0, $ft1
    /* 89B79C 800E6B9C 24E20008 */  addiu      $v0, $a3, 0x8
    /* 89B7A0 800E6BA0 AE220000 */  sw         $v0, 0x0($s1)
    /* 89B7A4 800E6BA4 24E20010 */  addiu      $v0, $a3, 0x10
    /* 89B7A8 800E6BA8 ACF60000 */  sw         $s6, 0x0($a3)
    /* 89B7AC 800E6BAC ACE80004 */  sw         $t0, 0x4($a3)
    /* 89B7B0 800E6BB0 AE220000 */  sw         $v0, 0x0($s1)
    /* 89B7B4 800E6BB4 4600110D */  trunc.w.s  $ft0, $fv1
    /* 89B7B8 800E6BB8 44022000 */  mfc1       $v0, $ft0
    /* 89B7BC 800E6BBC 30420FFF */  andi       $v0, $v0, 0xFFF
    /* 89B7C0 800E6BC0 00021300 */  sll        $v0, $v0, 12
    /* 89B7C4 800E6BC4 4600008D */  trunc.w.s  $fv1, $fv0
    /* 89B7C8 800E6BC8 44031000 */  mfc1       $v1, $fv1
    /* 89B7CC 800E6BCC 30630FFF */  andi       $v1, $v1, 0xFFF
    /* 89B7D0 800E6BD0 3C04ED00 */  lui        $a0, (0xED000000 >> 16)
    /* 89B7D4 800E6BD4 00641825 */  or         $v1, $v1, $a0
    /* 89B7D8 800E6BD8 00431025 */  or         $v0, $v0, $v1
    /* 89B7DC 800E6BDC ACE20008 */  sw         $v0, 0x8($a3)
    /* 89B7E0 800E6BE0 2A420141 */  slti       $v0, $s2, 0x141
    /* 89B7E4 800E6BE4 14400002 */  bnez       $v0, .L800E6BF0
    /* 89B7E8 800E6BE8 02404821 */   addu      $t1, $s2, $zero
    /* 89B7EC 800E6BEC 24090140 */  addiu      $t1, $zero, 0x140
  .L800E6BF0:
    /* 89B7F0 800E6BF0 44890000 */  mtc1       $t1, $fv0
    /* 89B7F4 800E6BF4 46800020 */  cvt.s.w    $fv0, $fv0
    /* 89B7F8 800E6BF8 46060002 */  mul.s      $fv0, $fv0, $ft1
    /* 89B7FC 800E6BFC 4600008D */  trunc.w.s  $fv1, $fv0
    /* 89B800 800E6C00 44021000 */  mfc1       $v0, $fv1
    /* 89B804 800E6C04 30420FFF */  andi       $v0, $v0, 0xFFF
    /* 89B808 800E6C08 00022B00 */  sll        $a1, $v0, 12
    /* 89B80C 800E6C0C 2AA200F1 */  slti       $v0, $s5, 0xF1
    /* 89B810 800E6C10 14400002 */  bnez       $v0, .L800E6C1C
    /* 89B814 800E6C14 02A02021 */   addu      $a0, $s5, $zero
    /* 89B818 800E6C18 240400F0 */  addiu      $a0, $zero, 0xF0
  .L800E6C1C:
    /* 89B81C 800E6C1C 44840000 */  mtc1       $a0, $fv0
    /* 89B820 800E6C20 46800020 */  cvt.s.w    $fv0, $fv0
    /* 89B824 800E6C24 46060002 */  mul.s      $fv0, $fv0, $ft1
    /* 89B828 800E6C28 4600008D */  trunc.w.s  $fv1, $fv0
    /* 89B82C 800E6C2C 44021000 */  mfc1       $v0, $fv1
    /* 89B830 800E6C30 30420FFF */  andi       $v0, $v0, 0xFFF
    /* 89B834 800E6C34 00A21025 */  or         $v0, $a1, $v0
    /* 89B838 800E6C38 ACE2000C */  sw         $v0, 0xC($a3)
    /* 89B83C 800E6C3C 8E04000C */  lw         $a0, 0xC($s0)
    /* 89B840 800E6C40 000417C2 */  srl        $v0, $a0, 31
    /* 89B844 800E6C44 00822021 */  addu       $a0, $a0, $v0
    /* 89B848 800E6C48 0C03C6BE */  jal        func_800F1AF8
    /* 89B84C 800E6C4C 00042043 */   sra       $a0, $a0, 1
    /* 89B850 800E6C50 8E230000 */  lw         $v1, 0x0($s1)
    /* 89B854 800E6C54 3C05BA00 */  lui        $a1, (0xBA000E02 >> 16)
    /* 89B858 800E6C58 34A50E02 */  ori        $a1, $a1, (0xBA000E02 & 0xFFFF)
    /* 89B85C 800E6C5C 3C04E700 */  lui        $a0, (0xE7000000 >> 16)
    /* 89B860 800E6C60 24620008 */  addiu      $v0, $v1, 0x8
    /* 89B864 800E6C64 AE220000 */  sw         $v0, 0x0($s1)
    /* 89B868 800E6C68 24620010 */  addiu      $v0, $v1, 0x10
    /* 89B86C 800E6C6C AC640000 */  sw         $a0, 0x0($v1)
    /* 89B870 800E6C70 AC600004 */  sw         $zero, 0x4($v1)
    /* 89B874 800E6C74 AE220000 */  sw         $v0, 0x0($s1)
    /* 89B878 800E6C78 3C028009 */  lui        $v0, %hi(D_800970B8)
    /* 89B87C 800E6C7C 244270B8 */  addiu      $v0, $v0, %lo(D_800970B8)
    /* 89B880 800E6C80 AC62000C */  sw         $v0, 0xC($v1)
    /* 89B884 800E6C84 24620018 */  addiu      $v0, $v1, 0x18
    /* 89B888 800E6C88 AC760008 */  sw         $s6, 0x8($v1)
    /* 89B88C 800E6C8C AE220000 */  sw         $v0, 0x0($s1)
    /* 89B890 800E6C90 24620020 */  addiu      $v0, $v1, 0x20
    /* 89B894 800E6C94 AC640010 */  sw         $a0, 0x10($v1)
    /* 89B898 800E6C98 AC600014 */  sw         $zero, 0x14($v1)
    /* 89B89C 800E6C9C AE220000 */  sw         $v0, 0x0($s1)
    /* 89B8A0 800E6CA0 34028000 */  ori        $v0, $zero, 0x8000
    /* 89B8A4 800E6CA4 AC650018 */  sw         $a1, 0x18($v1)
    /* 89B8A8 800E6CA8 AC62001C */  sw         $v0, 0x1C($v1)
    /* 89B8AC 800E6CAC 8E050044 */  lw         $a1, 0x44($s0)
    /* 89B8B0 800E6CB0 04A0006F */  bltz       $a1, .L800E6E70
    /* 89B8B4 800E6CB4 00000000 */   nop
    /* 89B8B8 800E6CB8 8E040048 */  lw         $a0, 0x48($s0)
    /* 89B8BC 800E6CBC 18800042 */  blez       $a0, .L800E6DC8
    /* 89B8C0 800E6CC0 24020002 */   addiu     $v0, $zero, 0x2
    /* 89B8C4 800E6CC4 8E030004 */  lw         $v1, 0x4($s0)
    /* 89B8C8 800E6CC8 1062000D */  beq        $v1, $v0, .L800E6D00
    /* 89B8CC 800E6CCC 00001821 */   addu      $v1, $zero, $zero
    /* 89B8D0 800E6CD0 8E020190 */  lw         $v0, 0x190($s0)
    /* 89B8D4 800E6CD4 1440000A */  bnez       $v0, .L800E6D00
    /* 89B8D8 800E6CD8 288200FF */   slti      $v0, $a0, 0xFF
    /* 89B8DC 800E6CDC 10400008 */  beqz       $v0, .L800E6D00
    /* 89B8E0 800E6CE0 24030001 */   addiu     $v1, $zero, 0x1
    /* 89B8E4 800E6CE4 8E020008 */  lw         $v0, 0x8($s0)
    /* 89B8E8 800E6CE8 8C420008 */  lw         $v0, 0x8($v0)
    /* 89B8EC 800E6CEC 00A21026 */  xor        $v0, $a1, $v0
    /* 89B8F0 800E6CF0 0002102B */  sltu       $v0, $zero, $v0
    /* 89B8F4 800E6CF4 00021023 */  negu       $v0, $v0
    /* 89B8F8 800E6CF8 30420003 */  andi       $v0, $v0, 0x3
    /* 89B8FC 800E6CFC 34430002 */  ori        $v1, $v0, 0x2
  .L800E6D00:
    /* 89B900 800E6D00 C6000064 */  lwc1       $fv0, 0x64($s0)
    /* 89B904 800E6D04 8E020044 */  lw         $v0, 0x44($s0)
    /* 89B908 800E6D08 E7A00010 */  swc1       $fv0, 0x10($sp)
    /* 89B90C 800E6D0C C6000068 */  lwc1       $fv0, 0x68($s0)
    /* 89B910 800E6D10 E7A00014 */  swc1       $fv0, 0x14($sp)
    /* 89B914 800E6D14 C600006C */  lwc1       $fv0, 0x6C($s0)
    /* 89B918 800E6D18 E7A00018 */  swc1       $fv0, 0x18($sp)
    /* 89B91C 800E6D1C C6000010 */  lwc1       $fv0, 0x10($s0)
    /* 89B920 800E6D20 C6020014 */  lwc1       $fv1, 0x14($s0)
    /* 89B924 800E6D24 46020000 */  add.s      $fv0, $fv0, $fv1
    /* 89B928 800E6D28 3C01800A */  lui        $at, %hi(D_8009E660)
    /* 89B92C 800E6D2C C424E660 */  lwc1       $ft0, %lo(D_8009E660)($at)
    /* 89B930 800E6D30 46040002 */  mul.s      $fv0, $fv0, $ft0
    /* 89B934 800E6D34 E7A0001C */  swc1       $fv0, 0x1C($sp)
    /* 89B938 800E6D38 C6000018 */  lwc1       $fv0, 0x18($s0)
    /* 89B93C 800E6D3C C602001C */  lwc1       $fv1, 0x1C($s0)
    /* 89B940 800E6D40 46020000 */  add.s      $fv0, $fv0, $fv1
    /* 89B944 800E6D44 46040002 */  mul.s      $fv0, $fv0, $ft0
    /* 89B948 800E6D48 AFA00024 */  sw         $zero, 0x24($sp)
    /* 89B94C 800E6D4C E7A00020 */  swc1       $fv0, 0x20($sp)
    /* 89B950 800E6D50 C6000014 */  lwc1       $fv0, 0x14($s0)
    /* 89B954 800E6D54 C6020010 */  lwc1       $fv1, 0x10($s0)
    /* 89B958 800E6D58 46020001 */  sub.s      $fv0, $fv0, $fv1
    /* 89B95C 800E6D5C C602001C */  lwc1       $fv1, 0x1C($s0)
    /* 89B960 800E6D60 46020000 */  add.s      $fv0, $fv0, $fv1
    /* 89B964 800E6D64 C6020018 */  lwc1       $fv1, 0x18($s0)
    /* 89B968 800E6D68 46020001 */  sub.s      $fv0, $fv0, $fv1
    /* 89B96C 800E6D6C 3C01800A */  lui        $at, %hi(D_8009E664)
    /* 89B970 800E6D70 C422E664 */  lwc1       $fv1, %lo(D_8009E664)($at)
    /* 89B974 800E6D74 46020002 */  mul.s      $fv0, $fv0, $fv1
    /* 89B978 800E6D78 00021080 */  sll        $v0, $v0, 2
    /* 89B97C 800E6D7C AFB4002C */  sw         $s4, 0x2C($sp)
    /* 89B980 800E6D80 AFB20030 */  sw         $s2, 0x30($sp)
    /* 89B984 800E6D84 AFB30034 */  sw         $s3, 0x34($sp)
    /* 89B988 800E6D88 AFB50038 */  sw         $s5, 0x38($sp)
    /* 89B98C 800E6D8C AFA3003C */  sw         $v1, 0x3C($sp)
    /* 89B990 800E6D90 E7A00028 */  swc1       $fv0, 0x28($sp)
    /* 89B994 800E6D94 3C018018 */  lui        $at, %hi(D_8017AA50)
    /* 89B998 800E6D98 00220821 */  addu       $at, $at, $v0
    /* 89B99C 800E6D9C 8C24AA50 */  lw         $a0, %lo(D_8017AA50)($at)
    /* 89B9A0 800E6DA0 3C028009 */  lui        $v0, %hi(D_80095690)
    /* 89B9A4 800E6DA4 8C425690 */  lw         $v0, %lo(D_80095690)($v0)
    /* 89B9A8 800E6DA8 8E060048 */  lw         $a2, 0x48($s0)
    /* 89B9AC 800E6DAC 8E07007C */  lw         $a3, 0x7C($s0)
    /* 89B9B0 800E6DB0 00022900 */  sll        $a1, $v0, 4
    /* 89B9B4 800E6DB4 00A22823 */  subu       $a1, $a1, $v0
    /* 89B9B8 800E6DB8 000528C0 */  sll        $a1, $a1, 3
    /* 89B9BC 800E6DBC 24A500A0 */  addiu      $a1, $a1, 0xA0
    /* 89B9C0 800E6DC0 0C038ED2 */  jal        func_800E3B48
    /* 89B9C4 800E6DC4 02052821 */   addu      $a1, $s0, $a1
  .L800E6DC8:
    /* 89B9C8 800E6DC8 8E02004C */  lw         $v0, 0x4C($s0)
    /* 89B9CC 800E6DCC 18400017 */  blez       $v0, .L800E6E2C
    /* 89B9D0 800E6DD0 26050050 */   addiu     $a1, $s0, 0x50
    /* 89B9D4 800E6DD4 AFB30010 */  sw         $s3, 0x10($sp)
    /* 89B9D8 800E6DD8 AFB50014 */  sw         $s5, 0x14($sp)
    /* 89B9DC 800E6DDC 8E03000C */  lw         $v1, 0xC($s0)
    /* 89B9E0 800E6DE0 8E02004C */  lw         $v0, 0x4C($s0)
    /* 89B9E4 800E6DE4 00620018 */  mult       $v1, $v0
    /* 89B9E8 800E6DE8 00001812 */  mflo       $v1
    /* 89B9EC 800E6DEC 3C028080 */  lui        $v0, (0x80808081 >> 16)
    /* 89B9F0 800E6DF0 34428081 */  ori        $v0, $v0, (0x80808081 & 0xFFFF)
    /* 89B9F4 800E6DF4 00620018 */  mult       $v1, $v0
    /* 89B9F8 800E6DF8 00006010 */  mfhi       $t4
    /* 89B9FC 800E6DFC 01831021 */  addu       $v0, $t4, $v1
    /* 89BA00 800E6E00 000211C3 */  sra        $v0, $v0, 7
    /* 89BA04 800E6E04 00031FC3 */  sra        $v1, $v1, 31
    /* 89BA08 800E6E08 00431023 */  subu       $v0, $v0, $v1
    /* 89BA0C 800E6E0C AFA20018 */  sw         $v0, 0x18($sp)
    /* 89BA10 800E6E10 8E020008 */  lw         $v0, 0x8($s0)
    /* 89BA14 800E6E14 8C420008 */  lw         $v0, 0x8($v0)
    /* 89BA18 800E6E18 AFA2001C */  sw         $v0, 0x1C($sp)
    /* 89BA1C 800E6E1C 8E040044 */  lw         $a0, 0x44($s0)
    # RECOMP ASPECT MOD:
    /* 89BA20 800E6E20 24060000 */  addiu      $a2, $zero, 0x0
    /* 89BA24 800E6E24 0C03975A */  jal        func_800E5D68
    /* 89BA28 800E6E28 24070140 */   addiu     $a3, $zero, 0x140
  .L800E6E2C:
    /* 89BA2C 800E6E2C 8E030194 */  lw         $v1, 0x194($s0)
    /* 89BA30 800E6E30 1860000F */  blez       $v1, .L800E6E70
    /* 89BA34 800E6E34 02002021 */   addu      $a0, $s0, $zero
    /* 89BA38 800E6E38 8E02000C */  lw         $v0, 0xC($s0)
    /* 89BA3C 800E6E3C 00430018 */  mult       $v0, $v1
    /* 89BA40 800E6E40 00001012 */  mflo       $v0
    /* 89BA44 800E6E44 3C038080 */  lui        $v1, (0x80808081 >> 16)
    /* 89BA48 800E6E48 34638081 */  ori        $v1, $v1, (0x80808081 & 0xFFFF)
    /* 89BA4C 800E6E4C 00430018 */  mult       $v0, $v1
    /* 89BA50 800E6E50 03C02821 */  addu       $a1, $fp, $zero
    /* 89BA54 800E6E54 02E03021 */  addu       $a2, $s7, $zero
    /* 89BA58 800E6E58 00006010 */  mfhi       $t4
    /* 89BA5C 800E6E5C 01823821 */  addu       $a3, $t4, $v0
    /* 89BA60 800E6E60 000739C3 */  sra        $a3, $a3, 7
    /* 89BA64 800E6E64 000217C3 */  sra        $v0, $v0, 31
    /* 89BA68 800E6E68 0C03981F */  jal        func_800E607C
    /* 89BA6C 800E6E6C 00E23823 */   subu      $a3, $a3, $v0
  .L800E6E70:
    /* 89BA70 800E6E70 3C118017 */  lui        $s1, %hi(gMasterDisp)
    /* 89BA74 800E6E74 263189EC */  addiu      $s1, $s1, %lo(gMasterDisp)
    /* 89BA78 800E6E78 0C018ADE */  jal        func_80062B78
    /* 89BA7C 800E6E7C 02202021 */   addu      $a0, $s1, $zero
    /* 89BA80 800E6E80 8E02004C */  lw         $v0, 0x4C($s0)
    /* 89BA84 800E6E84 28420041 */  slti       $v0, $v0, 0x41
    /* 89BA88 800E6E88 1440002E */  bnez       $v0, .L800E6F44
    /* 89BA8C 800E6E8C 26870008 */   addiu     $a3, $s4, 0x8
    /* 89BA90 800E6E90 28E2001C */  slti       $v0, $a3, 0x1C
    /* 89BA94 800E6E94 54400001 */  bnel       $v0, $zero, .L800E6E9C
    /* 89BA98 800E6E98 2407001C */   addiu     $a3, $zero, 0x1C
  .L800E6E9C:
    /* 89BA9C 800E6E9C 26640008 */  addiu      $a0, $s3, 0x8
    /* 89BAA0 800E6EA0 28820018 */  slti       $v0, $a0, 0x18
    /* 89BAA4 800E6EA4 54400001 */  bnel       $v0, $zero, .L800E6EAC
    /* 89BAA8 800E6EA8 24040018 */   addiu     $a0, $zero, 0x18
  .L800E6EAC:
    /* 89BAAC 800E6EAC 3C0300FF */  lui        $v1, (0xFFFFFF >> 16)
    /* 89BAB0 800E6EB0 3463FFFF */  ori        $v1, $v1, (0xFFFFFF & 0xFFFF)
    /* 89BAB4 800E6EB4 24020001 */  addiu      $v0, $zero, 0x1
    /* 89BAB8 800E6EB8 AFA20014 */  sw         $v0, 0x14($sp)
    /* 89BABC 800E6EBC AFA20018 */  sw         $v0, 0x18($sp)
    /* 89BAC0 800E6EC0 24020005 */  addiu      $v0, $zero, 0x5
    /* 89BAC4 800E6EC4 AFA40010 */  sw         $a0, 0x10($sp)
    /* 89BAC8 800E6EC8 AFA2001C */  sw         $v0, 0x1C($sp)
    /* 89BACC 800E6ECC AFA30020 */  sw         $v1, 0x20($sp)
    /* 89BAD0 800E6ED0 8E02004C */  lw         $v0, 0x4C($s0)
    /* 89BAD4 800E6ED4 3C035555 */  lui        $v1, (0x55555556 >> 16)
    /* 89BAD8 800E6ED8 34635556 */  ori        $v1, $v1, (0x55555556 & 0xFFFF)
    /* 89BADC 800E6EDC 00021080 */  sll        $v0, $v0, 2
    /* 89BAE0 800E6EE0 00430018 */  mult       $v0, $v1
    /* 89BAE4 800E6EE4 000217C3 */  sra        $v0, $v0, 31
    /* 89BAE8 800E6EE8 8E03000C */  lw         $v1, 0xC($s0)
    /* 89BAEC 800E6EEC 00006010 */  mfhi       $t4
    /* 89BAF0 800E6EF0 01821023 */  subu       $v0, $t4, $v0
    /* 89BAF4 800E6EF4 2442FFAB */  addiu      $v0, $v0, -0x55
    /* 89BAF8 800E6EF8 00620018 */  mult       $v1, $v0
    /* 89BAFC 800E6EFC 00001812 */  mflo       $v1
    /* 89BB00 800E6F00 3C028080 */  lui        $v0, (0x80808081 >> 16)
    /* 89BB04 800E6F04 34428081 */  ori        $v0, $v0, (0x80808081 & 0xFFFF)
    /* 89BB08 800E6F08 00620018 */  mult       $v1, $v0
    /* 89BB0C 800E6F0C 02202021 */  addu       $a0, $s1, $zero
    /* 89BB10 800E6F10 00006010 */  mfhi       $t4
    /* 89BB14 800E6F14 01831021 */  addu       $v0, $t4, $v1
    /* 89BB18 800E6F18 000211C3 */  sra        $v0, $v0, 7
    /* 89BB1C 800E6F1C 00031FC3 */  sra        $v1, $v1, 31
    /* 89BB20 800E6F20 00431023 */  subu       $v0, $v0, $v1
    /* 89BB24 800E6F24 AFA20024 */  sw         $v0, 0x24($sp)
    /* 89BB28 800E6F28 8E020008 */  lw         $v0, 0x8($s0)
    /* 89BB2C 800E6F2C 3C05800A */  lui        $a1, %hi(D_8009E644)
    /* 89BB30 800E6F30 24A5E644 */  addiu      $a1, $a1, %lo(D_8009E644)
    /* 89BB34 800E6F34 24060002 */  addiu      $a2, $zero, 0x2
    /* 89BB38 800E6F38 24420015 */  addiu      $v0, $v0, 0x15
    /* 89BB3C 800E6F3C 0C019101 */  jal        func_80064404
    /* 89BB40 800E6F40 AFA20028 */   sw        $v0, 0x28($sp)
  .L800E6F44:
    /* 89BB44 800E6F44 8E020040 */  lw         $v0, 0x40($s0)
    /* 89BB48 800E6F48 18400023 */  blez       $v0, .L800E6FD8
    /* 89BB4C 800E6F4C 00000000 */   nop
    /* 89BB50 800E6F50 0C017610 */  jal        func_8005D840
    /* 89BB54 800E6F54 24040001 */   addiu     $a0, $zero, 0x1
    /* 89BB58 800E6F58 3C0400FF */  lui        $a0, (0xFFFFFF >> 16)
    /* 89BB5C 800E6F5C 3484FFFF */  ori        $a0, $a0, (0xFFFFFF & 0xFFFF)
    /* 89BB60 800E6F60 26E3FFF8 */  addiu      $v1, $s7, -0x8
    /* 89BB64 800E6F64 AFA30010 */  sw         $v1, 0x10($sp)
    /* 89BB68 800E6F68 24030001 */  addiu      $v1, $zero, 0x1
    /* 89BB6C 800E6F6C AFA30014 */  sw         $v1, 0x14($sp)
    /* 89BB70 800E6F70 240300F0 */  addiu      $v1, $zero, 0xF0
    /* 89BB74 800E6F74 AFA30018 */  sw         $v1, 0x18($sp)
    /* 89BB78 800E6F78 24030010 */  addiu      $v1, $zero, 0x10
    /* 89BB7C 800E6F7C AFA3001C */  sw         $v1, 0x1C($sp)
    /* 89BB80 800E6F80 AFA40020 */  sw         $a0, 0x20($sp)
    /* 89BB84 800E6F84 8E08000C */  lw         $t0, 0xC($s0)
    /* 89BB88 800E6F88 8E030040 */  lw         $v1, 0x40($s0)
    /* 89BB8C 800E6F8C 01030018 */  mult       $t0, $v1
    /* 89BB90 800E6F90 00004012 */  mflo       $t0
    /* 89BB94 800E6F94 3C038080 */  lui        $v1, (0x80808081 >> 16)
    /* 89BB98 800E6F98 34638081 */  ori        $v1, $v1, (0x80808081 & 0xFFFF)
    /* 89BB9C 800E6F9C 01030018 */  mult       $t0, $v1
    /* 89BBA0 800E6FA0 3C048017 */  lui        $a0, %hi(gMasterDisp)
    /* 89BBA4 800E6FA4 248489EC */  addiu      $a0, $a0, %lo(gMasterDisp)
    /* 89BBA8 800E6FA8 3C05800A */  lui        $a1, %hi(D_8009E64C)
    /* 89BBAC 800E6FAC 24A5E64C */  addiu      $a1, $a1, %lo(D_8009E64C)
    /* 89BBB0 800E6FB0 00003021 */  addu       $a2, $zero, $zero
    /* 89BBB4 800E6FB4 03C03821 */  addu       $a3, $fp, $zero
    /* 89BBB8 800E6FB8 AFA20028 */  sw         $v0, 0x28($sp)
    /* 89BBBC 800E6FBC 00006010 */  mfhi       $t4
    /* 89BBC0 800E6FC0 01881021 */  addu       $v0, $t4, $t0
    /* 89BBC4 800E6FC4 000211C3 */  sra        $v0, $v0, 7
    /* 89BBC8 800E6FC8 000847C3 */  sra        $t0, $t0, 31
    /* 89BBCC 800E6FCC 00481023 */  subu       $v0, $v0, $t0
    /* 89BBD0 800E6FD0 0C019101 */  jal        func_80064404
    /* 89BBD4 800E6FD4 AFA20024 */   sw        $v0, 0x24($sp)
  .L800E6FD8:
    /* 89BBD8 800E6FD8 3C108017 */  lui        $s0, %hi(gMasterDisp)
    /* 89BBDC 800E6FDC 261089EC */  addiu      $s0, $s0, %lo(gMasterDisp)

    // Player name
    jal EG_RectAlign_Origin_Left_Left
    nop

    /* 89BBE0 800E6FE0 0C018B20 */  jal        func_80062C80
    /* 89BBE4 800E6FE4 02002021 */   addu      $a0, $s0, $zero

    jal EG_RectAlign_Origin_None_None
    nop

    /* 89BBE8 800E6FE8 3C040050 */  lui        $a0, (0x5003C0 >> 16)
    /* 89BBEC 800E6FEC 348403C0 */  ori        $a0, $a0, (0x5003C0 & 0xFFFF)
    /* 89BBF0 800E6FF0 3C050001 */  lui        $a1, (0x10001 >> 16)
    /* 89BBF4 800E6FF4 34A50001 */  ori        $a1, $a1, (0x10001 & 0xFFFF)
    /* 89BBF8 800E6FF8 3C0BBA00 */  lui        $t3, (0xBA001402 >> 16)
    /* 89BBFC 800E6FFC 356B1402 */  ori        $t3, $t3, (0xBA001402 & 0xFFFF)
    /* 89BC00 800E7000 8E030000 */  lw         $v1, 0x0($s0)
    /* 89BC04 800E7004 3C06B900 */  lui        $a2, (0xB900031D >> 16)
    /* 89BC08 800E7008 34C6031D */  ori        $a2, $a2, (0xB900031D & 0xFFFF)
    /* 89BC0C 800E700C 3C0AE700 */  lui        $t2, (0xE7000000 >> 16)
    /* 89BC10 800E7010 326703FF */  andi       $a3, $s3, 0x3FF
    /* 89BC14 800E7014 00073880 */  sll        $a3, $a3, 2
    /* 89BC18 800E7018 24620008 */  addiu      $v0, $v1, 0x8
    /* 89BC1C 800E701C AE020000 */  sw         $v0, 0x0($s0)
    /* 89BC20 800E7020 24620010 */  addiu      $v0, $v1, 0x10
    /* 89BC24 800E7024 AC6A0000 */  sw         $t2, 0x0($v1)
    /* 89BC28 800E7028 AC600004 */  sw         $zero, 0x4($v1)
    /* 89BC2C 800E702C AE020000 */  sw         $v0, 0x0($s0)
    /* 89BC30 800E7030 3C02ED00 */  lui        $v0, (0xED000000 >> 16)
    /* 89BC34 800E7034 AC620008 */  sw         $v0, 0x8($v1)
    /* 89BC38 800E7038 24620018 */  addiu      $v0, $v1, 0x18
    /* 89BC3C 800E703C AC64000C */  sw         $a0, 0xC($v1)
    /* 89BC40 800E7040 AE020000 */  sw         $v0, 0x0($s0)
    /* 89BC44 800E7044 3C02F700 */  lui        $v0, (0xF7000000 >> 16)
    /* 89BC48 800E7048 AC620010 */  sw         $v0, 0x10($v1)
    /* 89BC4C 800E704C 24620020 */  addiu      $v0, $v1, 0x20
    /* 89BC50 800E7050 AC650014 */  sw         $a1, 0x14($v1)
    /* 89BC54 800E7054 AE020000 */  sw         $v0, 0x0($s0)
    /* 89BC58 800E7058 3C020030 */  lui        $v0, (0x300000 >> 16)
    /* 89BC5C 800E705C AC62001C */  sw         $v0, 0x1C($v1)
    /* 89BC60 800E7060 24620028 */  addiu      $v0, $v1, 0x28
    /* 89BC64 800E7064 AC6B0018 */  sw         $t3, 0x18($v1)
    /* 89BC68 800E7068 AE020000 */  sw         $v0, 0x0($s0)
    /* 89BC6C 800E706C 24620030 */  addiu      $v0, $v1, 0x30
    /* 89BC70 800E7070 324503FF */  andi       $a1, $s2, 0x3FF
    /* 89BC74 800E7074 00052B80 */  sll        $a1, $a1, 14
    /* 89BC78 800E7078 AC660020 */  sw         $a2, 0x20($v1)
    /* 89BC7C 800E707C 3C06F600 */  lui        $a2, (0xF6000000 >> 16)
    /* 89BC80 800E7080 AC600024 */  sw         $zero, 0x24($v1)
    /* 89BC84 800E7084 AE020000 */  sw         $v0, 0x0($s0)
    /* 89BC88 800E7088 00E61025 */  or         $v0, $a3, $a2
    /* 89BC8C 800E708C 00A21025 */  or         $v0, $a1, $v0
    /* 89BC90 800E7090 328403FF */  andi       $a0, $s4, 0x3FF
    /* 89BC94 800E7094 00042380 */  sll        $a0, $a0, 14
    /* 89BC98 800E7098 00874825 */  or         $t1, $a0, $a3
    /* 89BC9C 800E709C AC620028 */  sw         $v0, 0x28($v1)
    /* 89BCA0 800E70A0 24620038 */  addiu      $v0, $v1, 0x38
    /* 89BCA4 800E70A4 AC69002C */  sw         $t1, 0x2C($v1)
    /* 89BCA8 800E70A8 AE020000 */  sw         $v0, 0x0($s0)
    /* 89BCAC 800E70AC 32A203FF */  andi       $v0, $s5, 0x3FF
    /* 89BCB0 800E70B0 00021080 */  sll        $v0, $v0, 2
    /* 89BCB4 800E70B4 00463025 */  or         $a2, $v0, $a2
    /* 89BCB8 800E70B8 00A64025 */  or         $t0, $a1, $a2
    /* 89BCBC 800E70BC 00821025 */  or         $v0, $a0, $v0
    /* 89BCC0 800E70C0 AC620034 */  sw         $v0, 0x34($v1)
    /* 89BCC4 800E70C4 24620040 */  addiu      $v0, $v1, 0x40
    /* 89BCC8 800E70C8 00862025 */  or         $a0, $a0, $a2
    /* 89BCCC 800E70CC AC680030 */  sw         $t0, 0x30($v1)
    /* 89BCD0 800E70D0 AE020000 */  sw         $v0, 0x0($s0)
    /* 89BCD4 800E70D4 24620048 */  addiu      $v0, $v1, 0x48
    /* 89BCD8 800E70D8 00A72825 */  or         $a1, $a1, $a3
    /* 89BCDC 800E70DC AC640038 */  sw         $a0, 0x38($v1)
    /* 89BCE0 800E70E0 AC69003C */  sw         $t1, 0x3C($v1)
    /* 89BCE4 800E70E4 AE020000 */  sw         $v0, 0x0($s0)
    /* 89BCE8 800E70E8 24620050 */  addiu      $v0, $v1, 0x50
    /* 89BCEC 800E70EC AC680040 */  sw         $t0, 0x40($v1)
    /* 89BCF0 800E70F0 AC650044 */  sw         $a1, 0x44($v1)
    /* 89BCF4 800E70F4 AE020000 */  sw         $v0, 0x0($s0)
    /* 89BCF8 800E70F8 24620058 */  addiu      $v0, $v1, 0x58
    /* 89BCFC 800E70FC AC6A0048 */  sw         $t2, 0x48($v1)
    /* 89BD00 800E7100 AC60004C */  sw         $zero, 0x4C($v1)
    /* 89BD04 800E7104 AE020000 */  sw         $v0, 0x0($s0)
    /* 89BD08 800E7108 AC6B0050 */  sw         $t3, 0x50($v1)
    /* 89BD0C 800E710C AC600054 */  sw         $zero, 0x54($v1)
  .L800E7110:
    /* 89BD10 800E7110 8FBF0064 */  lw         $ra, 0x64($sp)
    /* 89BD14 800E7114 8FBE0060 */  lw         $fp, 0x60($sp)
    /* 89BD18 800E7118 8FB7005C */  lw         $s7, 0x5C($sp)
    /* 89BD1C 800E711C 8FB60058 */  lw         $s6, 0x58($sp)
    /* 89BD20 800E7120 8FB50054 */  lw         $s5, 0x54($sp)
    /* 89BD24 800E7124 8FB40050 */  lw         $s4, 0x50($sp)
    /* 89BD28 800E7128 8FB3004C */  lw         $s3, 0x4C($sp)
    /* 89BD2C 800E712C 8FB20048 */  lw         $s2, 0x48($sp)
    /* 89BD30 800E7130 8FB10044 */  lw         $s1, 0x44($sp)
    /* 89BD34 800E7134 8FB00040 */  lw         $s0, 0x40($sp)
    /* 89BD38 800E7138 27BD0068 */  addiu      $sp, $sp, 0x68
    /* 89BD3C 800E713C 03E00008 */  jr         $ra
    /* 89BD40 800E7140 00000000 */   nop
.size func_800E6A08, . - func_800E6A08

glabel func_800F14F0
    /* 8A60F0 800F14F0 27BDFF48 */  addiu      $sp, $sp, -0xB8
    /* 8A60F4 800F14F4 AFB60098 */  sw         $s6, 0x98($sp)
    /* 8A60F8 800F14F8 0080B021 */  addu       $s6, $a0, $zero
    /* 8A60FC 800F14FC 3C048018 */  lui        $a0, %hi(D_8017ABF8)
    /* 8A6100 800F1500 9484ABF8 */  lhu        $a0, %lo(D_8017ABF8)($a0)
    /* 8A6104 800F1504 AFB7009C */  sw         $s7, 0x9C($sp)
    /* 8A6108 800F1508 00A0B821 */  addu       $s7, $a1, $zero
    /* 8A610C 800F150C AFBE00A0 */  sw         $fp, 0xA0($sp)
    /* 8A6110 800F1510 00C0F021 */  addu       $fp, $a2, $zero
    /* 8A6114 800F1514 AFB20088 */  sw         $s2, 0x88($sp)
    /* 8A6118 800F1518 AFBF00A4 */  sw         $ra, 0xA4($sp)
    /* 8A611C 800F151C AFB50094 */  sw         $s5, 0x94($sp)
    /* 8A6120 800F1520 AFB40090 */  sw         $s4, 0x90($sp)
    /* 8A6124 800F1524 AFB3008C */  sw         $s3, 0x8C($sp)
    /* 8A6128 800F1528 AFB10084 */  sw         $s1, 0x84($sp)
    /* 8A612C 800F152C AFB00080 */  sw         $s0, 0x80($sp)
    /* 8A6130 800F1530 F7B600B0 */  sdc1       $fs1, 0xB0($sp)
    /* 8A6134 800F1534 F7B400A8 */  sdc1       $fs0, 0xA8($sp)
    /* 8A6138 800F1538 0C018577 */  jal        func_800615DC
    /* 8A613C 800F153C 00E09021 */   addu      $s2, $a3, $zero
    /* 8A6140 800F1540 0040A021 */  addu       $s4, $v0, $zero
    /* 8A6144 800F1544 96840000 */  lhu        $a0, 0x0($s4)
    /* 8A6148 800F1548 0C018577 */  jal        func_800615DC
    /* 8A614C 800F154C 00000000 */   nop
    /* 8A6150 800F1550 3C05BA00 */  lui        $a1, (0xBA001402 >> 16)
    /* 8A6154 800F1554 34A51402 */  ori        $a1, $a1, (0xBA001402 & 0xFFFF)
    /* 8A6158 800F1558 3C06BA00 */  lui        $a2, (0xBA000E02 >> 16)
    /* 8A615C 800F155C 34C60E02 */  ori        $a2, $a2, (0xBA000E02 & 0xFFFF)
    /* 8A6160 800F1560 3C070103 */  lui        $a3, (0x1030040 >> 16)
    /* 8A6164 800F1564 3C118017 */  lui        $s1, %hi(gMasterDisp)
    /* 8A6168 800F1568 263189EC */  addiu      $s1, $s1, %lo(gMasterDisp)
    /* 8A616C 800F156C 8E300000 */  lw         $s0, 0x0($s1)
    /* 8A6170 800F1570 34E70040 */  ori        $a3, $a3, (0x1030040 & 0xFFFF)
    /* 8A6174 800F1574 3C048017 */  lui        $a0, %hi(D_8016A138)
    /* 8A6178 800F1578 2484A138 */  addiu      $a0, $a0, %lo(D_8016A138)
    /* 8A617C 800F157C 00409821 */  addu       $s3, $v0, $zero
    /* 8A6180 800F1580 26030008 */  addiu      $v1, $s0, 0x8
    /* 8A6184 800F1584 AE230000 */  sw         $v1, 0x0($s1)
    /* 8A6188 800F1588 3C03E700 */  lui        $v1, (0xE7000000 >> 16)
    /* 8A618C 800F158C AE030000 */  sw         $v1, 0x0($s0)
    /* 8A6190 800F1590 26030010 */  addiu      $v1, $s0, 0x10
    /* 8A6194 800F1594 AE000004 */  sw         $zero, 0x4($s0)
    /* 8A6198 800F1598 AE230000 */  sw         $v1, 0x0($s1)
    /* 8A619C 800F159C 26030018 */  addiu      $v1, $s0, 0x18
    /* 8A61A0 800F15A0 AE050008 */  sw         $a1, 0x8($s0)
    /* 8A61A4 800F15A4 AE00000C */  sw         $zero, 0xC($s0)
    /* 8A61A8 800F15A8 AE230000 */  sw         $v1, 0x0($s1)
    /* 8A61AC 800F15AC 34038000 */  ori        $v1, $zero, 0x8000
    /* 8A61B0 800F15B0 AE030014 */  sw         $v1, 0x14($s0)
    /* 8A61B4 800F15B4 26030020 */  addiu      $v1, $s0, 0x20
    /* 8A61B8 800F15B8 AE060010 */  sw         $a2, 0x10($s0)
    /* 8A61BC 800F15BC AE230000 */  sw         $v1, 0x0($s1)
    /* 8A61C0 800F15C0 0C01FFB4 */  jal        osVirtualToPhysical_recomp
    /* 8A61C4 800F15C4 AE070018 */   sw        $a3, 0x18($s0)
    /* 8A61C8 800F15C8 3C030102 */  lui        $v1, (0x1020040 >> 16)
    /* 8A61CC 800F15CC AE02001C */  sw         $v0, 0x1C($s0)
    /* 8A61D0 800F15D0 8E300000 */  lw         $s0, 0x0($s1)
    /* 8A61D4 800F15D4 34630040 */  ori        $v1, $v1, (0x1020040 & 0xFFFF)
    /* 8A61D8 800F15D8 3C048016 */  lui        $a0, %hi(D_801630E8)
    /* 8A61DC 800F15DC 248430E8 */  addiu      $a0, $a0, %lo(D_801630E8)
    /* 8A61E0 800F15E0 26020008 */  addiu      $v0, $s0, 0x8
    /* 8A61E4 800F15E4 AE220000 */  sw         $v0, 0x0($s1)
    /* 8A61E8 800F15E8 0C01FFB4 */  jal        osVirtualToPhysical_recomp
    /* 8A61EC 800F15EC AE030000 */   sw        $v1, 0x0($s0)
    /* 8A61F0 800F15F0 3C04BC00 */  lui        $a0, (0xBC00000E >> 16)
    /* 8A61F4 800F15F4 AE020004 */  sw         $v0, 0x4($s0)
    /* 8A61F8 800F15F8 8E250000 */  lw         $a1, 0x0($s1)
    /* 8A61FC 800F15FC 3C038017 */  lui        $v1, %hi(D_80175FD0)
    /* 8A6200 800F1600 94635FD0 */  lhu        $v1, %lo(D_80175FD0)($v1)
    /* 8A6204 800F1604 3484000E */  ori        $a0, $a0, (0xBC00000E & 0xFFFF)
    /* 8A6208 800F1608 24A20008 */  addiu      $v0, $a1, 0x8
    /* 8A620C 800F160C AE220000 */  sw         $v0, 0x0($s1)
    /* 8A6210 800F1610 2A4200FF */  slti       $v0, $s2, 0xFF
    /* 8A6214 800F1614 ACA40000 */  sw         $a0, 0x0($a1)
    /* 8A6218 800F1618 14400006 */  bnez       $v0, .L800F1634
    /* 8A621C 800F161C ACA30004 */   sw        $v1, 0x4($a1)
    /* 8A6220 800F1620 3C04B900 */  lui        $a0, (0xB900031D >> 16)
    /* 8A6224 800F1624 3484031D */  ori        $a0, $a0, (0xB900031D & 0xFFFF)
    /* 8A6228 800F1628 3C030F0A */  lui        $v1, (0xF0A4000 >> 16)
    /* 8A622C 800F162C 0803C591 */  j          .L800F1644
    /* 8A6230 800F1630 34634000 */   ori       $v1, $v1, (0xF0A4000 & 0xFFFF)
  .L800F1634:
    /* 8A6234 800F1634 3C04B900 */  lui        $a0, (0xB900031D >> 16)
    /* 8A6238 800F1638 3484031D */  ori        $a0, $a0, (0xB900031D & 0xFFFF)
    /* 8A623C 800F163C 3C030050 */  lui        $v1, (0x504240 >> 16)
    /* 8A6240 800F1640 34634240 */  ori        $v1, $v1, (0x504240 & 0xFFFF)
  .L800F1644:
    /* 8A6244 800F1644 24A20010 */  addiu      $v0, $a1, 0x10
    /* 8A6248 800F1648 AE220000 */  sw         $v0, 0x0($s1)
    /* 8A624C 800F164C ACA40008 */  sw         $a0, 0x8($a1)
    /* 8A6250 800F1650 ACA3000C */  sw         $v1, 0xC($a1)

    jal        bike_select_get_aspect_metrics
     nop
    sw         $v0, 0x4C($sp)
    addiu      $t0, $zero, 0xA0
    subu       $t1, $t0, $v0
    sw         $t1, 0x44($sp)
    sll        $t2, $v0, 1
    sw         $t2, 0x48($sp)
    lui        $at, 0x4240
    mtc1       $at, $fv1
    mul.s      $fv1, $fv0, $fv1
    swc1       $fv1, 0x40($sp)

    /* 8A6254 800F1654 3C06FC45 */  lui        $a2, (0xFC45FE8B >> 16)
    /* 8A6258 800F1658 34C6FE8B */  ori        $a2, $a2, (0xFC45FE8B & 0xFFFF)
    /* 8A625C 800F165C 3C0511FC */  lui        $a1, (0x11FCF67B >> 16)
    /* 8A6260 800F1660 34A5F67B */  ori        $a1, $a1, (0x11FCF67B & 0xFFFF)
    /* 8A6264 800F1664 3C07F500 */  lui        $a3, (0xF5000100 >> 16)
    /* 8A6268 800F1668 34E70100 */  ori        $a3, $a3, (0xF5000100 & 0xFFFF)
    /* 8A626C 800F166C 3C08073F */  lui        $t0, (0x73FC000 >> 16)
    /* 8A6270 800F1670 3508C000 */  ori        $t0, $t0, (0x73FC000 & 0xFFFF)
    /* 8A6274 800F1674 3C090705 */  lui        $t1, (0x7054160 >> 16)
    /* 8A6278 800F1678 35294160 */  ori        $t1, $t1, (0x7054160 & 0xFFFF)
    /* 8A627C 800F167C 3C0A073F */  lui        $t2, (0x73FF100 >> 16)
    /* 8A6280 800F1680 354AF100 */  ori        $t2, $t2, (0x73FF100 & 0xFFFF)
    /* 8A6284 800F1684 3C0CF548 */  lui        $t4, (0xF5481000 >> 16)
    /* 8A6288 800F1688 358C1000 */  ori        $t4, $t4, (0xF5481000 & 0xFFFF)
    /* 8A628C 800F168C 3C0B0005 */  lui        $t3, (0x54160 >> 16)
    /* 8A6290 800F1690 356B4160 */  ori        $t3, $t3, (0x54160 & 0xFFFF)
    /* 8A6294 800F1694 3C0D000F */  lui        $t5, (0xFC07C >> 16)
    /* 8A6298 800F1698 3C158017 */  lui        $s5, %hi(gMasterDisp)
    /* 8A629C 800F169C 26B589EC */  addiu      $s5, $s5, %lo(gMasterDisp)
    /* 8A62A0 800F16A0 8EA20000 */  lw         $v0, 0x0($s5)
    /* 8A62A4 800F16A4 3C048009 */  lui        $a0, %hi(D_80095690)
    /* 8A62A8 800F16A8 8C845690 */  lw         $a0, %lo(D_80095690)($a0)
    /* 8A62AC 800F16AC 35ADC07C */  ori        $t5, $t5, (0xFC07C & 0xFFFF)
    /* 8A62B0 800F16B0 24430008 */  addiu      $v1, $v0, 0x8
    /* 8A62B4 800F16B4 AEA30000 */  sw         $v1, 0x0($s5)
    /* 8A62B8 800F16B8 24430010 */  addiu      $v1, $v0, 0x10
    /* 8A62BC 800F16BC AC460000 */  sw         $a2, 0x0($v0)
    /* 8A62C0 800F16C0 AC450004 */  sw         $a1, 0x4($v0)
    /* 8A62C4 800F16C4 AEA30000 */  sw         $v1, 0x0($s5)
    /* 8A62C8 800F16C8 3C03FA00 */  lui        $v1, (0xFA000000 >> 16)
    /* 8A62CC 800F16CC AC430008 */  sw         $v1, 0x8($v0)
    /* 8A62D0 800F16D0 324300FF */  andi       $v1, $s2, 0xFF
    /* 8A62D4 800F16D4 AC43000C */  sw         $v1, 0xC($v0)
    /* 8A62D8 800F16D8 24430018 */  addiu      $v1, $v0, 0x18
    /* 8A62DC 800F16DC AEA30000 */  sw         $v1, 0x0($s5)
    /* 8A62E0 800F16E0 3C03FD10 */  lui        $v1, (0xFD100000 >> 16)
    /* 8A62E4 800F16E4 AC430010 */  sw         $v1, 0x10($v0)
    /* 8A62E8 800F16E8 24430020 */  addiu      $v1, $v0, 0x20
    /* 8A62EC 800F16EC AC530014 */  sw         $s3, 0x14($v0)
    /* 8A62F0 800F16F0 AEA30000 */  sw         $v1, 0x0($s5)
    /* 8A62F4 800F16F4 3C03E800 */  lui        $v1, (0xE8000000 >> 16)
    /* 8A62F8 800F16F8 AC430018 */  sw         $v1, 0x18($v0)
    /* 8A62FC 800F16FC 24430028 */  addiu      $v1, $v0, 0x28
    /* 8A6300 800F1700 AC40001C */  sw         $zero, 0x1C($v0)
    /* 8A6304 800F1704 AEA30000 */  sw         $v1, 0x0($s5)
    /* 8A6308 800F1708 3C030700 */  lui        $v1, (0x7000000 >> 16)
    /* 8A630C 800F170C AC430024 */  sw         $v1, 0x24($v0)
    /* 8A6310 800F1710 24430030 */  addiu      $v1, $v0, 0x30
    /* 8A6314 800F1714 3C06E600 */  lui        $a2, (0xE6000000 >> 16)
    /* 8A6318 800F1718 AC470020 */  sw         $a3, 0x20($v0)
    /* 8A631C 800F171C AEA30000 */  sw         $v1, 0x0($s5)
    /* 8A6320 800F1720 24430038 */  addiu      $v1, $v0, 0x38
    /* 8A6324 800F1724 AC460028 */  sw         $a2, 0x28($v0)
    /* 8A6328 800F1728 AC40002C */  sw         $zero, 0x2C($v0)
    /* 8A632C 800F172C AEA30000 */  sw         $v1, 0x0($s5)
    /* 8A6330 800F1730 3C03F000 */  lui        $v1, (0xF0000000 >> 16)
    /* 8A6334 800F1734 AC430030 */  sw         $v1, 0x30($v0)
    /* 8A6338 800F1738 24430040 */  addiu      $v1, $v0, 0x40
    /* 8A633C 800F173C 3C05E700 */  lui        $a1, (0xE7000000 >> 16)
    /* 8A6340 800F1740 AC480034 */  sw         $t0, 0x34($v0)
    /* 8A6344 800F1744 AEA30000 */  sw         $v1, 0x0($s5)
    /* 8A6348 800F1748 24430048 */  addiu      $v1, $v0, 0x48
    /* 8A634C 800F174C AC450038 */  sw         $a1, 0x38($v0)
    /* 8A6350 800F1750 AC40003C */  sw         $zero, 0x3C($v0)
    /* 8A6354 800F1754 AEA30000 */  sw         $v1, 0x0($s5)
    /* 8A6358 800F1758 3C03FD50 */  lui        $v1, (0xFD500000 >> 16)
    /* 8A635C 800F175C 000422C0 */  sll        $a0, $a0, 11
    /* 8A6360 800F1760 24840308 */  addiu      $a0, $a0, 0x308
    /* 8A6364 800F1764 02842021 */  addu       $a0, $s4, $a0
    /* 8A6368 800F1768 AC430040 */  sw         $v1, 0x40($v0)
    /* 8A636C 800F176C 24430050 */  addiu      $v1, $v0, 0x50
    /* 8A6370 800F1770 AC440044 */  sw         $a0, 0x44($v0)
    /* 8A6374 800F1774 AEA30000 */  sw         $v1, 0x0($s5)
    /* 8A6378 800F1778 3C03F550 */  lui        $v1, (0xF5500000 >> 16)
    /* 8A637C 800F177C AC430048 */  sw         $v1, 0x48($v0)
    /* 8A6380 800F1780 24430058 */  addiu      $v1, $v0, 0x58
    /* 8A6384 800F1784 AC49004C */  sw         $t1, 0x4C($v0)
    /* 8A6388 800F1788 AEA30000 */  sw         $v1, 0x0($s5)
    /* 8A638C 800F178C 24430060 */  addiu      $v1, $v0, 0x60
    /* 8A6390 800F1790 AC460050 */  sw         $a2, 0x50($v0)
    /* 8A6394 800F1794 AC400054 */  sw         $zero, 0x54($v0)
    /* 8A6398 800F1798 AEA30000 */  sw         $v1, 0x0($s5)
    /* 8A639C 800F179C 3C03F300 */  lui        $v1, (0xF3000000 >> 16)
    /* 8A63A0 800F17A0 AC430058 */  sw         $v1, 0x58($v0)
    /* 8A63A4 800F17A4 24430068 */  addiu      $v1, $v0, 0x68
    /* 8A63A8 800F17A8 AC4A005C */  sw         $t2, 0x5C($v0)
    /* 8A63AC 800F17AC AEA30000 */  sw         $v1, 0x0($s5)
    /* 8A63B0 800F17B0 24430070 */  addiu      $v1, $v0, 0x70
    /* 8A63B4 800F17B4 AC450060 */  sw         $a1, 0x60($v0)
    /* 8A63B8 800F17B8 AC400064 */  sw         $zero, 0x64($v0)
    /* 8A63BC 800F17BC AEA30000 */  sw         $v1, 0x0($s5)
    /* 8A63C0 800F17C0 24430078 */  addiu      $v1, $v0, 0x78
    /* 8A63C4 800F17C4 AC4C0068 */  sw         $t4, 0x68($v0)
    /* 8A63C8 800F17C8 AC4B006C */  sw         $t3, 0x6C($v0)
    /* 8A63CC 800F17CC AEA30000 */  sw         $v1, 0x0($s5)
    /* 8A63D0 800F17D0 3C03F200 */  lui        $v1, (0xF2000000 >> 16)
    /* 8A63D4 800F17D4 AC430070 */  sw         $v1, 0x70($v0)
    /* 8A63D8 800F17D8 AC4D0074 */  sw         $t5, 0x74($v0)
    /* 8A63DC 800F17DC 8E820004 */  lw         $v0, 0x4($s4)
    /* 8A63E0 800F17E0 10400021 */  beqz       $v0, .L800F1868
    /* 8A63E4 800F17E4 240200F0 */   addiu     $v0, $zero, 0xF0
    /* 8A63E8 800F17E8 AFA20010 */  sw         $v0, 0x10($sp)
    /* 8A63EC 800F17EC AFA00014 */  sw         $zero, 0x14($sp)
    /* 8A63F0 800F17F0 C680000C */  lwc1       $fv0, 0xC($s4)
    # RECOMP ASPECT MOD:
    lwc1       $fv1, 0x40($sp)
    /* 8A63FC 800F17FC 46020002 */  mul.s      $fv0, $fv0, $fv1
    /* 8A6400 800F1800 02A02021 */  addu       $a0, $s5, $zero
    /* 8A6404 800F1804 4600008D */  trunc.w.s  $fv1, $fv0
    /* 8A6408 800F1808 44021000 */  mfc1       $v0, $fv1
    /* 8A640C 800F180C 00021400 */  sll        $v0, $v0, 16
    /* 8A6410 800F1810 00021403 */  sra        $v0, $v0, 16
    /* 8A6414 800F1814 AFA20018 */  sw         $v0, 0x18($sp)
    /* 8A6418 800F1818 C680000C */  lwc1       $fv0, 0xC($s4)
    /* 8A641C 800F181C 3C01800A */  lui        $at, %hi(D_8009E990)
    /* 8A6420 800F1820 C422E990 */  lwc1       $fv1, %lo(D_8009E990)($at)
    # RECOMP ASPECT MOD:
    lw         $a1, 0x44($sp)
    /* 8A6428 800F1828 00003021 */  addu       $a2, $zero, $zero
    /* 8A642C 800F182C 46020002 */  mul.s      $fv0, $fv0, $fv1
    lw         $a3, 0x48($sp)
    /* 8A6434 800F1834 3C028000 */  lui        $v0, (0x80000000 >> 16)
    /* 8A6438 800F1838 AFA20020 */  sw         $v0, 0x20($sp)
    /* 8A643C 800F183C AFA20024 */  sw         $v0, 0x24($sp)
    /* 8A6440 800F1840 AFA20028 */  sw         $v0, 0x28($sp)
    /* 8A6444 800F1844 AFA2002C */  sw         $v0, 0x2C($sp)
    /* 8A6448 800F1848 4600008D */  trunc.w.s  $fv1, $fv0
    /* 8A644C 800F184C 44021000 */  mfc1       $v0, $fv1
    /* 8A6450 800F1850 00021400 */  sll        $v0, $v0, 16
    /* 8A6454 800F1854 00021403 */  sra        $v0, $v0, 16
    /* 8A6458 800F1858 0C017216 */  jal        func_8005C858
    /* 8A645C 800F185C AFA2001C */   sw        $v0, 0x1C($sp)
    /* 8A6460 800F1860 0803C6AB */  j          .L800F1AAC
    /* 8A6464 800F1864 00000000 */   nop
  .L800F1868:
    /* 8A6468 800F1868 24120078 */  addiu      $s2, $zero, 0x78
    /* 8A646C 800F186C AFB20010 */  sw         $s2, 0x10($sp)
    /* 8A6470 800F1870 AFA00014 */  sw         $zero, 0x14($sp)
    /* 8A6474 800F1874 AFA00018 */  sw         $zero, 0x18($sp)
    /* 8A6478 800F1878 AFA0001C */  sw         $zero, 0x1C($sp)
    /* 8A647C 800F187C C680000C */  lwc1       $fv0, 0xC($s4)
    # RECOMP ASPECT MOD:
    lwc1       $fs1, 0x40($sp)
    /* 8A6488 800F1888 02A02021 */  addu       $a0, $s5, $zero
    lw         $a1, 0x44($sp)            # dynamic left
    /* 8A6490 800F1890 00003021 */  addu       $a2, $zero, $zero
    /* 8A6494 800F1894 46160002 */  mul.s      $fv0, $fv0, $fs1
    lw         $a3, 0x4C($sp)            # dynamic half width
    /* 8A649C 800F189C 3C01800A */  lui        $at, %hi(D_8009E998)
    /* 8A64A0 800F18A0 C434E998 */  lwc1       $fs0, %lo(D_8009E998)($at)
    /* 8A64A4 800F18A4 00178200 */  sll        $s0, $s7, 8
    /* 8A64A8 800F18A8 02D08025 */  or         $s0, $s6, $s0
    /* 8A64AC 800F18AC 3C118000 */  lui        $s1, (0x80000000 >> 16)
    /* 8A64B0 800F18B0 24130001 */  addiu      $s3, $zero, 0x1
    /* 8A64B4 800F18B4 4600008D */  trunc.w.s  $fv1, $fv0
    /* 8A64B8 800F18B8 44021000 */  mfc1       $v0, $fv1
    /* 8A64BC 800F18BC 00021140 */  sll        $v0, $v0, 5
    /* 8A64C0 800F18C0 00021043 */  sra        $v0, $v0, 1
    /* 8A64C4 800F18C4 AFA20020 */  sw         $v0, 0x20($sp)
    /* 8A64C8 800F18C8 C680000C */  lwc1       $fv0, 0xC($s4)
    /* 8A64CC 800F18CC 001E1400 */  sll        $v0, $fp, 16
    /* 8A64D0 800F18D0 02028025 */  or         $s0, $s0, $v0
    /* 8A64D4 800F18D4 3C02FF00 */  lui        $v0, (0xFF000000 >> 16)
    /* 8A64D8 800F18D8 46140002 */  mul.s      $fv0, $fv0, $fs0
    /* 8A64DC 800F18DC 02028025 */  or         $s0, $s0, $v0
    /* 8A64E0 800F18E0 AFB00028 */  sw         $s0, 0x28($sp)
    /* 8A64E4 800F18E4 AFB0002C */  sw         $s0, 0x2C($sp)
    /* 8A64E8 800F18E8 AFB10030 */  sw         $s1, 0x30($sp)
    /* 8A64EC 800F18EC AFB00034 */  sw         $s0, 0x34($sp)
    /* 8A64F0 800F18F0 AFB30038 */  sw         $s3, 0x38($sp)
    /* 8A64F4 800F18F4 4600008D */  trunc.w.s  $fv1, $fv0
    /* 8A64F8 800F18F8 44021000 */  mfc1       $v0, $fv1
    /* 8A64FC 800F18FC 00021140 */  sll        $v0, $v0, 5
    /* 8A6500 800F1900 00021043 */  sra        $v0, $v0, 1
    /* 8A6504 800F1904 0C01735A */  jal        func_8005CD68
    /* 8A6508 800F1908 AFA20024 */   sw        $v0, 0x24($sp)
    /* 8A650C 800F190C AFB20010 */  sw         $s2, 0x10($sp)
    /* 8A6510 800F1910 AFA00014 */  sw         $zero, 0x14($sp)
    /* 8A6514 800F1914 C680000C */  lwc1       $fv0, 0xC($s4)
    /* 8A6518 800F1918 46160002 */  mul.s      $fv0, $fv0, $fs1
    /* 8A651C 800F191C AFA0001C */  sw         $zero, 0x1C($sp)
    /* 8A6520 800F1920 4600008D */  trunc.w.s  $fv1, $fv0
    /* 8A6524 800F1924 44021000 */  mfc1       $v0, $fv1
    /* 8A6528 800F1928 00021140 */  sll        $v0, $v0, 5
    /* 8A652C 800F192C 00021043 */  sra        $v0, $v0, 1
    /* 8A6530 800F1930 AFA20018 */  sw         $v0, 0x18($sp)
    /* 8A6534 800F1934 C680000C */  lwc1       $fv0, 0xC($s4)
    /* 8A6538 800F1938 46160002 */  mul.s      $fv0, $fv0, $fs1
    /* 8A653C 800F193C 02A02021 */  addu       $a0, $s5, $zero
    /* 8A6540 800F1940 4600008D */  trunc.w.s  $fv1, $fv0
    /* 8A6544 800F1944 44021000 */  mfc1       $v0, $fv1
    /* 8A6548 800F1948 00021140 */  sll        $v0, $v0, 5
    /* 8A654C 800F194C AFA20020 */  sw         $v0, 0x20($sp)
    /* 8A6550 800F1950 C680000C */  lwc1       $fv0, 0xC($s4)
    /* 8A6554 800F1954 240500A0 */  addiu      $a1, $zero, 0xA0
    /* 8A6558 800F1958 00003021 */  addu       $a2, $zero, $zero
    /* 8A655C 800F195C 46140002 */  mul.s      $fv0, $fv0, $fs0
    lw         $a3, 0x4C($sp)            # RECOMP ASPECT MOD: half width
    /* 8A6564 800F1964 AFB00028 */  sw         $s0, 0x28($sp)
    /* 8A6568 800F1968 AFB0002C */  sw         $s0, 0x2C($sp)
    /* 8A656C 800F196C AFB00030 */  sw         $s0, 0x30($sp)
    /* 8A6570 800F1970 AFB10034 */  sw         $s1, 0x34($sp)
    /* 8A6574 800F1974 AFA00038 */  sw         $zero, 0x38($sp)
    /* 8A6578 800F1978 4600008D */  trunc.w.s  $fv1, $fv0
    /* 8A657C 800F197C 44021000 */  mfc1       $v0, $fv1
    /* 8A6580 800F1980 00021140 */  sll        $v0, $v0, 5
    /* 8A6584 800F1984 00021043 */  sra        $v0, $v0, 1
    /* 8A6588 800F1988 0C01735A */  jal        func_8005CD68
    /* 8A658C 800F198C AFA20024 */   sw        $v0, 0x24($sp)
    /* 8A6590 800F1990 AFB20010 */  sw         $s2, 0x10($sp)
    /* 8A6594 800F1994 AFA00014 */  sw         $zero, 0x14($sp)
    /* 8A6598 800F1998 AFA00018 */  sw         $zero, 0x18($sp)
    /* 8A659C 800F199C C680000C */  lwc1       $fv0, 0xC($s4)
    /* 8A65A0 800F19A0 46140002 */  mul.s      $fv0, $fv0, $fs0
    /* 8A65A4 800F19A4 4600008D */  trunc.w.s  $fv1, $fv0
    /* 8A65A8 800F19A8 44021000 */  mfc1       $v0, $fv1
    /* 8A65AC 800F19AC 00021140 */  sll        $v0, $v0, 5
    /* 8A65B0 800F19B0 00021043 */  sra        $v0, $v0, 1
    /* 8A65B4 800F19B4 AFA2001C */  sw         $v0, 0x1C($sp)
    /* 8A65B8 800F19B8 C680000C */  lwc1       $fv0, 0xC($s4)
    /* 8A65BC 800F19BC 46160002 */  mul.s      $fv0, $fv0, $fs1
    /* 8A65C0 800F19C0 02A02021 */  addu       $a0, $s5, $zero
    /* 8A65C4 800F19C4 4600008D */  trunc.w.s  $fv1, $fv0
    /* 8A65C8 800F19C8 44021000 */  mfc1       $v0, $fv1
    /* 8A65CC 800F19CC 00021140 */  sll        $v0, $v0, 5
    /* 8A65D0 800F19D0 00021043 */  sra        $v0, $v0, 1
    /* 8A65D4 800F19D4 AFA20020 */  sw         $v0, 0x20($sp)
    /* 8A65D8 800F19D8 C680000C */  lwc1       $fv0, 0xC($s4)
    lw         $a1, 0x44($sp)            # RECOMP ASPECT MOD:
    /* 8A65E0 800F19E0 24060078 */  addiu      $a2, $zero, 0x78
    /* 8A65E4 800F19E4 46140002 */  mul.s      $fv0, $fv0, $fs0
    lw         $a3, 0x4C($sp)            # RECOMP ASPECT MOD:
    /* 8A65EC 800F19EC AFB00028 */  sw         $s0, 0x28($sp)
    /* 8A65F0 800F19F0 AFB1002C */  sw         $s1, 0x2C($sp)
    /* 8A65F4 800F19F4 AFB00030 */  sw         $s0, 0x30($sp)
    /* 8A65F8 800F19F8 AFB00034 */  sw         $s0, 0x34($sp)
    /* 8A65FC 800F19FC AFA00038 */  sw         $zero, 0x38($sp)
    /* 8A6600 800F1A00 4600008D */  trunc.w.s  $fv1, $fv0
    /* 8A6604 800F1A04 44021000 */  mfc1       $v0, $fv1
    /* 8A6608 800F1A08 00021140 */  sll        $v0, $v0, 5
    /* 8A660C 800F1A0C 0C01735A */  jal        func_8005CD68
    /* 8A6610 800F1A10 AFA20024 */   sw        $v0, 0x24($sp)
    /* 8A6614 800F1A14 AFB20010 */  sw         $s2, 0x10($sp)
    /* 8A6618 800F1A18 AFA00014 */  sw         $zero, 0x14($sp)
    /* 8A661C 800F1A1C C680000C */  lwc1       $fv0, 0xC($s4)
    /* 8A6620 800F1A20 46160002 */  mul.s      $fv0, $fv0, $fs1
    /* 8A6624 800F1A24 4600008D */  trunc.w.s  $fv1, $fv0
    /* 8A6628 800F1A28 44021000 */  mfc1       $v0, $fv1
    /* 8A662C 800F1A2C 00021140 */  sll        $v0, $v0, 5
    /* 8A6630 800F1A30 00021043 */  sra        $v0, $v0, 1
    /* 8A6634 800F1A34 AFA20018 */  sw         $v0, 0x18($sp)
    /* 8A6638 800F1A38 C680000C */  lwc1       $fv0, 0xC($s4)
    /* 8A663C 800F1A3C 46140002 */  mul.s      $fv0, $fv0, $fs0
    /* 8A6640 800F1A40 4600008D */  trunc.w.s  $fv1, $fv0
    /* 8A6644 800F1A44 44021000 */  mfc1       $v0, $fv1
    /* 8A6648 800F1A48 00021140 */  sll        $v0, $v0, 5
    /* 8A664C 800F1A4C 00021043 */  sra        $v0, $v0, 1
    /* 8A6650 800F1A50 AFA2001C */  sw         $v0, 0x1C($sp)
    /* 8A6654 800F1A54 C680000C */  lwc1       $fv0, 0xC($s4)
    /* 8A6658 800F1A58 46160002 */  mul.s      $fv0, $fv0, $fs1
    /* 8A665C 800F1A5C 02A02021 */  addu       $a0, $s5, $zero
    /* 8A6660 800F1A60 4600008D */  trunc.w.s  $fv1, $fv0
    /* 8A6664 800F1A64 44021000 */  mfc1       $v0, $fv1
    /* 8A6668 800F1A68 00021140 */  sll        $v0, $v0, 5
    /* 8A666C 800F1A6C AFA20020 */  sw         $v0, 0x20($sp)
    /* 8A6670 800F1A70 C680000C */  lwc1       $fv0, 0xC($s4)
    /* 8A6674 800F1A74 240500A0 */  addiu      $a1, $zero, 0xA0
    /* 8A6678 800F1A78 24060078 */  addiu      $a2, $zero, 0x78
    /* 8A667C 800F1A7C 46140002 */  mul.s      $fv0, $fv0, $fs0
    lw         $a3, 0x4C($sp)            # RECOMP ASPECT MOD:
    /* 8A6684 800F1A84 AFB10028 */  sw         $s1, 0x28($sp)
    /* 8A6688 800F1A88 AFB0002C */  sw         $s0, 0x2C($sp)
    /* 8A668C 800F1A8C AFB00030 */  sw         $s0, 0x30($sp)
    /* 8A6690 800F1A90 AFB00034 */  sw         $s0, 0x34($sp)
    /* 8A6694 800F1A94 AFB30038 */  sw         $s3, 0x38($sp)
    /* 8A6698 800F1A98 4600008D */  trunc.w.s  $fv1, $fv0
    /* 8A669C 800F1A9C 44021000 */  mfc1       $v0, $fv1
    /* 8A66A0 800F1AA0 00021140 */  sll        $v0, $v0, 5
    /* 8A66A4 800F1AA4 0C01735A */  jal        func_8005CD68
    /* 8A66A8 800F1AA8 AFA20024 */   sw        $v0, 0x24($sp)
  .L800F1AAC:
    /* 8A66AC 800F1AAC 3C048017 */  lui        $a0, %hi(gMasterDisp)
    /* 8A66B0 800F1AB0 248489EC */  addiu      $a0, $a0, %lo(gMasterDisp)
    /* 8A66B4 800F1AB4 0C01744B */  jal        func_8005D12C
    /* 8A66B8 800F1AB8 00000000 */   nop
    /* 8A66BC 800F1ABC 8FBF00A4 */  lw         $ra, 0xA4($sp)
    /* 8A66C0 800F1AC0 8FBE00A0 */  lw         $fp, 0xA0($sp)
    /* 8A66C4 800F1AC4 8FB7009C */  lw         $s7, 0x9C($sp)
    /* 8A66C8 800F1AC8 8FB60098 */  lw         $s6, 0x98($sp)
    /* 8A66CC 800F1ACC 8FB50094 */  lw         $s5, 0x94($sp)
    /* 8A66D0 800F1AD0 8FB40090 */  lw         $s4, 0x90($sp)
    /* 8A66D4 800F1AD4 8FB3008C */  lw         $s3, 0x8C($sp)
    /* 8A66D8 800F1AD8 8FB20088 */  lw         $s2, 0x88($sp)
    /* 8A66DC 800F1ADC 8FB10084 */  lw         $s1, 0x84($sp)
    /* 8A66E0 800F1AE0 8FB00080 */  lw         $s0, 0x80($sp)
    /* 8A66E4 800F1AE4 D7B600B0 */  ldc1       $fs1, 0xB0($sp)
    /* 8A66E8 800F1AE8 D7B400A8 */  ldc1       $fs0, 0xA8($sp)
    /* 8A66EC 800F1AEC 27BD00B8 */  addiu      $sp, $sp, 0xB8
    /* 8A66F0 800F1AF0 03E00008 */  jr         $ra
    /* 8A66F4 800F1AF4 00000000 */   nop
.size func_800F14F0, . - func_800F14F0

glabel func_800F1AF8
    /* 8A66F8 800F1AF8 27BDFFB0 */  addiu      $sp, $sp, -0x50
    /* 8A66FC 800F1AFC AFB50044 */  sw         $s5, 0x44($sp)
    /* 8A6700 800F1B00 0080A821 */  addu       $s5, $a0, $zero
    /* 8A6704 800F1B04 3C048018 */  lui        $a0, %hi(D_8017ABF8)
    /* 8A6708 800F1B08 9484ABF8 */  lhu        $a0, %lo(D_8017ABF8)($a0)
    /* 8A670C 800F1B0C AFBF0048 */  sw         $ra, 0x48($sp)
    /* 8A6710 800F1B10 AFB40040 */  sw         $s4, 0x40($sp)
    /* 8A6714 800F1B14 AFB3003C */  sw         $s3, 0x3C($sp)
    /* 8A6718 800F1B18 AFB20038 */  sw         $s2, 0x38($sp)
    /* 8A671C 800F1B1C AFB10034 */  sw         $s1, 0x34($sp)
    /* 8A6720 800F1B20 0C018577 */  jal        func_800615DC
    /* 8A6724 800F1B24 AFB00030 */   sw        $s0, 0x30($sp)
    /* 8A6728 800F1B28 94440002 */  lhu        $a0, 0x2($v0)
    /* 8A672C 800F1B2C 10800086 */  beqz       $a0, .L800F1D48
    /* 8A6730 800F1B30 00000000 */   nop
    /* 8A6734 800F1B34 0C018577 */  jal        func_800615DC
    /* 8A6738 800F1B38 3C14BA00 */   lui       $s4, (0xBA000E02 >> 16)
    /* 8A673C 800F1B3C 36940E02 */  ori        $s4, $s4, (0xBA000E02 & 0xFFFF)
    /* 8A6740 800F1B40 3C050103 */  lui        $a1, (0x1030040 >> 16)
    /* 8A6744 800F1B44 3C118017 */  lui        $s1, %hi(gMasterDisp)
    /* 8A6748 800F1B48 263189EC */  addiu      $s1, $s1, %lo(gMasterDisp)
    /* 8A674C 800F1B4C 8E300000 */  lw         $s0, 0x0($s1)
    /* 8A6750 800F1B50 34A50040 */  ori        $a1, $a1, (0x1030040 & 0xFFFF)
    /* 8A6754 800F1B54 3C048017 */  lui        $a0, %hi(D_8016A138)
    /* 8A6758 800F1B58 2484A138 */  addiu      $a0, $a0, %lo(D_8016A138)
    /* 8A675C 800F1B5C 3C12E700 */  lui        $s2, (0xE7000000 >> 16)
    /* 8A6760 800F1B60 00409821 */  addu       $s3, $v0, $zero
    /* 8A6764 800F1B64 26030008 */  addiu      $v1, $s0, 0x8
    /* 8A6768 800F1B68 AE230000 */  sw         $v1, 0x0($s1)
    /* 8A676C 800F1B6C 26030010 */  addiu      $v1, $s0, 0x10
    /* 8A6770 800F1B70 AE120000 */  sw         $s2, 0x0($s0)
    /* 8A6774 800F1B74 AE000004 */  sw         $zero, 0x4($s0)
    /* 8A6778 800F1B78 AE230000 */  sw         $v1, 0x0($s1)
    /* 8A677C 800F1B7C 26030018 */  addiu      $v1, $s0, 0x18
    /* 8A6780 800F1B80 AE140008 */  sw         $s4, 0x8($s0)
    /* 8A6784 800F1B84 AE00000C */  sw         $zero, 0xC($s0)
    /* 8A6788 800F1B88 AE230000 */  sw         $v1, 0x0($s1)
    /* 8A678C 800F1B8C 0C01FFB4 */  jal        osVirtualToPhysical_recomp
    /* 8A6790 800F1B90 AE050010 */   sw        $a1, 0x10($s0)
    /* 8A6794 800F1B94 3C030102 */  lui        $v1, (0x1020040 >> 16)
    /* 8A6798 800F1B98 AE020014 */  sw         $v0, 0x14($s0)
    /* 8A679C 800F1B9C 8E300000 */  lw         $s0, 0x0($s1)
    /* 8A67A0 800F1BA0 34630040 */  ori        $v1, $v1, (0x1020040 & 0xFFFF)
    /* 8A67A4 800F1BA4 3C048016 */  lui        $a0, %hi(D_801630E8)
    /* 8A67A8 800F1BA8 248430E8 */  addiu      $a0, $a0, %lo(D_801630E8)
    /* 8A67AC 800F1BAC 26020008 */  addiu      $v0, $s0, 0x8
    /* 8A67B0 800F1BB0 AE220000 */  sw         $v0, 0x0($s1)
    /* 8A67B4 800F1BB4 0C01FFB4 */  jal        osVirtualToPhysical_recomp
    /* 8A67B8 800F1BB8 AE030000 */   sw        $v1, 0x0($s0)
    /* 8A67BC 800F1BBC 3C06BC00 */  lui        $a2, (0xBC00000E >> 16)
    /* 8A67C0 800F1BC0 34C6000E */  ori        $a2, $a2, (0xBC00000E & 0xFFFF)
    /* 8A67C4 800F1BC4 3C09B900 */  lui        $t1, (0xB900031D >> 16)
    /* 8A67C8 800F1BC8 3529031D */  ori        $t1, $t1, (0xB900031D & 0xFFFF)
    /* 8A67CC 800F1BCC 3C070050 */  lui        $a3, (0x504240 >> 16)
    /* 8A67D0 800F1BD0 34E74240 */  ori        $a3, $a3, (0x504240 & 0xFFFF)
    /* 8A67D4 800F1BD4 3C0AFCFF */  lui        $t2, (0xFCFF97FF >> 16)
    /* 8A67D8 800F1BD8 354A97FF */  ori        $t2, $t2, (0xFCFF97FF & 0xFFFF)
    /* 8A67DC 800F1BDC 3C08FF2C */  lui        $t0, (0xFF2CFE7F >> 16)
    /* 8A67E0 800F1BE0 3508FE7F */  ori        $t0, $t0, (0xFF2CFE7F & 0xFFFF)
    /* 8A67E4 800F1BE4 3C0B0708 */  lui        $t3, (0x7080200 >> 16)
    /* 8A67E8 800F1BE8 356B0200 */  ori        $t3, $t3, (0x7080200 & 0xFFFF)
    /* 8A67EC 800F1BEC 3C0C077F */  lui        $t4, (0x77FF080 >> 16)
    /* 8A67F0 800F1BF0 358CF080 */  ori        $t4, $t4, (0x77FF080 & 0xFFFF)
    /* 8A67F4 800F1BF4 3C0EF510 */  lui        $t6, (0xF5102000 >> 16)
    /* 8A67F8 800F1BF8 35CE2000 */  ori        $t6, $t6, (0xF5102000 & 0xFFFF)
    /* 8A67FC 800F1BFC 3C0D0008 */  lui        $t5, (0x80200 >> 16)
    /* 8A6800 800F1C00 35AD0200 */  ori        $t5, $t5, (0x80200 & 0xFFFF)
    /* 8A6804 800F1C04 3C0F000F */  lui        $t7, (0xFC07C >> 16)
    /* 8A6808 800F1C08 35EFC07C */  ori        $t7, $t7, (0xFC07C & 0xFFFF)
    /* 8A680C 800F1C0C AE020004 */  sw         $v0, 0x4($s0)
    /* 8A6810 800F1C10 8E220000 */  lw         $v0, 0x0($s1)
    /* 8A6814 800F1C14 3C058017 */  lui        $a1, %hi(D_80175FD0)
    /* 8A6818 800F1C18 94A55FD0 */  lhu        $a1, %lo(D_80175FD0)($a1)
    /* 8A681C 800F1C1C 02202021 */  addu       $a0, $s1, $zero
    /* 8A6820 800F1C20 24430008 */  addiu      $v1, $v0, 0x8
    /* 8A6824 800F1C24 AE230000 */  sw         $v1, 0x0($s1)
    /* 8A6828 800F1C28 24430010 */  addiu      $v1, $v0, 0x10
    /* 8A682C 800F1C2C AC460000 */  sw         $a2, 0x0($v0)
    /* 8A6830 800F1C30 AC450004 */  sw         $a1, 0x4($v0)
    /* 8A6834 800F1C34 AE230000 */  sw         $v1, 0x0($s1)
    /* 8A6838 800F1C38 24430018 */  addiu      $v1, $v0, 0x18
    /* 8A683C 800F1C3C AC490008 */  sw         $t1, 0x8($v0)
    /* 8A6840 800F1C40 AC47000C */  sw         $a3, 0xC($v0)
    /* 8A6844 800F1C44 AE230000 */  sw         $v1, 0x0($s1)
    /* 8A6848 800F1C48 24430020 */  addiu      $v1, $v0, 0x20
    /* 8A684C 800F1C4C AC4A0010 */  sw         $t2, 0x10($v0)
    /* 8A6850 800F1C50 AC480014 */  sw         $t0, 0x14($v0)
    /* 8A6854 800F1C54 AE230000 */  sw         $v1, 0x0($s1)
    /* 8A6858 800F1C58 3C03FA00 */  lui        $v1, (0xFA000000 >> 16)
    /* 8A685C 800F1C5C AC430018 */  sw         $v1, 0x18($v0)
    /* 8A6860 800F1C60 32A300FF */  andi       $v1, $s5, 0xFF
    /* 8A6864 800F1C64 AC43001C */  sw         $v1, 0x1C($v0)
    /* 8A6868 800F1C68 24430028 */  addiu      $v1, $v0, 0x28
    /* 8A686C 800F1C6C AE230000 */  sw         $v1, 0x0($s1)
    /* 8A6870 800F1C70 3C03FD10 */  lui        $v1, (0xFD100000 >> 16)
    /* 8A6874 800F1C74 AC430020 */  sw         $v1, 0x20($v0)
    /* 8A6878 800F1C78 24430030 */  addiu      $v1, $v0, 0x30
    /* 8A687C 800F1C7C AC530024 */  sw         $s3, 0x24($v0)
    /* 8A6880 800F1C80 AE230000 */  sw         $v1, 0x0($s1)
    /* 8A6884 800F1C84 3C03F510 */  lui        $v1, (0xF5100000 >> 16)
    /* 8A6888 800F1C88 AC430028 */  sw         $v1, 0x28($v0)
    /* 8A688C 800F1C8C 24430038 */  addiu      $v1, $v0, 0x38
    /* 8A6890 800F1C90 AC4B002C */  sw         $t3, 0x2C($v0)
    /* 8A6894 800F1C94 AE230000 */  sw         $v1, 0x0($s1)
    /* 8A6898 800F1C98 3C03E600 */  lui        $v1, (0xE6000000 >> 16)
    /* 8A689C 800F1C9C AC430030 */  sw         $v1, 0x30($v0)
    /* 8A68A0 800F1CA0 24430040 */  addiu      $v1, $v0, 0x40
    /* 8A68A4 800F1CA4 AC400034 */  sw         $zero, 0x34($v0)
    /* 8A68A8 800F1CA8 AE230000 */  sw         $v1, 0x0($s1)
    /* 8A68AC 800F1CAC 3C03F300 */  lui        $v1, (0xF3000000 >> 16)
    /* 8A68B0 800F1CB0 AC430038 */  sw         $v1, 0x38($v0)
    /* 8A68B4 800F1CB4 24430048 */  addiu      $v1, $v0, 0x48
    /* 8A68B8 800F1CB8 AC4C003C */  sw         $t4, 0x3C($v0)
    /* 8A68BC 800F1CBC AE230000 */  sw         $v1, 0x0($s1)
    /* 8A68C0 800F1CC0 24430050 */  addiu      $v1, $v0, 0x50
    /* 8A68C4 800F1CC4 AC520040 */  sw         $s2, 0x40($v0)
    /* 8A68C8 800F1CC8 AC400044 */  sw         $zero, 0x44($v0)
    /* 8A68CC 800F1CCC AE230000 */  sw         $v1, 0x0($s1)
    /* 8A68D0 800F1CD0 24430058 */  addiu      $v1, $v0, 0x58
    /* 8A68D4 800F1CD4 AC4E0048 */  sw         $t6, 0x48($v0)
    /* 8A68D8 800F1CD8 AC4D004C */  sw         $t5, 0x4C($v0)
    /* 8A68DC 800F1CDC AE230000 */  sw         $v1, 0x0($s1)
    /* 8A68E0 800F1CE0 3C03F200 */  lui        $v1, (0xF2000000 >> 16)
    /* 8A68E4 800F1CE4 AC430050 */  sw         $v1, 0x50($v0)
    /* 8A68E8 800F1CE8 AC4F0054 */  sw         $t7, 0x54($v0)

    # RECOMP ASPECT MOD:
    jal        bike_select_get_aspect_metrics
     nop
    addiu      $t9, $zero, 0xA0
    subu       $a1, $t9, $v0
    sll        $a3, $v0, 1

    addiu      $v0, $zero, 0xF0
    sw         $v0, 0x10($sp)
    sw         $v1, 0x18($sp)
    addiu      $v0, $zero, 0x20
    addu       $a0, $s1, $zero
    addu       $a2, $zero, $zero
    sw         $zero, 0x14($sp)
    sw         $v0, 0x1C($sp)
    sw         $zero, 0x20($sp)
    sw         $zero, 0x24($sp)
    sw         $zero, 0x28($sp)
    /* 8A6920 800F1D20 0C017216 */  jal        func_8005C858
    /* 8A6924 800F1D24 AFA0002C */   sw        $zero, 0x2C($sp)
    /* 8A6928 800F1D28 0C01744B */  jal        func_8005D12C
    /* 8A692C 800F1D2C 02202021 */   addu      $a0, $s1, $zero
    /* 8A6930 800F1D30 8E230000 */  lw         $v1, 0x0($s1)
    /* 8A6934 800F1D34 24620008 */  addiu      $v0, $v1, 0x8
    /* 8A6938 800F1D38 AE220000 */  sw         $v0, 0x0($s1)
    /* 8A693C 800F1D3C 34028000 */  ori        $v0, $zero, 0x8000
    /* 8A6940 800F1D40 AC740000 */  sw         $s4, 0x0($v1)
    /* 8A6944 800F1D44 AC620004 */  sw         $v0, 0x4($v1)
  .L800F1D48:
    /* 8A6948 800F1D48 8FBF0048 */  lw         $ra, 0x48($sp)
    /* 8A694C 800F1D4C 8FB50044 */  lw         $s5, 0x44($sp)
    /* 8A6950 800F1D50 8FB40040 */  lw         $s4, 0x40($sp)
    /* 8A6954 800F1D54 8FB3003C */  lw         $s3, 0x3C($sp)
    /* 8A6958 800F1D58 8FB20038 */  lw         $s2, 0x38($sp)
    /* 8A695C 800F1D5C 8FB10034 */  lw         $s1, 0x34($sp)
    /* 8A6960 800F1D60 8FB00030 */  lw         $s0, 0x30($sp)
    /* 8A6964 800F1D64 27BD0050 */  addiu      $sp, $sp, 0x50
    /* 8A6968 800F1D68 03E00008 */  jr         $ra
    /* 8A696C 800F1D6C 00000000 */   nop
.size func_800F1AF8, . - func_800F1AF8

glabel func_800F1DE0
    /* 8A69E0 800F1DE0 27BDFFB8 */  addiu      $sp, $sp, -0x48
    /* 8A69E4 800F1DE4 3C030103 */  lui        $v1, (0x1030040 >> 16)
    /* 8A69E8 800F1DE8 34630040 */  ori        $v1, $v1, (0x1030040 & 0xFFFF)
    /* 8A69EC 800F1DEC 3C048017 */  lui        $a0, %hi(D_8016A138)
    /* 8A69F0 800F1DF0 2484A138 */  addiu      $a0, $a0, %lo(D_8016A138)
    /* 8A69F4 800F1DF4 AFB10034 */  sw         $s1, 0x34($sp)
    /* 8A69F8 800F1DF8 3C118017 */  lui        $s1, %hi(gMasterDisp)
    /* 8A69FC 800F1DFC 263189EC */  addiu      $s1, $s1, %lo(gMasterDisp)
    /* 8A6A00 800F1E00 AFBF0040 */  sw         $ra, 0x40($sp)
    /* 8A6A04 800F1E04 AFB3003C */  sw         $s3, 0x3C($sp)
    /* 8A6A08 800F1E08 AFB20038 */  sw         $s2, 0x38($sp)
    /* 8A6A0C 800F1E0C AFB00030 */  sw         $s0, 0x30($sp)
    /* 8A6A10 800F1E10 8E300000 */  lw         $s0, 0x0($s1)
    /* 8A6A14 800F1E14 3C1200FF */  lui        $s2, (0xFFFFFF >> 16)
    /* 8A6A18 800F1E18 3652FFFF */  ori        $s2, $s2, (0xFFFFFF & 0xFFFF)
    /* 8A6A1C 800F1E1C 26020008 */  addiu      $v0, $s0, 0x8
    /* 8A6A20 800F1E20 AE220000 */  sw         $v0, 0x0($s1)
    /* 8A6A24 800F1E24 3C02E700 */  lui        $v0, (0xE7000000 >> 16)
    /* 8A6A28 800F1E28 AE020000 */  sw         $v0, 0x0($s0)
    /* 8A6A2C 800F1E2C 26020010 */  addiu      $v0, $s0, 0x10
    /* 8A6A30 800F1E30 AE000004 */  sw         $zero, 0x4($s0)
    /* 8A6A34 800F1E34 AE220000 */  sw         $v0, 0x0($s1)
    /* 8A6A38 800F1E38 0C01FFB4 */  jal        osVirtualToPhysical_recomp
    /* 8A6A3C 800F1E3C AE030008 */   sw        $v1, 0x8($s0)
    /* 8A6A40 800F1E40 3C030102 */  lui        $v1, (0x1020040 >> 16)
    /* 8A6A44 800F1E44 AE02000C */  sw         $v0, 0xC($s0)
    /* 8A6A48 800F1E48 8E300000 */  lw         $s0, 0x0($s1)
    /* 8A6A4C 800F1E4C 34630040 */  ori        $v1, $v1, (0x1020040 & 0xFFFF)
    /* 8A6A50 800F1E50 3C048016 */  lui        $a0, %hi(D_801630E8)
    /* 8A6A54 800F1E54 248430E8 */  addiu      $a0, $a0, %lo(D_801630E8)
    /* 8A6A58 800F1E58 26020008 */  addiu      $v0, $s0, 0x8
    /* 8A6A5C 800F1E5C AE220000 */  sw         $v0, 0x0($s1)
    /* 8A6A60 800F1E60 0C01FFB4 */  jal        osVirtualToPhysical_recomp
    /* 8A6A64 800F1E64 AE030000 */   sw        $v1, 0x0($s0)
    /* 8A6A68 800F1E68 3C09BC00 */  lui        $t1, (0xBC00000E >> 16)
    /* 8A6A6C 800F1E6C 3529000E */  ori        $t1, $t1, (0xBC00000E & 0xFFFF)
    /* 8A6A70 800F1E70 3C0CB900 */  lui        $t4, (0xB900031D >> 16)
    /* 8A6A74 800F1E74 358C031D */  ori        $t4, $t4, (0xB900031D & 0xFFFF)
    /* 8A6A78 800F1E78 3C0A0050 */  lui        $t2, (0x504240 >> 16)
    /* 8A6A7C 800F1E7C 354A4240 */  ori        $t2, $t2, (0x504240 & 0xFFFF)
    /* 8A6A80 800F1E80 3C0DFCFF */  lui        $t5, (0xFCFFFFFF >> 16)
    /* 8A6A84 800F1E84 35ADFFFF */  ori        $t5, $t5, (0xFCFFFFFF & 0xFFFF)
    /* 8A6A88 800F1E88 3C0BFFFE */  lui        $t3, (0xFFFE793C >> 16)
    /* 8A6A8C 800F1E8C 356B793C */  ori        $t3, $t3, (0xFFFE793C & 0xFFFF)
    /* 8A6A9C 800F1E9C AE020004 */  sw         $v0, 0x4($s0)
    /* 8A6AA0 800F1EA0 8E220000 */  lw         $v0, 0x0($s1)
    /* 8A6AA4 800F1EA4 3C088017 */  lui        $t0, %hi(D_80175FD0)
    /* 8A6AA8 800F1EA8 95085FD0 */  lhu        $t0, %lo(D_80175FD0)($t0)
    /* 8A6AAC 800F1EAC 24070020 */  addiu      $a3, $zero, 0x20
    /* 8A6AB0 800F1EB0 241300F0 */  addiu      $s3, $zero, 0xF0
    /* 8A6AB4 800F1EB4 2410FFFF */  addiu      $s0, $zero, -0x1
    /* 8A6AB8 800F1EB8 24430008 */  addiu      $v1, $v0, 0x8
    /* 8A6ABC 800F1EBC AE230000 */  sw         $v1, 0x0($s1)
    /* 8A6AC0 800F1EC0 24430010 */  addiu      $v1, $v0, 0x10
    /* 8A6AC4 800F1EC4 AC490000 */  sw         $t1, 0x0($v0)
    /* 8A6AC8 800F1EC8 AC480004 */  sw         $t0, 0x4($v0)
    /* 8A6ACC 800F1ECC AE230000 */  sw         $v1, 0x0($s1)
    /* 8A6AD0 800F1ED0 24430018 */  addiu      $v1, $v0, 0x18
    /* 8A6AD4 800F1ED4 AC4C0008 */  sw         $t4, 0x8($v0)
    /* 8A6AD8 800F1ED8 AC4A000C */  sw         $t2, 0xC($v0)
    /* 8A6ADC 800F1EDC AE230000 */  sw         $v1, 0x0($s1)
    /* 8A6AE0 800F1EE0 AC4D0010 */  sw         $t5, 0x10($v0)
    /* 8A6AE4 800F1EE4 AC4B0014 */  sw         $t3, 0x14($v0)
    /* 8A6AE8 800F1EE8 AFB30010 */  sw         $s3, 0x10($sp)
    /* 8A6AEC 800F1EEC AFA00014 */  sw         $zero, 0x14($sp)
    /* 8A6AF0 800F1EF0 AFA00018 */  sw         $zero, 0x18($sp)
    /* 8A6AF4 800F1EF4 AFA0001C */  sw         $zero, 0x1C($sp)
    /* 8A6AF8 800F1EF8 AFB00020 */  sw         $s0, 0x20($sp)
    /* 8A6AFC 800F1EFC AFB20024 */  sw         $s2, 0x24($sp)
    /* 8A6B00 800F1F00 AFB20028 */  sw         $s2, 0x28($sp)

    # RECOMP ASPECT MOD:
    jal        bike_select_get_aspect_metrics
     nop
    addiu      $t9, $zero, 0xA0
    subu       $a1, $t9, $v0             # left
    addu       $a0, $s1, $zero
    addu       $a2, $zero, $zero
    addiu      $a3, $zero, 0x20
    /* 8A6B04 800F1F04 0C017216 */  jal        func_8005C858
    /* 8A6B08 800F1F08 AFB0002C */   sw        $s0, 0x2C($sp)
    /* 8A6B1C 800F1F1C AFB30010 */  sw         $s3, 0x10($sp)
    /* 8A6B20 800F1F20 AFA00014 */  sw         $zero, 0x14($sp)
    /* 8A6B24 800F1F24 AFA00018 */  sw         $zero, 0x18($sp)
    /* 8A6B28 800F1F28 AFA0001C */  sw         $zero, 0x1C($sp)
    /* 8A6B2C 800F1F2C AFB20020 */  sw         $s2, 0x20($sp)
    /* 8A6B30 800F1F30 AFB00024 */  sw         $s0, 0x24($sp)
    /* 8A6B34 800F1F34 AFB00028 */  sw         $s0, 0x28($sp)

    # RECOMP ASPECT MOD:
    jal        bike_select_get_aspect_metrics
     nop
    addiu      $t9, $zero, 0xA0
    addu       $a1, $t9, $v0
    addiu      $a1, $a1, -0x20           # right - 32
    addu       $a0, $s1, $zero
    addu       $a2, $zero, $zero
    addiu      $a3, $zero, 0x20
    /* 8A6B38 800F1F38 0C017216 */  jal        func_8005C858
    /* 8A6B3C 800F1F3C AFB2002C */   sw        $s2, 0x2C($sp)
    /* 8A6B50 800F1F50 24130018 */  addiu      $s3, $zero, 0x18
    /* 8A6B54 800F1F54 AFB30010 */  sw         $s3, 0x10($sp)
    /* 8A6B58 800F1F58 AFA00014 */  sw         $zero, 0x14($sp)
    /* 8A6B5C 800F1F5C AFA00018 */  sw         $zero, 0x18($sp)
    /* 8A6B60 800F1F60 AFA0001C */  sw         $zero, 0x1C($sp)
    /* 8A6B64 800F1F64 AFB00020 */  sw         $s0, 0x20($sp)
    /* 8A6B68 800F1F68 AFB00024 */  sw         $s0, 0x24($sp)
    /* 8A6B6C 800F1F6C AFB20028 */  sw         $s2, 0x28($sp)

    # RECOMP ASPECT MOD:
    jal        bike_select_get_aspect_metrics
     nop
    addiu      $t9, $zero, 0xA0
    subu       $a1, $t9, $v0             # left
    sll        $a3, $v0, 1               # full width
    addu       $a0, $s1, $zero
    addu       $a2, $zero, $zero
    /* 8A6B70 800F1F70 0C017216 */  jal        func_8005C858
    /* 8A6B74 800F1F74 AFB2002C */   sw        $s2, 0x2C($sp)
    /* 8A6B88 800F1F88 AFB30010 */  sw         $s3, 0x10($sp)
    /* 8A6B8C 800F1F8C AFA00014 */  sw         $zero, 0x14($sp)
    /* 8A6B90 800F1F90 AFA00018 */  sw         $zero, 0x18($sp)
    /* 8A6B94 800F1F94 AFA0001C */  sw         $zero, 0x1C($sp)
    /* 8A6B98 800F1F98 AFB20020 */  sw         $s2, 0x20($sp)
    /* 8A6B9C 800F1F9C AFB20024 */  sw         $s2, 0x24($sp)
    /* 8A6BA0 800F1FA0 AFB00028 */  sw         $s0, 0x28($sp)

    # RECOMP ASPECT MOD:
    jal        bike_select_get_aspect_metrics
     nop
    addiu      $t9, $zero, 0xA0
    subu       $a1, $t9, $v0             # left
    sll        $a3, $v0, 1               # full width
    addu       $a0, $s1, $zero
    addiu      $a2, $zero, 0xD8          # y = 216
    /* 8A6BA4 800F1FA4 0C017216 */  jal        func_8005C858
    /* 8A6BA8 800F1FA8 AFB0002C */   sw        $s0, 0x2C($sp)
    /* 8A6BAC 800F1FAC 0C01744B */  jal        func_8005D12C
    /* 8A6BB0 800F1FB0 02202021 */   addu      $a0, $s1, $zero
    /* 8A6BB4 800F1FB4 8FBF0040 */  lw         $ra, 0x40($sp)
    /* 8A6BB8 800F1FB8 8FB3003C */  lw         $s3, 0x3C($sp)
    /* 8A6BBC 800F1FBC 8FB20038 */  lw         $s2, 0x38($sp)
    /* 8A6BC0 800F1FC0 8FB10034 */  lw         $s1, 0x34($sp)
    /* 8A6BC4 800F1FC4 8FB00030 */  lw         $s0, 0x30($sp)
    /* 8A6BC8 800F1FC8 27BD0048 */  addiu      $sp, $sp, 0x48
    /* 8A6BCC 800F1FCC 03E00008 */  jr         $ra
    /* 8A6BD0 800F1FD0 00000000 */   nop
.size func_800F1DE0, . - func_800F1DE0

glabel func_800E5D68
    jal EG_gEXEnable
    nop

    jal EG_gEXSetScissor
    nop

    /* 89A968 800E5D68 27BDFFA8 */  addiu      $sp, $sp, -0x58
    /* 89A96C 800E5D6C AFBE0050 */  sw         $fp, 0x50($sp)
    /* 89A970 800E5D70 8FBE0070 */  lw         $fp, 0x70($sp)
    /* 89A974 800E5D74 AFB7004C */  sw         $s7, 0x4C($sp)
    /* 89A978 800E5D78 00A0B821 */  addu       $s7, $a1, $zero
    /* 89A97C 800E5D7C 00071100 */  sll        $v0, $a3, 4
    /* 89A980 800E5D80 AFB00030 */  sw         $s0, 0x30($sp)
    /* 89A984 800E5D84 8FB00074 */  lw         $s0, 0x74($sp)
    /* 89A988 800E5D88 00471023 */  subu       $v0, $v0, $a3
    /* 89A98C 800E5D8C 244400A0 */  addiu      $a0, $v0, 0xA0
    /* 89A990 800E5D90 AFBF0054 */  sw         $ra, 0x54($sp)
    /* 89A994 800E5D94 AFB60048 */  sw         $s6, 0x48($sp)
    /* 89A998 800E5D98 AFB50044 */  sw         $s5, 0x44($sp)
    /* 89A99C 800E5D9C AFB40040 */  sw         $s4, 0x40($sp)
    /* 89A9A0 800E5DA0 AFB3003C */  sw         $s3, 0x3C($sp)
    /* 89A9A4 800E5DA4 AFB20038 */  sw         $s2, 0x38($sp)
    /* 89A9A8 800E5DA8 04810002 */  bgez       $a0, .L800E5DB4
    /* 89A9AC 800E5DAC AFB10034 */   sw        $s1, 0x34($sp)
    /* 89A9B0 800E5DB0 244400AF */  addiu      $a0, $v0, 0xAF
  .L800E5DB4:
    /* 89A9B4 800E5DB4 3C01800A */  lui        $at, %hi(D_8009E570)
    /* 89A9B8 800E5DB8 D422E570 */  ldc1       $fv1, %lo(D_8009E570)($at)
    /* 89A9BC 800E5DBC C7A0006C */  lwc1       $fv0, 0x6C($sp)
    /* 89A9C0 800E5DC0 46800021 */  cvt.d.w    $fv0, $fv0
    /* 89A9C4 800E5DC4 46220102 */  mul.d      $ft0, $fv0, $fv1
    /* 89A9C8 800E5DC8 3C01800A */  lui        $at, %hi(D_8009E578)
    /* 89A9CC 800E5DCC D420E578 */  ldc1       $fv0, %lo(D_8009E578)($at)
    /* 89A9D0 800E5DD0 00061100 */  sll        $v0, $a2, 4
    /* 89A9D4 800E5DD4 00463023 */  subu       $a2, $v0, $a2
    /* 89A9D8 800E5DD8 46202001 */  sub.d      $fv0, $ft0, $fv0
    /* 89A9DC 800E5DDC 24C300A0 */  addiu      $v1, $a2, 0xA0
    /* 89A9E0 800E5DE0 00041103 */  sra        $v0, $a0, 4
    /* 89A9E4 800E5DE4 2456FF72 */  addiu      $s6, $v0, -0x8E
    /* 89A9E8 800E5DE8 4620008D */  trunc.w.d  $fv1, $fv0
    /* 89A9EC 800E5DEC 44151000 */  mfc1       $s5, $fv1
    /* 89A9F0 800E5DF0 04620001 */  bltzl      $v1, .L800E5DF8
    /* 89A9F4 800E5DF4 24C300AF */   addiu     $v1, $a2, 0xAF
  .L800E5DF8:
    /* 89A9F8 800E5DF8 3C01800A */  lui        $at, %hi(D_8009E580)
    /* 89A9FC 800E5DFC D420E580 */  ldc1       $fv0, %lo(D_8009E580)($at)
    /* 89AA00 800E5E00 3C118017 */  lui        $s1, %hi(gMasterDisp)
    /* 89AA04 800E5E04 263189EC */  addiu      $s1, $s1, %lo(gMasterDisp)
    /* 89AA08 800E5E08 46202001 */  sub.d      $fv0, $ft0, $fv0
    /* 89AA0C 800E5E0C 00031103 */  sra        $v0, $v1, 4
    /* 89AA10 800E5E10 24530018 */  addiu      $s3, $v0, 0x18
    /* 89AA14 800E5E14 4620008D */  trunc.w.d  $fv1, $fv0
    /* 89AA18 800E5E18 44141000 */  mfc1       $s4, $fv1
    /* 89AA1C 800E5E1C 0C018ADE */  jal        func_80062B78
    /* 89AA20 800E5E20 02202021 */   addu      $a0, $s1, $zero
    /* 89AA24 800E5E24 00109080 */  sll        $s2, $s0, 2
    /* 89AA28 800E5E28 3C018011 */  lui        $at, %hi(D_8010CF40)
    /* 89AA2C 800E5E2C 00320821 */  addu       $at, $at, $s2
    /* 89AA30 800E5E30 8C24CF40 */  lw         $a0, %lo(D_8010CF40)($at)
    /* 89AA34 800E5E34 0C017610 */  jal        func_8005D840
    /* 89AA38 800E5E38 248400CD */   addiu     $a0, $a0, 0xCD
    /* 89AA3C 800E5E3C 3C0300C0 */  lui        $v1, (0xC0C0C0 >> 16)
    /* 89AA40 800E5E40 3463C0C0 */  ori        $v1, $v1, (0xC0C0C0 & 0xFFFF)
    /* 89AA44 800E5E44 02202021 */  addu       $a0, $s1, $zero
    /* 89AA48 800E5E48 3C05800A */  lui        $a1, %hi(D_8009E560)
    /* 89AA4C 800E5E4C 24A5E560 */  addiu      $a1, $a1, %lo(D_8009E560)
    /* 89AA50 800E5E50 24060004 */  addiu      $a2, $zero, 0x4
    /* 89AA54 800E5E54 24070005 */  addiu      $a3, $zero, 0x5
    /* 89AA58 800E5E58 AFA30010 */  sw         $v1, 0x10($sp)
    /* 89AA5C 800E5E5C 26A3FFFA */  addiu      $v1, $s5, -0x6
    /* 89AA60 800E5E60 AFA3001C */  sw         $v1, 0x1C($sp)
    /* 89AA64 800E5E64 24030080 */  addiu      $v1, $zero, 0x80
    /* 89AA68 800E5E68 24100001 */  addiu      $s0, $zero, 0x1
    /* 89AA6C 800E5E6C AFBE0014 */  sw         $fp, 0x14($sp)
    /* 89AA70 800E5E70 AFB60018 */  sw         $s6, 0x18($sp)
    /* 89AA74 800E5E74 AFA30020 */  sw         $v1, 0x20($sp)
    /* 89AA78 800E5E78 AFB00024 */  sw         $s0, 0x24($sp)
    /* 89AA7C 800E5E7C 0C019101 */  jal        func_80064404
    /* 89AA80 800E5E80 AFA20028 */   sw        $v0, 0x28($sp)
    /* 89AA84 800E5E84 3C038018 */  lui        $v1, %hi(D_8017AA38)
    /* 89AA88 800E5E88 8C63AA38 */  lw         $v1, %lo(D_8017AA38)($v1)
    /* 89AA8C 800E5E8C 14700012 */  bne        $v1, $s0, .L800E5ED8
    /* 89AA90 800E5E90 00000000 */   nop
    /* 89AA94 800E5E94 3C028018 */  lui        $v0, %hi(D_8017AA3C)
    /* 89AA98 800E5E98 8C42AA3C */  lw         $v0, %lo(D_8017AA3C)($v0)
    /* 89AA9C 800E5E9C 1443000E */  bne        $v0, $v1, .L800E5ED8

    // Shot type
    jal EG_RectAlign_Origin_Right_Right
    nop

    /* 89AAA0 800E5EA0 02202021 */   addu      $a0, $s1, $zero
    /* 89AAA4 800E5EA4 3C05800A */  lui        $a1, %hi(D_8009E568)
    /* 89AAA8 800E5EA8 24A5E568 */  addiu      $a1, $a1, %lo(D_8009E568)
    /* 89AAAC 800E5EAC AFB30010 */  sw         $s3, 0x10($sp)
    /* 89AAB0 800E5EB0 AFB40014 */  sw         $s4, 0x14($sp)
    /* 89AAB4 800E5EB4 AFA20018 */  sw         $v0, 0x18($sp)
    /* 89AAB8 800E5EB8 AFA2001C */  sw         $v0, 0x1C($sp)
    /* 89AABC 800E5EBC 3C018011 */  lui        $at, %hi(D_8010D188)
    /* 89AAC0 800E5EC0 00320821 */  addu       $at, $at, $s2
    /* 89AAC4 800E5EC4 8C22D188 */  lw         $v0, %lo(D_8010D188)($at)

    /* 89AAC8 800E5EC8 24060002 */  addiu      $a2, $zero, 0x2
    /* 89AACC 800E5ECC 24070010 */  addiu      $a3, $zero, 0x10
    /* 89AAD0 800E5ED0 0C019101 */  jal        func_80064404
    /* 89AAD4 800E5ED4 AFA20020 */   sw        $v0, 0x20($sp)

    jal EG_RectAlign_Origin_None_None
    nop

  .L800E5ED8:
    /* 89AAD8 800E5ED8 3C108017 */  lui        $s0, %hi(gMasterDisp)
    /* 89AADC 800E5EDC 261089EC */  addiu      $s0, $s0, %lo(gMasterDisp)

    // Bike name in Single player, shot type in multiplayer

    // if (gPlayerCount == 2) {
    //   align to right()
    // } else {
    //   align to left()
    // }

    lui     $v1, %hi(D_8017AA38)
    lw      $v1, %lo(D_8017AA38)($v1)
    addiu   $v0, $zero, 2
    bne     $v1, $v0, .left
    nop
    jal     EG_RectAlign_Origin_Right_Right
    nop
    j       .out
    nop
    .left:
    jal     EG_RectAlign_Origin_Left_Left
    nop
    .out:

    /* 89AAE0 800E5EE0 0C018B20 */  jal        func_80062C80
    /* 89AAE4 800E5EE4 02002021 */   addu      $a0, $s0, $zero

    jal EG_RectAlign_Origin_None_None
    nop

    /* 89AAE8 800E5EE8 0C0192BA */  jal        func_80064AE8
    /* 89AAEC 800E5EEC 02002021 */   addu      $a0, $s0, $zero

    /* 89AAF0 800E5EF0 3C06B900 */  lui        $a2, (0xB900031D >> 16)
    /* 89AAF4 800E5EF4 34C6031D */  ori        $a2, $a2, (0xB900031D & 0xFFFF)
    /* 89AAF8 800E5EF8 3C040050 */  lui        $a0, (0x504240 >> 16)
    /* 89AAFC 800E5EFC 34844240 */  ori        $a0, $a0, (0x504240 & 0xFFFF)
    /* 89AB00 800E5F00 3C07FC11 */  lui        $a3, (0xFC119623 >> 16)
    /* 89AB04 800E5F04 34E79623 */  ori        $a3, $a3, (0xFC119623 & 0xFFFF)
    /* 89AB08 800E5F08 3C05FF2F */  lui        $a1, (0xFF2FFFFF >> 16)
    /* 89AB0C 800E5F0C 34A5FFFF */  ori        $a1, $a1, (0xFF2FFFFF & 0xFFFF)
    /* 89AB10 800E5F10 00008821 */  addu       $s1, $zero, $zero
    /* 89AB14 800E5F14 0200A021 */  addu       $s4, $s0, $zero
    /* 89AB18 800E5F18 00151480 */  sll        $v0, $s5, 18
    /* 89AB1C 800E5F1C 00029C03 */  sra        $s3, $v0, 16
    /* 89AB20 800E5F20 3C150001 */  lui        $s5, (0x10000 >> 16)
    /* 89AB24 800E5F24 8E830000 */  lw         $v1, 0x0($s4)
    /* 89AB28 800E5F28 02C08021 */  addu       $s0, $s6, $zero
    /* 89AB2C 800E5F2C 02E09021 */  addu       $s2, $s7, $zero
    /* 89AB30 800E5F30 24620008 */  addiu      $v0, $v1, 0x8
    /* 89AB34 800E5F34 AE820000 */  sw         $v0, 0x0($s4)
    /* 89AB38 800E5F38 24620010 */  addiu      $v0, $v1, 0x10
    /* 89AB3C 800E5F3C AC660000 */  sw         $a2, 0x0($v1)
    /* 89AB40 800E5F40 AC640004 */  sw         $a0, 0x4($v1)
    /* 89AB44 800E5F44 AE820000 */  sw         $v0, 0x0($s4)
    /* 89AB48 800E5F48 24620018 */  addiu      $v0, $v1, 0x18
    /* 89AB4C 800E5F4C AC670008 */  sw         $a3, 0x8($v1)
    /* 89AB50 800E5F50 AC65000C */  sw         $a1, 0xC($v1)
    /* 89AB54 800E5F54 AE820000 */  sw         $v0, 0x0($s4)
    /* 89AB58 800E5F58 3C02FA00 */  lui        $v0, (0xFA000000 >> 16)
    /* 89AB5C 800E5F5C AC620010 */  sw         $v0, 0x10($v1)
    /* 89AB60 800E5F60 2402FF00 */  addiu      $v0, $zero, -0x100
    /* 89AB64 800E5F64 03C21025 */  or         $v0, $fp, $v0
    /* 89AB68 800E5F68 AC620014 */  sw         $v0, 0x14($v1)
  .L800E5F6C:
    /* 89AB6C 800E5F6C 3C048018 */  lui        $a0, %hi(D_8017AA7A)
    /* 89AB70 800E5F70 9484AA7A */  lhu        $a0, %lo(D_8017AA7A)($a0)
    /* 89AB74 800E5F74 0C018577 */  jal        func_800615DC
    /* 89AB78 800E5F78 00000000 */   nop
    /* 89AB7C 800E5F7C 8E440000 */  lw         $a0, 0x0($s2)
    /* 89AB80 800E5F80 00402821 */  addu       $a1, $v0, $zero
    /* 89AB84 800E5F84 04810002 */  bgez       $a0, .L800E5F90
    /* 89AB88 800E5F88 00801821 */   addu      $v1, $a0, $zero
    /* 89AB8C 800E5F8C 248300FF */  addiu      $v1, $a0, 0xFF
  .L800E5F90:
    /* 89AB90 800E5F90 00031A03 */  sra        $v1, $v1, 8
    /* 89AB94 800E5F94 2862000A */  slti       $v0, $v1, 0xA
    /* 89AB98 800E5F98 50400001 */  beql       $v0, $zero, .L800E5FA0
    /* 89AB9C 800E5F9C 24030009 */   addiu     $v1, $zero, 0x9
  .L800E5FA0:
    /* 89ABA0 800E5FA0 18600009 */  blez       $v1, .L800E5FC8
    /* 89ABA4 800E5FA4 00801021 */   addu      $v0, $a0, $zero
    /* 89ABA8 800E5FA8 04420001 */  bltzl      $v0, .L800E5FB0
    /* 89ABAC 800E5FAC 244200FF */   addiu     $v0, $v0, 0xFF
  .L800E5FB0:
    /* 89ABB0 800E5FB0 00023203 */  sra        $a2, $v0, 8
    /* 89ABB4 800E5FB4 28C2000A */  slti       $v0, $a2, 0xA
    /* 89ABB8 800E5FB8 50400001 */  beql       $v0, $zero, .L800E5FC0
    /* 89ABBC 800E5FBC 24060009 */   addiu     $a2, $zero, 0x9
  .L800E5FC0:
    /* 89ABC0 800E5FC0 080397F3 */  j          .L800E5FCC
    /* 89ABC4 800E5FC4 24C60005 */   addiu     $a2, $a2, 0x5
  .L800E5FC8:
    /* 89ABC8 800E5FC8 24060005 */  addiu      $a2, $zero, 0x5
  .L800E5FCC:
    /* 89ABCC 800E5FCC 02802021 */  addu       $a0, $s4, $zero
    /* 89ABD0 800E5FD0 2607FFFD */  addiu      $a3, $s0, -0x3
    /* 89ABD4 800E5FD4 00073C80 */  sll        $a3, $a3, 18
    /* 89ABD8 800E5FD8 00073C03 */  sra        $a3, $a3, 16
    /* 89ABDC 800E5FDC AFB30010 */  sw         $s3, 0x10($sp)
    
    jal EG_RectAlign_Origin_Right_Right
    nop

    /* 89ABE0 800E5FE0 0C01981E */  jal        func_80066078
    /* 89ABE4 800E5FE4 AFB50014 */   sw        $s5, 0x14($sp)
    /* 89ABE8 800E5FE8 3C048018 */  lui        $a0, %hi(D_8017AA7A)
    /* 89ABEC 800E5FEC 9484AA7A */  lhu        $a0, %lo(D_8017AA7A)($a0)
    /* 89ABF0 800E5FF0 0C018577 */  jal        func_800615DC
    /* 89ABF4 800E5FF4 26520004 */   addiu     $s2, $s2, 0x4
    /* 89ABF8 800E5FF8 3C048017 */  lui        $a0, %hi(gMasterDisp)
    /* 89ABFC 800E5FFC 248489EC */  addiu      $a0, $a0, %lo(gMasterDisp)
    /* 89AC00 800E6000 00402821 */  addu       $a1, $v0, $zero
    /* 89AC04 800E6004 00103C80 */  sll        $a3, $s0, 18
    /* 89AC08 800E6008 00073C03 */  sra        $a3, $a3, 16
    /* 89AC0C 800E600C 3C018011 */  lui        $at, %hi(D_8010D180)
    /* 89AC10 800E6010 00310821 */  addu       $at, $at, $s1
    /* 89AC14 800E6014 9026D180 */  lbu        $a2, %lo(D_8010D180)($at)
    /* 89AC18 800E6018 2610001B */  addiu      $s0, $s0, 0x1B
    /* 89AC1C 800E601C 26310001 */  addiu      $s1, $s1, 0x1
    /* 89AC20 800E6020 AFB30010 */  sw         $s3, 0x10($sp)
    /* 89AC24 800E6024 0C01981E */  jal        func_80066078
    nop
        
    jal EG_RectAlign_Origin_None_None
    nop

    /* 89AC28 800E6028 AFB50014 */   sw        $s5, 0x14($sp)
    /* 89AC2C 800E602C 2A220005 */  slti       $v0, $s1, 0x5
    /* 89AC30 800E6030 1440FFCE */  bnez       $v0, .L800E5F6C
    /* 89AC34 800E6034 00000000 */   nop
    /* 89AC38 800E6038 3C048017 */  lui        $a0, %hi(gMasterDisp)
    /* 89AC3C 800E603C 248489EC */  addiu      $a0, $a0, %lo(gMasterDisp)
    /* 89AC40 800E6040 0C0192CA */  jal        func_80064B28
    /* 89AC44 800E6044 00000000 */   nop
    /* 89AC48 800E6048 8FBF0054 */  lw         $ra, 0x54($sp)
    /* 89AC4C 800E604C 8FBE0050 */  lw         $fp, 0x50($sp)
    /* 89AC50 800E6050 8FB7004C */  lw         $s7, 0x4C($sp)
    /* 89AC54 800E6054 8FB60048 */  lw         $s6, 0x48($sp)
    /* 89AC58 800E6058 8FB50044 */  lw         $s5, 0x44($sp)
    /* 89AC5C 800E605C 8FB40040 */  lw         $s4, 0x40($sp)
    /* 89AC60 800E6060 8FB3003C */  lw         $s3, 0x3C($sp)
    /* 89AC64 800E6064 8FB20038 */  lw         $s2, 0x38($sp)
    /* 89AC68 800E6068 8FB10034 */  lw         $s1, 0x34($sp)
    /* 89AC6C 800E606C 8FB00030 */  lw         $s0, 0x30($sp)
    /* 89AC70 800E6070 27BD0058 */  addiu      $sp, $sp, 0x58
    /* 89AC74 800E6074 03E00008 */  jr         $ra
    /* 89AC78 800E6078 00000000 */   nop
.size func_800E5D68, . - func_800E5D68

glabel func_800E7900
    /* 89C500 800E7900 27BDFFC0 */  addiu      $sp, $sp, -0x40
    /* 89C504 800E7904 AFBF003C */  sw         $ra, 0x3C($sp)
    /* 89C508 800E7908 AFB20038 */  sw         $s2, 0x38($sp)
    /* 89C50C 800E790C AFB10034 */  sw         $s1, 0x34($sp)
    /* 89C510 800E7910 0C03C468 */  jal        func_800F11A0
    /* 89C514 800E7914 AFB00030 */   sw        $s0, 0x30($sp)
    /* 89C518 800E7918 00002021 */  addu       $a0, $zero, $zero
    /* 89C51C 800E791C 00002821 */  addu       $a1, $zero, $zero
    /* 89C520 800E7920 00003021 */  addu       $a2, $zero, $zero
    /* 89C524 800E7924 0C03C53C */  jal        func_800F14F0
    /* 89C528 800E7928 240700FF */   addiu     $a3, $zero, 0xFF
    /* 89C52C 800E792C 3C028018 */  lui        $v0, %hi(D_8017AA38)
    /* 89C530 800E7930 8C42AA38 */  lw         $v0, %lo(D_8017AA38)($v0)
    /* 89C534 800E7934 1C400003 */  bgtz       $v0, .L800E7944
    /* 89C538 800E7938 00000000 */   nop
    /* 89C53C 800E793C 0C03C6BE */  jal        func_800F1AF8
    /* 89C540 800E7940 24040080 */   addiu     $a0, $zero, 0x80
  .L800E7944:
    /* 89C544 800E7944 3C048018 */  lui        $a0, %hi(D_8017AA44)
    /* 89C548 800E7948 8C84AA44 */  lw         $a0, %lo(D_8017AA44)($a0)
    /* 89C54C 800E794C 1880001B */  blez       $a0, .L800E79BC
    /* 89C550 800E7950 3C05ED28 */   lui       $a1, (0xED2801E0 >> 16)
    /* 89C554 800E7954 34A501E0 */  ori        $a1, $a1, (0xED2801E0 & 0xFFFF)
    /* 89C558 800E7958 3C120050 */  lui        $s2, (0x5003C0 >> 16)
    /* 89C55C 800E795C 3C108017 */  lui        $s0, %hi(gMasterDisp)
    /* 89C560 800E7960 261089EC */  addiu      $s0, $s0, %lo(gMasterDisp)
    /* 89C564 800E7964 8E030000 */  lw         $v1, 0x0($s0)
    /* 89C568 800E7968 365203C0 */  ori        $s2, $s2, (0x5003C0 & 0xFFFF)
    /* 89C56C 800E796C 3C11E700 */  lui        $s1, (0xE7000000 >> 16)
    /* 89C570 800E7970 24620008 */  addiu      $v0, $v1, 0x8
    /* 89C574 800E7974 AE020000 */  sw         $v0, 0x0($s0)
    /* 89C578 800E7978 24620010 */  addiu      $v0, $v1, 0x10
    /* 89C57C 800E797C AC710000 */  sw         $s1, 0x0($v1)
    /* 89C580 800E7980 AC600004 */  sw         $zero, 0x4($v1)
    /* 89C584 800E7984 AE020000 */  sw         $v0, 0x0($s0)
    /* 89C588 800E7988 AC650008 */  sw         $a1, 0x8($v1)
    /* 89C58C 800E798C 0C03C6BE */  jal        func_800F1AF8
    /* 89C590 800E7990 AC72000C */   sw        $s2, 0xC($v1)
    /* 89C594 800E7994 8E030000 */  lw         $v1, 0x0($s0)
    /* 89C598 800E7998 24620008 */  addiu      $v0, $v1, 0x8
    /* 89C59C 800E799C AE020000 */  sw         $v0, 0x0($s0)
    /* 89C5A0 800E79A0 24620010 */  addiu      $v0, $v1, 0x10
    /* 89C5A4 800E79A4 AC710000 */  sw         $s1, 0x0($v1)
    /* 89C5A8 800E79A8 AC600004 */  sw         $zero, 0x4($v1)
    /* 89C5AC 800E79AC AE020000 */  sw         $v0, 0x0($s0)
    /* 89C5B0 800E79B0 3C02ED00 */  lui        $v0, (0xED000000 >> 16)
    /* 89C5B4 800E79B4 AC620008 */  sw         $v0, 0x8($v1)
    /* 89C5B8 800E79B8 AC72000C */  sw         $s2, 0xC($v1)
  .L800E79BC:
    /* 89C5BC 800E79BC 00008821 */  addu       $s1, $zero, $zero
    /* 89C5C0 800E79C0 00008021 */  addu       $s0, $zero, $zero
  .L800E79C4:
    /* 89C5C4 800E79C4 3C028018 */  lui        $v0, %hi(D_8017AA14)
    /* 89C5C8 800E79C8 8C42AA14 */  lw         $v0, %lo(D_8017AA14)($v0)
    /* 89C5CC 800E79CC 02022021 */  addu       $a0, $s0, $v0
    /* 89C5D0 800E79D0 8C820004 */  lw         $v0, 0x4($a0)
    /* 89C5D4 800E79D4 10400003 */  beqz       $v0, .L800E79E4
    /* 89C5D8 800E79D8 26310001 */   addiu     $s1, $s1, 0x1
    /* 89C5DC 800E79DC 0C039A82 */  jal        func_800E6A08
    /* 89C5E0 800E79E0 00000000 */   nop
  .L800E79E4:
    /* 89C5E4 800E79E4 2A220004 */  slti       $v0, $s1, 0x4
    /* 89C5E8 800E79E8 1440FFF6 */  bnez       $v0, .L800E79C4
    /* 89C5EC 800E79EC 261001A0 */   addiu     $s0, $s0, 0x1A0
    /* 89C5F0 800E79F0 0C03C778 */  jal        func_800F1DE0
    /* 89C5F4 800E79F4 00000000 */   nop
    /* 89C5F8 800E79F8 3C048018 */  lui        $a0, %hi(D_8017AA30)
    /* 89C5FC 800E79FC 8C84AA30 */  lw         $a0, %lo(D_8017AA30)($a0)
    /* 89C600 800E7A00 3402D2D0 */  ori        $v0, $zero, 0xD2D0
    /* 89C604 800E7A04 2483FFE1 */  addiu      $v1, $a0, -0x1F
    /* 89C608 800E7A08 0043102B */  sltu       $v0, $v0, $v1
    /* 89C60C 800E7A0C 14400034 */  bnez       $v0, .L800E7AE0
    /* 89C610 800E7A10 2882002E */   slti      $v0, $a0, 0x2E
    /* 89C614 800E7A14 14400006 */  bnez       $v0, .L800E7A30
    /* 89C618 800E7A18 2483FFE2 */   addiu     $v1, $a0, -0x1E
    /* 89C61C 800E7A1C 3402D2E0 */  ori        $v0, $zero, 0xD2E0
    /* 89C620 800E7A20 0044102A */  slt        $v0, $v0, $a0
    /* 89C624 800E7A24 10400006 */  beqz       $v0, .L800E7A40
    /* 89C628 800E7A28 3403D2F0 */   ori       $v1, $zero, 0xD2F0
    /* 89C62C 800E7A2C 00641823 */  subu       $v1, $v1, $a0
  .L800E7A30:
    /* 89C630 800E7A30 00031040 */  sll        $v0, $v1, 1
    /* 89C634 800E7A34 00431021 */  addu       $v0, $v0, $v1
    /* 89C638 800E7A38 08039E91 */  j          .L800E7A44
    /* 89C63C 800E7A3C 00028880 */   sll       $s1, $v0, 2
  .L800E7A40:
    /* 89C640 800E7A40 241100C0 */  addiu      $s1, $zero, 0xC0
  .L800E7A44:
    /* 89C644 800E7A44 3C108017 */  lui        $s0, %hi(gMasterDisp)
    /* 89C648 800E7A48 261089EC */  addiu      $s0, $s0, %lo(gMasterDisp)
    /* 89C64C 800E7A4C 0C018ADE */  jal        func_80062B78
    /* 89C650 800E7A50 02002021 */   addu      $a0, $s0, $zero
    /* 89C654 800E7A54 0C017610 */  jal        func_8005D840
    /* 89C658 800E7A58 240400C3 */   addiu     $a0, $zero, 0xC3
    /* 89C65C 800E7A5C 3C0800FF */  lui        $t0, (0xFFFFFF >> 16)
    /* 89C660 800E7A60 3508FFFF */  ori        $t0, $t0, (0xFFFFFF & 0xFFFF)
    /* 89C664 800E7A64 02002021 */  addu       $a0, $s0, $zero
    /* 89C668 800E7A68 3C05800A */  lui        $a1, %hi(D_8009E64C)
    /* 89C66C 800E7A6C 24A5E64C */  addiu      $a1, $a1, %lo(D_8009E64C)
    /* 89C670 800E7A70 24060004 */  addiu      $a2, $zero, 0x4
    /* 89C674 800E7A74 00003821 */  addu       $a3, $zero, $zero
    /* 89C678 800E7A78 2403001C */  addiu      $v1, $zero, 0x1C
    /* 89C67C 800E7A7C AFA30010 */  sw         $v1, 0x10($sp)
    /* 89C680 800E7A80 24030120 */  addiu      $v1, $zero, 0x120
    /* 89C684 800E7A84 AFA30014 */  sw         $v1, 0x14($sp)
    /* 89C688 800E7A88 240300F0 */  addiu      $v1, $zero, 0xF0
    /* 89C68C 800E7A8C AFA30018 */  sw         $v1, 0x18($sp)
    /* 89C690 800E7A90 24030005 */  addiu      $v1, $zero, 0x5
    /* 89C694 800E7A94 AFA3001C */  sw         $v1, 0x1C($sp)
    /* 89C698 800E7A98 AFA80020 */  sw         $t0, 0x20($sp)
    /* 89C69C 800E7A9C AFB10024 */  sw         $s1, 0x24($sp)
    /* 89C6A0 800E7AA0 0C019101 */  jal        func_80064404
    /* 89C6A4 800E7AA4 AFA20028 */   sw        $v0, 0x28($sp)

    jal EG_gEXEnable
    nop

    jal EG_gEXSetScissor
    nop

    // Right button to customize controls legend
    jal EG_RectAlign_Origin_Right_Right
    nop

    /* 89C6A8 800E7AA8 0C018B20 */  jal        func_80062C80
    /* 89C6AC 800E7AAC 02002021 */   addu      $a0, $s0, $zero

    jal EG_RectAlign_Origin_None_None
    nop

    /* 89C6B0 800E7AB0 3C028018 */  lui        $v0, %hi(D_8017AA38)
    /* 89C6B4 800E7AB4 8C42AA38 */  lw         $v0, %lo(D_8017AA38)($v0)
    /* 89C6B8 800E7AB8 28420002 */  slti       $v0, $v0, 0x2
    /* 89C6BC 800E7ABC 14400008 */  bnez       $v0, .L800E7AE0
    /* 89C6C0 800E7AC0 3402D2E0 */   ori       $v0, $zero, 0xD2E0
    /* 89C6C4 800E7AC4 3C048018 */  lui        $a0, %hi(D_8017AA30)
    /* 89C6C8 800E7AC8 2484AA30 */  addiu      $a0, $a0, %lo(D_8017AA30)
    /* 89C6CC 800E7ACC 8C830000 */  lw         $v1, 0x0($a0)
    /* 89C6D0 800E7AD0 0062102A */  slt        $v0, $v1, $v0
    /* 89C6D4 800E7AD4 54400001 */  bnel       $v0, $zero, .L800E7ADC
    /* 89C6D8 800E7AD8 3403D2E0 */   ori       $v1, $zero, 0xD2E0
  .L800E7ADC:
    /* 89C6DC 800E7ADC AC830000 */  sw         $v1, 0x0($a0)
  .L800E7AE0:
    /* 89C6E0 800E7AE0 3C048018 */  lui        $a0, %hi(D_8017AA34)
    /* 89C6E4 800E7AE4 8C84AA34 */  lw         $a0, %lo(D_8017AA34)($a0)
    /* 89C6E8 800E7AE8 2482FFE1 */  addiu      $v0, $a0, -0x1F
    /* 89C6EC 800E7AEC 2C4201C1 */  sltiu      $v0, $v0, 0x1C1
    /* 89C6F0 800E7AF0 10400026 */  beqz       $v0, .L800E7B8C
    /* 89C6F4 800E7AF4 2882002E */   slti      $v0, $a0, 0x2E
    /* 89C6F8 800E7AF8 14400006 */  bnez       $v0, .L800E7B14
    /* 89C6FC 800E7AFC 2483FFE2 */   addiu     $v1, $a0, -0x1E
    /* 89C700 800E7B00 288201D1 */  slti       $v0, $a0, 0x1D1
    /* 89C704 800E7B04 14400006 */  bnez       $v0, .L800E7B20
    /* 89C708 800E7B08 241100C0 */   addiu     $s1, $zero, 0xC0
    /* 89C70C 800E7B0C 240301E0 */  addiu      $v1, $zero, 0x1E0
    /* 89C710 800E7B10 00641823 */  subu       $v1, $v1, $a0
  .L800E7B14:
    /* 89C714 800E7B14 00031040 */  sll        $v0, $v1, 1
    /* 89C718 800E7B18 00431021 */  addu       $v0, $v0, $v1
    /* 89C71C 800E7B1C 00028880 */  sll        $s1, $v0, 2
  .L800E7B20:
    /* 89C720 800E7B20 3C108017 */  lui        $s0, %hi(gMasterDisp)
    /* 89C724 800E7B24 261089EC */  addiu      $s0, $s0, %lo(gMasterDisp)
    /* 89C728 800E7B28 0C018ADE */  jal        func_80062B78
    /* 89C72C 800E7B2C 02002021 */   addu      $a0, $s0, $zero
    /* 89C730 800E7B30 0C017610 */  jal        func_8005D840
    /* 89C734 800E7B34 24040078 */   addiu     $a0, $zero, 0x78
    /* 89C738 800E7B38 3C0800FF */  lui        $t0, (0xFFFFFF >> 16)
    /* 89C73C 800E7B3C 3508FFFF */  ori        $t0, $t0, (0xFFFFFF & 0xFFFF)
    /* 89C740 800E7B40 02002021 */  addu       $a0, $s0, $zero
    /* 89C744 800E7B44 3C05800A */  lui        $a1, %hi(D_8009E64C)
    /* 89C748 800E7B48 24A5E64C */  addiu      $a1, $a1, %lo(D_8009E64C)
    /* 89C74C 800E7B4C 24060002 */  addiu      $a2, $zero, 0x2
    /* 89C750 800E7B50 24070020 */  addiu      $a3, $zero, 0x20
    /* 89C754 800E7B54 2403002C */  addiu      $v1, $zero, 0x2C
    /* 89C758 800E7B58 AFA30010 */  sw         $v1, 0x10($sp)
    /* 89C75C 800E7B5C 24030140 */  addiu      $v1, $zero, 0x140
    /* 89C760 800E7B60 AFA30014 */  sw         $v1, 0x14($sp)
    /* 89C764 800E7B64 240300F0 */  addiu      $v1, $zero, 0xF0
    /* 89C768 800E7B68 AFA30018 */  sw         $v1, 0x18($sp)
    /* 89C76C 800E7B6C 24030005 */  addiu      $v1, $zero, 0x5
    /* 89C770 800E7B70 AFA3001C */  sw         $v1, 0x1C($sp)
    /* 89C774 800E7B74 AFA80020 */  sw         $t0, 0x20($sp)
    /* 89C778 800E7B78 AFB10024 */  sw         $s1, 0x24($sp)

    /* 89C77C 800E7B7C 0C019101 */  jal        func_80064404
    /* 89C780 800E7B80 AFA20028 */   sw        $v0, 0x28($sp)
      
    jal EG_gEXEnable
    nop

    jal EG_gEXSetScissor
    nop
  
    // Legend: LEFT BUTTON TO REARRANGE THE SCREEN
    jal EG_RectAlign_Origin_Left_Left
    nop

    /* 89C784 800E7B84 0C018B20 */  jal        func_80062C80
    /* 89C788 800E7B88 02002021 */   addu      $a0, $s0, $zero

    jal EG_RectAlign_Origin_None_None
    nop

  .L800E7B8C:
    /* 89C78C 800E7B8C 8FBF003C */  lw         $ra, 0x3C($sp)
    /* 89C790 800E7B90 8FB20038 */  lw         $s2, 0x38($sp)
    /* 89C794 800E7B94 8FB10034 */  lw         $s1, 0x34($sp)
    /* 89C798 800E7B98 8FB00030 */  lw         $s0, 0x30($sp)
    /* 89C79C 800E7B9C 27BD0040 */  addiu      $sp, $sp, 0x40
    /* 89C7A0 800E7BA0 03E00008 */  jr         $ra
    /* 89C7A4 800E7BA4 00000000 */   nop
.size func_800E7900, . - func_800E7900