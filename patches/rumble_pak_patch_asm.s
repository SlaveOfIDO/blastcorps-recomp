#if 1
.include "macro.inc"
#include "macro_float_reg.h"

.set noat
.set noreorder

.section .rodata
dlabel jtbl_8004C6E8
    /* 8012E8 8004C6E8 80071D2C */ .word .L80071D2C
    /* 8012EC 8004C6EC 80071DF8 */ .word .L80071DF8
    /* 8012F0 8004C6F0 80071E2C */ .word .L80071E2C
    /* 8012F4 8004C6F4 80071E3C */ .word .L80071E3C
    /* 8012F8 8004C6F8 80071E3C */ .word .L80071E3C
    /* 8012FC 8004C6FC 80071E3C */ .word .L80071E3C
    /* 801300 8004C700 80071E3C */ .word .L80071E3C
    /* 801304 8004C704 80071E3C */ .word .L80071E3C
    /* 801308 8004C708 80071E3C */ .word .L80071E3C
    /* 80130C 8004C70C 80071E3C */ .word .L80071E3C
    /* 801310 8004C710 80071E70 */ .word .L80071E70
    /* 801314 8004C714 80071E44 */ .word .L80071E44
.size jtbl_8004C6E8, . - jtbl_8004C6E8

.section .recomp_patch, "ax"

glabel func_80074C44
    /* 829844 80074C44 27BDFFA0 */  addiu      $sp, $sp, -0x60
    /* 829848 80074C48 AFA40014 */  sw         $a0, 0x14($sp)
    /* 82984C 80074C4C 24040005 */  addiu      $a0, $zero, 0x5
    /* 829850 80074C50 3C058017 */  lui        $a1, %hi(gSerialEventQueue)
    /* 829854 80074C54 24A59CB0 */  addiu      $a1, $a1, %lo(gSerialEventQueue)
    /* 829858 80074C58 3C068017 */  lui        $a2, %hi(D_80175D48)
    /* 82985C 80074C5C 24C65D48 */  addiu      $a2, $a2, %lo(D_80175D48)
    /* 829860 80074C60 AFBF005C */  sw         $ra, 0x5C($sp)
    /* 829864 80074C64 AFBE0058 */  sw         $fp, 0x58($sp)
    /* 829868 80074C68 AFB70054 */  sw         $s7, 0x54($sp)
    /* 82986C 80074C6C AFB60050 */  sw         $s6, 0x50($sp)
    /* 829870 80074C70 AFB5004C */  sw         $s5, 0x4C($sp)
    /* 829874 80074C74 AFB40048 */  sw         $s4, 0x48($sp)
    /* 829878 80074C78 AFB30044 */  sw         $s3, 0x44($sp)
    /* 82987C 80074C7C AFB20040 */  sw         $s2, 0x40($sp)
    /* 829880 80074C80 AFB1003C */  sw         $s1, 0x3C($sp)
    /* 829884 80074C84 AFB00038 */  sw         $s0, 0x38($sp)
    /* 829888 80074C88 0C01FDF8 */  jal        osSetEventMesg_recomp
    /* 82988C 80074C8C AFA0001C */   sw        $zero, 0x1C($sp)
    /* 829890 80074C90 8FA70014 */  lw         $a3, 0x14($sp)
    /* 829894 80074C94 10E00003 */  beqz       $a3, .L80074CA4
    /* 829898 80074C98 24020001 */   addiu     $v0, $zero, 0x1
    /* 82989C 80074C9C 3C018009 */  lui        $at, %hi(D_80097AA4)
    /* 8298A0 80074CA0 AC227AA4 */  sw         $v0, %lo(D_80097AA4)($at)
  .L80074CA4:
    /* 8298A4 80074CA4 0000B021 */  addu       $s6, $zero, $zero
    /* 8298A8 80074CA8 241E0001 */  addiu      $fp, $zero, 0x1

    // @recomp: use gControllerMotor pak handle for rumble pak
    /* 8298AC 80074CAC 3C158017 */  lui        $s5, %hi(gControllerMotor)
    /* 8298B0 80074CB0 26B5ED48 */  addiu      $s5, $s5, %lo(gControllerMotor)
    /* 8298B4 80074CB4 3C078017 */  lui        $a3, %hi(D_8016EEE8)
    /* 8298B8 80074CB8 24E7EEE8 */  addiu      $a3, $a3, %lo(D_8016EEE8)
    /* 8298BC 80074CBC 24F20020 */  addiu      $s2, $a3, 0x20
    /* 8298C0 80074CC0 00009821 */  addu       $s3, $zero, $zero
    /* 8298C4 80074CC4 24F40030 */  addiu      $s4, $a3, 0x30
    /* 8298C8 80074CC8 24F70050 */  addiu      $s7, $a3, 0x50
    /* 8298CC 80074CCC 3C078017 */  lui        $a3, %hi(D_8016EEF8)
    /* 8298D0 80074CD0 24E7EEF8 */  addiu      $a3, $a3, %lo(D_8016EEF8)
    /* 8298D4 80074CD4 AFA7002C */  sw         $a3, 0x2C($sp)
    /* 8298D8 80074CD8 3C078017 */  lui        $a3, %hi(D_8016EEE8)
    /* 8298DC 80074CDC 24E7EEE8 */  addiu      $a3, $a3, %lo(D_8016EEE8)
    /* 8298E0 80074CE0 AFA00024 */  sw         $zero, 0x24($sp)
    /* 8298E4 80074CE4 AFA70034 */  sw         $a3, 0x34($sp)
  .L80074CE8:
    /* 8298E8 80074CE8 8FA70034 */  lw         $a3, 0x34($sp)
    nop // /* 8298EC 80074CEC 8CE30000 */  lw         $v1, 0x0($a3)
    nop // /* 8298F0 80074CF0 24020005 */  addiu      $v0, $zero, 0x5
    nop // /* 8298F4 80074CF4 54620096 */  bnel       $v1, $v0, .L80074F50 // if (*sp34 == 5) {
    nop // /* 8298F8 80074CF8 26B50068 */   addiu     $s5, $s5, 0x68
    /* 8298FC 80074CFC 3C028009 */  lui        $v0, %hi(D_80097AA4)
    /* 829900 80074D00 8C427AA4 */  lw         $v0, %lo(D_80097AA4)($v0)
    /* 829904 80074D04 1040001B */  j .L80074D74 // if (gRumblePakNeedsInit != 0) {
    /* 829908 80074D08 00000000 */   nop
    /* 82990C 80074D0C 3C028009 */  lui        $v0, %hi(D_80097AA8)
    /* 829910 80074D10 8C427AA8 */  lw         $v0, %lo(D_80097AA8)($v0)
    /* 829914 80074D14 1440000C */  bnez       $v0, .L80074D48
    /* 829918 80074D18 00008021 */   addu      $s0, $zero, $zero
    /* 82991C 80074D1C 3C048017 */  lui        $a0, %hi(gSerialEventQueue)
    /* 829920 80074D20 24849CB0 */  addiu      $a0, $a0, %lo(gSerialEventQueue)
    /* 829924 80074D24 02A02821 */  addu       $a1, $s5, $zero
    /* 829928 80074D28 0C023FD4 */  jal        osMotorInit_recomp
    /* 82992C 80074D2C 02C03021 */   addu      $a2, $s6, $zero
    /* 829930 80074D30 54400002 */  bnel       $v0, $zero, .L80074D3C
    /* 829934 80074D34 AE5E0000 */   sw        $fp, 0x0($s2)
    /* 829938 80074D38 AE400000 */  sw         $zero, 0x0($s2)
  .L80074D3C:
    /* 82993C 80074D3C 8FA7002C */  lw         $a3, 0x2C($sp)
    /* 829940 80074D40 ACFE0000 */  sw         $fp, 0x0($a3)
    /* 829944 80074D44 00008021 */  addu       $s0, $zero, $zero
  .L80074D48:
    /* 829948 80074D48 8FB10024 */  lw         $s1, 0x24($sp)
  .L80074D4C:

    // @recomp: use gControllerMotor pak handle for rumble pak
    /* 82994C 80074D4C 3C078017 */  lui        $a3, %hi(gControllerMotor)
    /* 829950 80074D50 24E7ED48 */  addiu      $a3, $a3, %lo(gControllerMotor)
    /* 829954 80074D54 0C023EC0 */  jal        osMotorStop_recomp
    /* 829958 80074D58 02272021 */   addu      $a0, $s1, $a3
    /* 82995C 80074D5C 26100001 */  addiu      $s0, $s0, 0x1
    /* 829960 80074D60 2A020003 */  slti       $v0, $s0, 0x3
    /* 829964 80074D64 1440FFF9 */  bnez       $v0, .L80074D4C
    /* 829968 80074D68 00000000 */   nop
    /* 82996C 80074D6C 0801D3D4 */  j          .L80074F50
    /* 829970 80074D70 26B50068 */   addiu     $s5, $s5, 0x68
  .L80074D74:
    /* 829974 80074D74 8E840000 */  lw         $a0, 0x0($s4)
    /* 829978 80074D78 8FA70014 */  lw         $a3, 0x14($sp)
    /* 82997C 80074D7C 0004102A */  slt        $v0, $zero, $a0
    /* 829980 80074D80 2CE30001 */  sltiu      $v1, $a3, 0x1
    /* 829984 80074D84 00431024 */  and        $v0, $v0, $v1
    /* 829988 80074D88 50400023 */  beql       $v0, $zero, .L80074E18
    /* 82998C 80074D8C 00001821 */   addu      $v1, $zero, $zero
    /* 829990 80074D90 3C028017 */  lui        $v0, %hi(D_801771A0)
    /* 829994 80074D94 8C4271A0 */  lw         $v0, %lo(D_801771A0)($v0)
    /* 829998 80074D98 5440001F */  bnel       $v0, $zero, .L80074E18
    /* 82999C 80074D9C 00001821 */   addu      $v1, $zero, $zero
    /* 8299A0 80074DA0 3C078017 */  lui        $a3, %hi(D_8016EEE8)
    /* 8299A4 80074DA4 24E7EEE8 */  addiu      $a3, $a3, %lo(D_8016EEE8)
    /* 8299A8 80074DA8 24E20040 */  addiu      $v0, $a3, 0x40
    /* 8299AC 80074DAC 02628021 */  addu       $s0, $s3, $v0
    /* 8299B0 80074DB0 8E020000 */  lw         $v0, 0x0($s0)
    /* 8299B4 80074DB4 18400006 */  blez       $v0, .L80074DD0
    /* 8299B8 80074DB8 00000000 */   nop
    /* 8299BC 80074DBC 0C0176A4 */  jal        func_8005DA90
    /* 8299C0 80074DC0 00000000 */   nop
    /* 8299C4 80074DC4 8E030000 */  lw         $v1, 0x0($s0)
    /* 8299C8 80074DC8 0801D37D */  j          .L80074DF4
    /* 8299CC 80074DCC 00000000 */   nop
  .L80074DD0:
    /* 8299D0 80074DD0 8EE20000 */  lw         $v0, 0x0($s7)
    /* 8299D4 80074DD4 0082102A */  slt        $v0, $a0, $v0
    /* 8299D8 80074DD8 5040000C */  beql       $v0, $zero, .L80074E0C
    /* 8299DC 80074DDC 24030001 */   addiu     $v1, $zero, 0x1
    /* 8299E0 80074DE0 0C0176A4 */  jal        func_8005DA90
    /* 8299E4 80074DE4 00000000 */   nop
    /* 8299E8 80074DE8 8EE30000 */  lw         $v1, 0x0($s7)
    /* 8299EC 80074DEC 8E840000 */  lw         $a0, 0x0($s4)
    /* 8299F0 80074DF0 00641823 */  subu       $v1, $v1, $a0
  .L80074DF4:
    /* 8299F4 80074DF4 0043001B */  divu       $zero, $v0, $v1
    /* 8299F8 80074DF8 14600002 */  bnez       $v1, .L80074E04
    /* 8299FC 80074DFC 00000000 */   nop
    /* 829A00 80074E00 0007000D */  break      7
  .L80074E04:
    /* 829A04 80074E04 00001810 */  mfhi       $v1
    /* 829A08 80074E08 2C630001 */  sltiu      $v1, $v1, 0x1
  .L80074E0C:
    /* 829A0C 80074E0C 8E820000 */  lw         $v0, 0x0($s4)
    /* 829A10 80074E10 2442FFFF */  addiu      $v0, $v0, -0x1
    /* 829A14 80074E14 AE820000 */  sw         $v0, 0x0($s4)
  .L80074E18:
    /* 829A18 80074E18 8E420000 */  lw         $v0, 0x0($s2)
    /* 829A1C 80074E1C 10400032 */  beqz       $v0, .L80074EE8
    /* 829A20 80074E20 00000000 */   nop
    /* 829A24 80074E24 3C028009 */  lui        $v0, %hi(D_80097AA0)
    /* 829A28 80074E28 8C427AA0 */  lw         $v0, %lo(D_80097AA0)($v0)
    /* 829A2C 80074E2C 2842003C */  slti       $v0, $v0, 0x3C
    /* 829A30 80074E30 54400047 */  bnel       $v0, $zero, .L80074F50
    /* 829A34 80074E34 26B50068 */   addiu     $s5, $s5, 0x68
    /* 829A38 80074E38 8FA7001C */  lw         $a3, 0x1C($sp)
    /* 829A3C 80074E3C 14E00017 */  bnez       $a3, .L80074E9C
    /* 829A40 80074E40 00000000 */   nop
    /* 829A44 80074E44 3C048018 */  lui        $a0, %hi(D_80186028)
    /* 829A48 80074E48 24846028 */  addiu      $a0, $a0, %lo(D_80186028)
    /* 829A4C 80074E4C 0C01F91C */  jal        osWritebackDCache_recomp
    /* 829A50 80074E50 24050010 */   addiu     $a1, $zero, 0x10
    /* 829A54 80074E54 3C108017 */  lui        $s0, %hi(gSerialEventQueue)
    /* 829A58 80074E58 26109CB0 */  addiu      $s0, $s0, %lo(gSerialEventQueue)
    /* 829A5C 80074E5C 0C022904 */  jal        osContStartQuery_recomp
    /* 829A60 80074E60 02002021 */   addu      $a0, $s0, $zero
    /* 829A64 80074E64 02002021 */  addu       $a0, $s0, $zero
    /* 829A68 80074E68 00002821 */  addu       $a1, $zero, $zero
    /* 829A6C 80074E6C 0C01FD54 */  jal        osRecvMesg_recomp
    /* 829A70 80074E70 24060001 */   addiu     $a2, $zero, 0x1
    /* 829A74 80074E74 3C048018 */  lui        $a0, %hi(D_80186028)
    /* 829A78 80074E78 24846028 */  addiu      $a0, $a0, %lo(D_80186028)
    /* 829A7C 80074E7C 0C022925 */  jal        osContGetQuery_recomp
    /* 829A80 80074E80 00000000 */   nop
    /* 829A84 80074E84 3C048018 */  lui        $a0, %hi(D_80186028)
    /* 829A88 80074E88 24846028 */  addiu      $a0, $a0, %lo(D_80186028)
    /* 829A8C 80074E8C 0C01F8B8 */  jal        osInvalDCache_recomp
    /* 829A90 80074E90 24050010 */   addiu     $a1, $zero, 0x10
    /* 829A94 80074E94 24070001 */  addiu      $a3, $zero, 0x1
    /* 829A98 80074E98 AFA7001C */  sw         $a3, 0x1C($sp)
  .L80074E9C:
    /* 829A9C 80074E9C 3C078018 */  lui        $a3, %hi(D_80186028)
    /* 829AA0 80074EA0 24E76028 */  addiu      $a3, $a3, %lo(D_80186028)
    /* 829AA4 80074EA4 02671021 */  addu       $v0, $s3, $a3
    /* 829AA8 80074EA8 90420002 */  lbu        $v0, 0x2($v0)
    /* 829AAC 80074EAC 30420001 */  andi       $v0, $v0, 0x1
    /* 829AB0 80074EB0 10400026 */  beqz       $v0, .L80074F4C
    /* 829AB4 80074EB4 02A02821 */   addu      $a1, $s5, $zero
    /* 829AB8 80074EB8 3C048017 */  lui        $a0, %hi(gSerialEventQueue)
    /* 829ABC 80074EBC 24849CB0 */  addiu      $a0, $a0, %lo(gSerialEventQueue)
    /* 829AC0 80074EC0 0C023FD4 */  jal        osMotorInit_recomp
    /* 829AC4 80074EC4 02C03021 */   addu      $a2, $s6, $zero
    /* 829AC8 80074EC8 54400021 */  bnel       $v0, $zero, .L80074F50
    /* 829ACC 80074ECC 26B50068 */   addiu     $s5, $s5, 0x68
    /* 829AD0 80074ED0 3C078017 */  lui        $a3, %hi(D_8016EEF8)
    /* 829AD4 80074ED4 24E7EEF8 */  addiu      $a3, $a3, %lo(D_8016EEF8)
    /* 829AD8 80074ED8 02671021 */  addu       $v0, $s3, $a3
    /* 829ADC 80074EDC AE400000 */  sw         $zero, 0x0($s2)
    /* 829AE0 80074EE0 0801D3D3 */  j          .L80074F4C
    /* 829AE4 80074EE4 AC5E0000 */   sw        $fp, 0x0($v0)
  .L80074EE8:
    /* 829AE8 80074EE8 1060000D */  beqz       $v1, .L80074F20
    /* 829AEC 80074EEC 00000000 */   nop
    /* 829AF0 80074EF0 3C078017 */  lui        $a3, %hi(D_8016EEF8)
    /* 829AF4 80074EF4 24E7EEF8 */  addiu      $a3, $a3, %lo(D_8016EEF8)
    /* 829AF8 80074EF8 02678021 */  addu       $s0, $s3, $a3
    /* 829AFC 80074EFC 8E020000 */  lw         $v0, 0x0($s0)
    /* 829B00 80074F00 54400013 */  bnel       $v0, $zero, .L80074F50
    /* 829B04 80074F04 26B50068 */   addiu     $s5, $s5, 0x68
    /* 829B08 80074F08 0C023F1A */  jal        osMotorStart_recomp
    /* 829B0C 80074F0C 02A02021 */   addu      $a0, $s5, $zero
    /* 829B10 80074F10 54400001 */  bnel       $v0, $zero, .L80074F18
    /* 829B14 80074F14 AE5E0000 */   sw        $fp, 0x0($s2)
  .L80074F18:
    /* 829B18 80074F18 0801D3D3 */  j          .L80074F4C
    /* 829B1C 80074F1C AE1E0000 */   sw        $fp, 0x0($s0)
  .L80074F20:
    /* 829B20 80074F20 3C078017 */  lui        $a3, %hi(D_8016EEF8)
    /* 829B24 80074F24 24E7EEF8 */  addiu      $a3, $a3, %lo(D_8016EEF8)
    /* 829B28 80074F28 02678021 */  addu       $s0, $s3, $a3
    /* 829B2C 80074F2C 8E020000 */  lw         $v0, 0x0($s0)
    /* 829B30 80074F30 50400007 */  beql       $v0, $zero, .L80074F50
    /* 829B34 80074F34 26B50068 */   addiu     $s5, $s5, 0x68
    /* 829B38 80074F38 0C023EC0 */  jal        osMotorStop_recomp
    /* 829B3C 80074F3C 02A02021 */   addu      $a0, $s5, $zero
    /* 829B40 80074F40 54400002 */  bnel       $v0, $zero, .L80074F4C
    /* 829B44 80074F44 AE5E0000 */   sw        $fp, 0x0($s2)
    /* 829B48 80074F48 AE000000 */  sw         $zero, 0x0($s0)
  .L80074F4C:
    /* 829B4C 80074F4C 26B50068 */  addiu      $s5, $s5, 0x68
  .L80074F50:
    /* 829B50 80074F50 8FA70024 */  lw         $a3, 0x24($sp)
    /* 829B54 80074F54 26520004 */  addiu      $s2, $s2, 0x4
    /* 829B58 80074F58 26730004 */  addiu      $s3, $s3, 0x4
    /* 829B5C 80074F5C 24E70068 */  addiu      $a3, $a3, 0x68
    /* 829B60 80074F60 AFA70024 */  sw         $a3, 0x24($sp)
    /* 829B64 80074F64 8FA7002C */  lw         $a3, 0x2C($sp)
    /* 829B68 80074F68 26940004 */  addiu      $s4, $s4, 0x4
    /* 829B6C 80074F6C 26F70004 */  addiu      $s7, $s7, 0x4
    /* 829B70 80074F70 24E70004 */  addiu      $a3, $a3, 0x4
    /* 829B74 80074F74 AFA7002C */  sw         $a3, 0x2C($sp)
    /* 829B78 80074F78 8FA70034 */  lw         $a3, 0x34($sp)
    /* 829B7C 80074F7C 26D60001 */  addiu      $s6, $s6, 0x1
    /* 829B80 80074F80 2AC20004 */  slti       $v0, $s6, 0x4
    /* 829B84 80074F84 24E70004 */  addiu      $a3, $a3, 0x4
    /* 829B88 80074F88 1440FF57 */  bnez       $v0, .L80074CE8
    /* 829B8C 80074F8C AFA70034 */   sw        $a3, 0x34($sp)
    /* 829B90 80074F90 3C038009 */  lui        $v1, %hi(D_80097AA0)
    /* 829B94 80074F94 24637AA0 */  addiu      $v1, $v1, %lo(D_80097AA0)
    /* 829B98 80074F98 8C620000 */  lw         $v0, 0x0($v1)
    /* 829B9C 80074F9C 24420001 */  addiu      $v0, $v0, 0x1
    /* 829BA0 80074FA0 AC620000 */  sw         $v0, 0x0($v1)
    /* 829BA4 80074FA4 2842003D */  slti       $v0, $v0, 0x3D
    /* 829BA8 80074FA8 50400001 */  beql       $v0, $zero, .L80074FB0
    /* 829BAC 80074FAC AC600000 */   sw        $zero, 0x0($v1)
  .L80074FB0:
    /* 829BB0 80074FB0 3C058016 */  lui        $a1, %hi(D_8015E9A8)
    /* 829BB4 80074FB4 8CA5E9A8 */  lw         $a1, %lo(D_8015E9A8)($a1)
    /* 829BB8 80074FB8 3C028009 */  lui        $v0, %hi(D_80097AA4)
    /* 829BBC 80074FBC 8C427AA4 */  lw         $v0, %lo(D_80097AA4)($v0)
    /* 829BC0 80074FC0 3C068017 */  lui        $a2, %hi(D_80175D48)
    /* 829BC4 80074FC4 24C65D48 */  addiu      $a2, $a2, %lo(D_80175D48)
    /* 829BC8 80074FC8 3C018009 */  lui        $at, %hi(D_80097AA8)
    /* 829BCC 80074FCC AC227AA8 */  sw         $v0, %lo(D_80097AA8)($at)
    /* 829BD0 80074FD0 0C01FDF8 */  jal        osSetEventMesg_recomp
    /* 829BD4 80074FD4 24040005 */   addiu     $a0, $zero, 0x5
    /* 829BD8 80074FD8 8FBF005C */  lw         $ra, 0x5C($sp)
    /* 829BDC 80074FDC 8FBE0058 */  lw         $fp, 0x58($sp)
    /* 829BE0 80074FE0 8FB70054 */  lw         $s7, 0x54($sp)
    /* 829BE4 80074FE4 8FB60050 */  lw         $s6, 0x50($sp)
    /* 829BE8 80074FE8 8FB5004C */  lw         $s5, 0x4C($sp)
    /* 829BEC 80074FEC 8FB40048 */  lw         $s4, 0x48($sp)
    /* 829BF0 80074FF0 8FB30044 */  lw         $s3, 0x44($sp)
    /* 829BF4 80074FF4 8FB20040 */  lw         $s2, 0x40($sp)
    /* 829BF8 80074FF8 8FB1003C */  lw         $s1, 0x3C($sp)
    /* 829BFC 80074FFC 8FB00038 */  lw         $s0, 0x38($sp)
    /* 829C00 80075000 27BD0060 */  addiu      $sp, $sp, 0x60
    
    // @recomp: rumble init routine
    jal Hook_Rumble_Init
    nop
.size func_80074C44, . - func_80074C44

#if 0
glabel func_800721C0
    /* 826DC0 800721C0 27BDFFD0 */  addiu      $sp, $sp, -0x30
    /* 826DC4 800721C4 AFB30024 */  sw         $s3, 0x24($sp)
    /* 826DC8 800721C8 00809821 */  addu       $s3, $a0, $zero
    /* 826DCC 800721CC AFB1001C */  sw         $s1, 0x1C($sp)
    /* 826DD0 800721D0 3C118018 */  lui        $s1, %hi(D_80186028)
    /* 826DD4 800721D4 26316028 */  addiu      $s1, $s1, %lo(D_80186028)
    /* 826DD8 800721D8 02202021 */  addu       $a0, $s1, $zero
    /* 826DDC 800721DC 24050010 */  addiu      $a1, $zero, 0x10
    /* 826DE0 800721E0 AFBF002C */  sw         $ra, 0x2C($sp)
    /* 826DE4 800721E4 AFB40028 */  sw         $s4, 0x28($sp)
    /* 826DE8 800721E8 AFB20020 */  sw         $s2, 0x20($sp)
    /* 826DEC 800721EC 0C01F91C */  jal        osWritebackDCache_recomp
    /* 826DF0 800721F0 AFB00018 */   sw        $s0, 0x18($sp)
    /* 826DF4 800721F4 3C108017 */  lui        $s0, %hi(gSerialEventQueue)
    /* 826DF8 800721F8 26109CB0 */  addiu      $s0, $s0, %lo(gSerialEventQueue)
    /* 826DFC 800721FC 0C022904 */  jal        osContStartQuery_recomp
    /* 826E00 80072200 02002021 */   addu      $a0, $s0, $zero
    /* 826E04 80072204 02002021 */  addu       $a0, $s0, $zero
    /* 826E08 80072208 00002821 */  addu       $a1, $zero, $zero
    /* 826E0C 8007220C 0C01FD54 */  jal        osRecvMesg_recomp
    /* 826E10 80072210 24060001 */   addiu     $a2, $zero, 0x1
    /* 826E14 80072214 0C022925 */  jal        osContGetQuery_recomp
    /* 826E18 80072218 02202021 */   addu      $a0, $s1, $zero
    /* 826E1C 8007221C 02202021 */  addu       $a0, $s1, $zero
    /* 826E20 80072220 0C01F8B8 */  jal        osInvalDCache_recomp
    /* 826E24 80072224 24050010 */   addiu     $a1, $zero, 0x10
    /* 826E28 80072228 02002021 */  addu       $a0, $s0, $zero
    /* 826E2C 8007222C 0C0236A4 */  jal        osPfsIsPlug_recomp
    /* 826E30 80072230 27A50010 */   addiu     $a1, $sp, 0x10
    // /* 826E34 80072234 14400020 */  bnez       $v0, .L800722B8
    j .L800722B8
    /* 826E38 80072238 00000000 */   nop
    /* 826E3C 8007223C 00008021 */  addu       $s0, $zero, $zero
    /* 826E40 80072240 3C148017 */  lui        $s4, %hi(D_8016EEE8)
    /* 826E44 80072244 2694EEE8 */  addiu      $s4, $s4, %lo(D_8016EEE8)
    /* 826E48 80072248 02209021 */  addu       $s2, $s1, $zero
    /* 826E4C 8007224C 02608821 */  addu       $s1, $s3, $zero
  .L80072250:
    /* 826E50 80072250 93A20010 */  lbu        $v0, 0x10($sp)
    /* 826E54 80072254 02021007 */  srav       $v0, $v0, $s0
    /* 826E58 80072258 30420001 */  andi       $v0, $v0, 0x1
    /* 826E5C 8007225C 50400012 */  beql       $v0, $zero, .L800722A8
    /* 826E60 80072260 26520004 */   addiu     $s2, $s2, 0x4
    /* 826E64 80072264 8E220000 */  lw         $v0, 0x0($s1)
    /* 826E68 80072268 5040000F */  beql       $v0, $zero, .L800722A8
    /* 826E6C 8007226C 26520004 */   addiu     $s2, $s2, 0x4
    /* 826E70 80072270 92420002 */  lbu        $v0, 0x2($s2)
    /* 826E74 80072274 30420002 */  andi       $v0, $v0, 0x2
    /* 826E78 80072278 14400006 */  bnez       $v0, .L80072294
    /* 826E7C 8007227C 00101880 */   sll       $v1, $s0, 2
    /* 826E80 80072280 00741021 */  addu       $v0, $v1, $s4
    /* 826E84 80072284 8C420000 */  lw         $v0, 0x0($v0)
    /* 826E88 80072288 2C420002 */  sltiu      $v0, $v0, 0x2
    /* 826E8C 8007228C 50400006 */  beql       $v0, $zero, .L800722A8
    /* 826E90 80072290 26520004 */   addiu     $s2, $s2, 0x4
  .L80072294:
    /* 826E94 80072294 02602021 */  addu       $a0, $s3, $zero
    /* 826E98 80072298 02002821 */  addu       $a1, $s0, $zero
    /* 826E9C 8007229C 0C01C706 */  jal        func_80071C18
    /* 826EA0 800722A0 24060001 */   addiu     $a2, $zero, 0x1
    /* 826EA4 800722A4 26520004 */  addiu      $s2, $s2, 0x4
  .L800722A8:
    /* 826EA8 800722A8 26100001 */  addiu      $s0, $s0, 0x1
    /* 826EAC 800722AC 2A020004 */  slti       $v0, $s0, 0x4
    /* 826EB0 800722B0 1440FFE7 */  bnez       $v0, .L80072250
    /* 826EB4 800722B4 26310024 */   addiu     $s1, $s1, 0x24
  .L800722B8:
    /* 826EB8 800722B8 3C028017 */  lui        $v0, %hi(D_8016ED30)
    /* 826EBC 800722BC 8C42ED30 */  lw         $v0, %lo(D_8016ED30)($v0)
    /* 826EC0 800722C0 2442FFFF */  addiu      $v0, $v0, -0x1
    /* 826EC4 800722C4 3C018017 */  lui        $at, %hi(D_8016ED30)
    /* 826EC8 800722C8 AC22ED30 */  sw         $v0, %lo(D_8016ED30)($at)
    /* 826ECC 800722CC 8FBF002C */  lw         $ra, 0x2C($sp)
    /* 826ED0 800722D0 8FB40028 */  lw         $s4, 0x28($sp)
    /* 826ED4 800722D4 8FB30024 */  lw         $s3, 0x24($sp)
    /* 826ED8 800722D8 8FB20020 */  lw         $s2, 0x20($sp)
    /* 826EDC 800722DC 8FB1001C */  lw         $s1, 0x1C($sp)
    /* 826EE0 800722E0 8FB00018 */  lw         $s0, 0x18($sp)
    /* 826EE4 800722E4 27BD0030 */  addiu      $sp, $sp, 0x30
    /* 826EE8 800722E8 03E00008 */  jr         $ra
    /* 826EEC 800722EC 00000000 */   nop
.size func_800721C0, . - func_800721C0
#endif

#endif
