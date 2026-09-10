.include "macro.inc"
#include "macro_float_reg.h"

/* assembler directives */
.set noat      /* allow manual use of $at */
.set noreorder /* don't insert nops after branches */

.section .recomp_patch, "ax"

// HUD Draw function for 1P
glabel HUD_Draw
    jal EG_gEXEnable
    nop
    jal EG_gEXSetScissor
    nop
    /* 874AA0 800BFEA0 3C038017 */  lui        $v1, %hi(gGameMode)
    /* 874AA4 800BFEA4 8C6387A4 */  lw         $v1, %lo(gGameMode)($v1)
    /* 874AA8 800BFEA8 27BDFF90 */  addiu      $sp, $sp, -0x70
    /* 874AAC 800BFEAC AFB30044 */  sw         $s3, 0x44($sp)
    /* 874AB0 800BFEB0 00809821 */  addu       $s3, $a0, $zero
    /* 874AB4 800BFEB4 AFB20040 */  sw         $s2, 0x40($sp)
    /* 874AB8 800BFEB8 00A09021 */  addu       $s2, $a1, $zero
    /* 874ABC 800BFEBC AFB70054 */  sw         $s7, 0x54($sp)
    /* 874AC0 800BFEC0 F7B60068 */  sdc1       $fs1, 0x68($sp)
    /* 874AC4 800BFEC4 4487B000 */  mtc1       $a3, $fs1
    /* 874AC8 800BFEC8 2402000C */  addiu      $v0, $zero, 0xC
    /* 874ACC 800BFECC AFBF0058 */  sw         $ra, 0x58($sp)
    /* 874AD0 800BFED0 AFB60050 */  sw         $s6, 0x50($sp)
    /* 874AD4 800BFED4 AFB5004C */  sw         $s5, 0x4C($sp)
    /* 874AD8 800BFED8 AFB40048 */  sw         $s4, 0x48($sp)
    /* 874ADC 800BFEDC AFB1003C */  sw         $s1, 0x3C($sp)
    /* 874AE0 800BFEE0 AFB00038 */  sw         $s0, 0x38($sp)
    /* 874AE4 800BFEE4 F7B40060 */  sdc1       $fs0, 0x60($sp)
    /* 874AE8 800BFEE8 106201F0 */  beq        $v1, $v0, .L800C06AC
    /* 874AEC 800BFEEC 00C0B821 */   addu      $s7, $a2, $zero
    /* 874AF0 800BFEF0 8E6306F8 */  lw         $v1, 0x6F8($s3)
    /* 874AF4 800BFEF4 24020004 */  addiu      $v0, $zero, 0x4
    /* 874AF8 800BFEF8 106201EC */  beq        $v1, $v0, .L800C06AC
    /* 874AFC 800BFEFC 3C0BFF10 */   lui       $t3, (0xFF10013F >> 16)
    /* 874B00 800BFF00 356B013F */  ori        $t3, $t3, (0xFF10013F & 0xFFFF)
    /* 874B04 800BFF04 3C07B900 */  lui        $a3, (0xB900031D >> 16)
    /* 874B08 800BFF08 34E7031D */  ori        $a3, $a3, (0xB900031D & 0xFFFF)
    /* 874B0C 800BFF0C 3C040F0A */  lui        $a0, (0xF0A4000 >> 16)
    /* 874B10 800BFF10 34844000 */  ori        $a0, $a0, (0xF0A4000 & 0xFFFF)
    /* 874B14 800BFF14 3C0ABA00 */  lui        $t2, (0xBA001402 >> 16)
    /* 874B18 800BFF18 354A1402 */  ori        $t2, $t2, (0xBA001402 & 0xFFFF)
    /* 874B1C 800BFF1C 3C08FFFC */  lui        $t0, (0xFFFCFFFC >> 16)
    /* 874B20 800BFF20 3C068017 */  lui        $a2, %hi(gMasterDisp)
    /* 874B24 800BFF24 24C689EC */  addiu      $a2, $a2, %lo(gMasterDisp)
    /* 874B28 800BFF28 8CC50000 */  lw         $a1, 0x0($a2)
    /* 874B2C 800BFF2C 3C038017 */  lui        $v1, %hi(D_80175FD4)
    /* 874B30 800BFF30 8C635FD4 */  lw         $v1, %lo(D_80175FD4)($v1)
    /* 874B34 800BFF34 3508FFFC */  ori        $t0, $t0, (0xFFFCFFFC & 0xFFFF)
    /* 874B38 800BFF38 3C09E700 */  lui        $t1, (0xE7000000 >> 16)
    /* 874B3C 800BFF3C 24A20008 */  addiu      $v0, $a1, 0x8
    /* 874B40 800BFF40 ACC20000 */  sw         $v0, 0x0($a2)
    /* 874B44 800BFF44 24A20010 */  addiu      $v0, $a1, 0x10
    /* 874B48 800BFF48 ACA90000 */  sw         $t1, 0x0($a1)
    /* 874B4C 800BFF4C ACA00004 */  sw         $zero, 0x4($a1)
    /* 874B50 800BFF50 ACC20000 */  sw         $v0, 0x0($a2)
    /* 874B54 800BFF54 24A20018 */  addiu      $v0, $a1, 0x18
    /* 874B58 800BFF58 ACAB0008 */  sw         $t3, 0x8($a1)
    /* 874B5C 800BFF5C ACA3000C */  sw         $v1, 0xC($a1)
    /* 874B60 800BFF60 ACC20000 */  sw         $v0, 0x0($a2)
    /* 874B64 800BFF64 24A20020 */  addiu      $v0, $a1, 0x20
    /* 874B68 800BFF68 ACA70010 */  sw         $a3, 0x10($a1)
    /* 874B6C 800BFF6C ACA40014 */  sw         $a0, 0x14($a1)
    /* 874B70 800BFF70 ACC20000 */  sw         $v0, 0x0($a2)
    /* 874B74 800BFF74 3C020030 */  lui        $v0, (0x300000 >> 16)
    /* 874B78 800BFF78 ACA2001C */  sw         $v0, 0x1C($a1)
    /* 874B7C 800BFF7C 24A20028 */  addiu      $v0, $a1, 0x28
    /* 874B80 800BFF80 ACAA0018 */  sw         $t2, 0x18($a1)
    /* 874B84 800BFF84 ACC20000 */  sw         $v0, 0x0($a2)
    /* 874B88 800BFF88 3C02F700 */  lui        $v0, (0xF7000000 >> 16)
    /* 874B8C 800BFF8C ACA20020 */  sw         $v0, 0x20($a1)
    /* 874B90 800BFF90 24A20030 */  addiu      $v0, $a1, 0x30
    /* 874B94 800BFF94 ACA80024 */  sw         $t0, 0x24($a1)
    /* 874B98 800BFF98 ACC20000 */  sw         $v0, 0x0($a2)
    /* 874B9C 800BFF9C 8E430008 */  lw         $v1, 0x8($s2)
    /* 874BA0 800BFFA0 8E42000C */  lw         $v0, 0xC($s2)
    /* 874BA4 800BFFA4 3C04F600 */  lui        $a0, (0xF6000000 >> 16)
    /* 874BA8 800BFFA8 2463FFFF */  addiu      $v1, $v1, -0x1
    /* 874BAC 800BFFAC 306303FF */  andi       $v1, $v1, 0x3FF
    /* 874BB0 800BFFB0 00031B80 */  sll        $v1, $v1, 14
    /* 874BB4 800BFFB4 2442FFFF */  addiu      $v0, $v0, -0x1
    /* 874BB8 800BFFB8 304203FF */  andi       $v0, $v0, 0x3FF
    /* 874BBC 800BFFBC 00021080 */  sll        $v0, $v0, 2
    /* 874BC0 800BFFC0 00441025 */  or         $v0, $v0, $a0
    /* 874BC4 800BFFC4 00621825 */  or         $v1, $v1, $v0
    /* 874BC8 800BFFC8 ACA30028 */  sw         $v1, 0x28($a1)
    /* 874BCC 800BFFCC 8E420000 */  lw         $v0, 0x0($s2)
    /* 874BD0 800BFFD0 8E430004 */  lw         $v1, 0x4($s2)
    /* 874BD4 800BFFD4 3C048016 */  lui        $a0, %hi(D_80162EF0)
    /* 874BD8 800BFFD8 8C842EF0 */  lw         $a0, %lo(D_80162EF0)($a0)
    /* 874BDC 800BFFDC 304203FF */  andi       $v0, $v0, 0x3FF
    /* 874BE0 800BFFE0 00021380 */  sll        $v0, $v0, 14
    /* 874BE4 800BFFE4 306303FF */  andi       $v1, $v1, 0x3FF
    /* 874BE8 800BFFE8 00031880 */  sll        $v1, $v1, 2
    /* 874BEC 800BFFEC 00431025 */  or         $v0, $v0, $v1
    /* 874BF0 800BFFF0 ACA2002C */  sw         $v0, 0x2C($a1)
    /* 874BF4 800BFFF4 24A20038 */  addiu      $v0, $a1, 0x38
    /* 874BF8 800BFFF8 ACC20000 */  sw         $v0, 0x0($a2)
    /* 874BFC 800BFFFC 24A20040 */  addiu      $v0, $a1, 0x40
    /* 874C00 800C0000 ACA90030 */  sw         $t1, 0x30($a1)
    /* 874C04 800C0004 ACA00034 */  sw         $zero, 0x34($a1)
    /* 874C08 800C0008 ACC20000 */  sw         $v0, 0x0($a2)
    /* 874C0C 800C000C 24A20048 */  addiu      $v0, $a1, 0x48
    /* 874C10 800C0010 3C038011 */  lui        $v1, %hi(D_80109670)
    /* 874C14 800C0014 24639670 */  addiu      $v1, $v1, %lo(D_80109670)
    /* 874C18 800C0018 ACAB0038 */  sw         $t3, 0x38($a1)
    /* 874C1C 800C001C ACA4003C */  sw         $a0, 0x3C($a1)
    /* 874C20 800C0020 ACC20000 */  sw         $v0, 0x0($a2)
    /* 874C24 800C0024 ACAA0040 */  sw         $t2, 0x40($a1)
    /* 874C28 800C0028 ACA00044 */  sw         $zero, 0x44($a1)
    /* 874C2C 800C002C 8C620000 */  lw         $v0, 0x0($v1)
    /* 874C30 800C0030 24420001 */  addiu      $v0, $v0, 0x1
    /* 874C34 800C0034 AC620000 */  sw         $v0, 0x0($v1)
    /* 874C38 800C0038 C66406B8 */  lwc1       $ft0, 0x6B8($s3)
    /* 874C3C 800C003C 44800000 */  mtc1       $zero, $fv0
    /* 874C40 800C0040 46002032 */  c.eq.s     $ft0, $fv0
    /* 874C44 800C0044 00000000 */  nop
    /* 874C48 800C0048 4501002B */  bc1t       .L800C00F8
    /* 874C4C 800C004C 0000A021 */   addu      $s4, $zero, $zero
    /* 874C50 800C0050 3C01800A */  lui        $at, %hi(D_8009CAC0)
    /* 874C54 800C0054 D422CAC0 */  ldc1       $fv1, %lo(D_8009CAC0)($at)
    /* 874C58 800C0058 46002021 */  cvt.d.s    $fv0, $ft0
    /* 874C5C 800C005C 46220002 */  mul.d      $fv0, $fv0, $fv1
    /* 874C60 800C0060 3C01800A */  lui        $at, %hi(D_8009CAC8)
    /* 874C64 800C0064 D422CAC8 */  ldc1       $fv1, %lo(D_8009CAC8)($at)
    /* 874C68 800C0068 46200520 */  cvt.s.d    $fs0, $fv0
    /* 874C6C 800C006C 4600A021 */  cvt.d.s    $fv0, $fs0
    /* 874C70 800C0070 4622003C */  c.lt.d     $fv0, $fv1
    /* 874C74 800C0074 00000000 */  nop
    /* 874C78 800C0078 45000003 */  bc1f       .L800C0088
    /* 874C7C 800C007C 00000000 */   nop
    /* 874C80 800C0080 3C01800A */  lui        $at, %hi(D_8009CAD0)
    /* 874C84 800C0084 C434CAD0 */  lwc1       $fs0, %lo(D_8009CAD0)($at)
  .L800C0088:
    /* 874C88 800C0088 4600A00D */  trunc.w.s  $fv0, $fs0
    /* 874C8C 800C008C 44100000 */  mfc1       $s0, $fv0
    /* 874C90 800C0090 00108400 */  sll        $s0, $s0, 16
    /* 874C94 800C0094 00108403 */  sra        $s0, $s0, 16
    /* 874C98 800C0098 0C015AA7 */  jal        func_80056A9C
    /* 874C9C 800C009C 02002021 */   addu      $a0, $s0, $zero
    /* 874CA0 800C00A0 3C01800A */  lui        $at, %hi(D_8009CAD8)
    /* 874CA4 800C00A4 D420CAD8 */  ldc1       $fv0, %lo(D_8009CAD8)($at)
    /* 874CA8 800C00A8 4600A521 */  cvt.d.s    $fs0, $fs0
    /* 874CAC 800C00AC 4620A502 */  mul.d      $fs0, $fs0, $fv0
    /* 874CB0 800C00B0 00021400 */  sll        $v0, $v0, 16
    /* 874CB4 800C00B4 00021403 */  sra        $v0, $v0, 16
    /* 874CB8 800C00B8 44820000 */  mtc1       $v0, $fv0
    /* 874CBC 800C00BC 46800021 */  cvt.d.w    $fv0, $fv0
    /* 874CC0 800C00C0 46340001 */  sub.d      $fv0, $fv0, $fs0
    /* 874CC4 800C00C4 4620008D */  trunc.w.d  $fv1, $fv0
    /* 874CC8 800C00C8 44151000 */  mfc1       $s5, $fv1
    /* 874CCC 800C00CC 0C015AA7 */  jal        func_80056A9C
    /* 874CD0 800C00D0 02002021 */   addu      $a0, $s0, $zero
    /* 874CD4 800C00D4 00021400 */  sll        $v0, $v0, 16
    /* 874CD8 800C00D8 00021403 */  sra        $v0, $v0, 16
    /* 874CDC 800C00DC 44820000 */  mtc1       $v0, $fv0
    /* 874CE0 800C00E0 46800021 */  cvt.d.w    $fv0, $fv0
    /* 874CE4 800C00E4 46340001 */  sub.d      $fv0, $fv0, $fs0
    /* 874CE8 800C00E8 4620008D */  trunc.w.d  $fv1, $fv0
    /* 874CEC 800C00EC 44141000 */  mfc1       $s4, $fv1
    /* 874CF0 800C00F0 0803003F */  j          .L800C00FC
    /* 874CF4 800C00F4 00000000 */   nop
  .L800C00F8:
    /* 874CF8 800C00F8 0000A821 */  addu       $s5, $zero, $zero
  .L800C00FC:
    /* 874CFC 800C00FC 3C064270 */  lui        $a2, (0x42700000 >> 16)
    /* 874D00 800C0100 3C108017 */  lui        $s0, %hi(gMasterDisp)
    /* 874D04 800C0104 261089EC */  addiu      $s0, $s0, %lo(gMasterDisp)
    /* 874D08 800C0108 8E030000 */  lw         $v1, 0x0($s0)
    /* 874D0C 800C010C 3C01800A */  lui        $at, %hi(D_8009CAE0)
    /* 874D10 800C0110 C420CAE0 */  lwc1       $fv0, %lo(D_8009CAE0)($at)
    /* 874D14 800C0114 24620008 */  addiu      $v0, $v1, 0x8
    /* 874D18 800C0118 AE020000 */  sw         $v0, 0x0($s0)
    /* 874D1C 800C011C 3C020600 */  lui        $v0, (0x6000000 >> 16)
    /* 874D20 800C0120 AC620000 */  sw         $v0, 0x0($v1)
    /* 874D24 800C0124 3C028011 */  lui        $v0, %hi(D_80109158)
    /* 874D28 800C0128 24429158 */  addiu      $v0, $v0, %lo(D_80109158)
    /* 874D2C 800C012C AC620004 */  sw         $v0, 0x4($v1)
    /* 874D30 800C0130 E7A00010 */  swc1       $fv0, 0x10($sp)
    /* 874D34 800C0134 C6E000B0 */  lwc1       $fv0, 0xB0($s7)
    /* 874D38 800C0138 46800020 */  cvt.s.w    $fv0, $fv0
    /* 874D3C 800C013C 46160002 */  mul.s      $fv0, $fv0, $fs1
    /* 874D40 800C0140 3C073FAA */  lui        $a3, (0x3FAAAAAB >> 16)
    /* 874D44 800C0144 34E7AAAB */  ori        $a3, $a3, (0x3FAAAAAB & 0xFFFF)
    /* 874D48 800C0148 3C118018 */  lui        $s1, %hi(D_8017A7B0)
    /* 874D4C 800C014C 2631A7B0 */  addiu      $s1, $s1, %lo(D_8017A7B0)
    /* 874D50 800C0150 3C01800A */  lui        $at, %hi(D_8009CAE4)
    /* 874D54 800C0154 C422CAE4 */  lwc1       $fv1, %lo(D_8009CAE4)($at)
    /* 874D58 800C0158 02202021 */  addu       $a0, $s1, $zero
    /* 874D5C 800C015C 27A50030 */  addiu      $a1, $sp, 0x30
    /* 874D60 800C0160 E7A20018 */  swc1       $fv1, 0x18($sp)
    /* 874D64 800C0164 0C01F658 */  jal        guPerspective
    /* 874D68 800C0168 E7A00014 */   swc1      $fv0, 0x14($sp)
    /* 874D6C 800C016C 3C01800A */  lui        $at, %hi(D_8009CAE8)
    /* 874D70 800C0170 C420CAE8 */  lwc1       $fv0, %lo(D_8009CAE8)($at)
    /* 874D74 800C0174 44050000 */  mfc1       $a1, $fv0
    /* 874D78 800C0178 3C048018 */  lui        $a0, %hi(D_8017A770)
    /* 874D7C 800C017C 2484A770 */  addiu      $a0, $a0, %lo(D_8017A770)
    /* 874D80 800C0180 00A03021 */  addu       $a2, $a1, $zero
    /* 874D84 800C0184 0C01F769 */  jal        guScale
    /* 874D88 800C0188 00A03821 */   addu      $a3, $a1, $zero
    /* 874D8C 800C018C 8E030000 */  lw         $v1, 0x0($s0)
    /* 874D90 800C0190 3C040103 */  lui        $a0, (0x1030040 >> 16)
    /* 874D94 800C0194 34840040 */  ori        $a0, $a0, (0x1030040 & 0xFFFF)
    /* 874D98 800C0198 24620008 */  addiu      $v0, $v1, 0x8
    /* 874D9C 800C019C AE020000 */  sw         $v0, 0x0($s0)
    /* 874DA0 800C01A0 AC640000 */  sw         $a0, 0x0($v1)
    /* 874DA4 800C01A4 AC710004 */  sw         $s1, 0x4($v1)

    jal EG_RectAlign_Origin_Left_Left
    nop
    jal EG_gEXViewportOrigin_Left
    nop
    
    /* 874DA8 800C01A8 3C028017 */  lui        $v0, %hi(gGameMode)
    /* 874DAC 800C01AC 8C4287A4 */  lw         $v0, %lo(gGameMode)($v0)
    /* 874DB0 800C01B0 2442FFFF */  addiu      $v0, $v0, -0x1
    /* 874DB4 800C01B4 2C420002 */  sltiu      $v0, $v0, 0x2
    /* 874DB8 800C01B8 10400006 */  beqz       $v0, .L800C01D4
    /* 874DBC 800C01BC 02602021 */   addu      $a0, $s3, $zero
    /* 874DC0 800C01C0 8E420000 */  lw         $v0, 0x0($s2)
    /* 874DC4 800C01C4 26A5001C */  addiu      $a1, $s5, 0x1C
    /* 874DC8 800C01C8 8E430004 */  lw         $v1, 0x4($s2)
    /* 874DCC 800C01CC 08030079 */  j          .L800C01E4
    /* 874DD0 800C01D0 26860012 */   addiu     $a2, $s4, 0x12
  .L800C01D4:
    /* 874DD4 800C01D4 8E420000 */  lw         $v0, 0x0($s2)
    /* 874DD8 800C01D8 26A5001C */  addiu      $a1, $s5, 0x1C
    /* 874DDC 800C01DC 8E430004 */  lw         $v1, 0x4($s2)
    /* 874DE0 800C01E0 26860025 */  addiu      $a2, $s4, 0x25
  .L800C01E4:


    /* 874DE4 800C01E4 00452821 */  addu       $a1, $v0, $a1
    /* 874DE8 800C01E8 0C02E93E */  jal        HUD_Turbo_Draw
    /* 874DEC 800C01EC 00663021 */   addu      $a2, $v1, $a2

    jal EG_RectAlign_Origin_None_None
    nop
    jal EG_gEXViewportOrigin_None
    nop

    /* 874DF0 800C01F0 8E630460 */  lw         $v1, 0x460($s3)
    /* 874DF4 800C01F4 24020001 */  addiu      $v0, $zero, 0x1
    /* 874DF8 800C01F8 14620009 */  bne        $v1, $v0, .L800C0220
    /* 874DFC 800C01FC 02602021 */   addu      $a0, $s3, $zero
    /* 874E00 800C0200 3C073E80 */  lui        $a3, (0x3E800000 >> 16)
    /* 874E04 800C0204 8E420000 */  lw         $v0, 0x0($s2)
    /* 874E08 800C0208 26A5010C */  addiu      $a1, $s5, 0x10C
    /* 874E0C 800C020C 8E430004 */  lw         $v1, 0x4($s2)
    /* 874E10 800C0210 26860078 */  addiu      $a2, $s4, 0x78
    /* 874E14 800C0214 00452821 */  addu       $a1, $v0, $a1
    /* 874E18 800C0218 0C02EA78 */  jal        func_800BA9E0
    /* 874E1C 800C021C 00663021 */   addu      $a2, $v1, $a2
  .L800C0220:
    /* 874E20 800C0220 3C028017 */  lui        $v0, %hi(D_801771B8)
    /* 874E24 800C0224 8C4271B8 */  lw         $v0, %lo(D_801771B8)($v0)
    /* 874E28 800C0228 1440001A */  bnez       $v0, .L800C0294
    /* 874E2C 800C022C 00000000 */   nop
    /* 874E30 800C0230 3C038017 */  lui        $v1, %hi(gGameMode)
    /* 874E34 800C0234 8C6387A4 */  lw         $v1, %lo(gGameMode)($v1)
    /* 874E38 800C0238 2C620002 */  sltiu      $v0, $v1, 0x2
    /* 874E3C 800C023C 1440000A */  bnez       $v0, .L800C0268
    /* 874E40 800C0240 02E02021 */   addu      $a0, $s7, $zero
    /* 874E44 800C0244 2462FFFD */  addiu      $v0, $v1, -0x3
    /* 874E48 800C0248 2C420002 */  sltiu      $v0, $v0, 0x2
    /* 874E4C 800C024C 14400006 */  bnez       $v0, .L800C0268
    /* 874E50 800C0250 2462FFFA */   addiu     $v0, $v1, -0x6
    /* 874E54 800C0254 2C420002 */  sltiu      $v0, $v0, 0x2
    /* 874E58 800C0258 14400003 */  bnez       $v0, .L800C0268
    /* 874E5C 800C025C 24020009 */   addiu     $v0, $zero, 0x9
    /* 874E60 800C0260 1462000C */  bne        $v1, $v0, .L800C0294
    /* 874E64 800C0264 00000000 */   nop
  .L800C0268:
    /* 874E68 800C0268 8E420000 */  lw         $v0, 0x0($s2)
    /* 874E6C 800C026C 26A60034 */  addiu      $a2, $s5, 0x34
    /* 874E70 800C0270 3C01800A */  lui        $at, %hi(D_8009CAEC)
    /* 874E74 800C0274 C420CAEC */  lwc1       $fv0, %lo(D_8009CAEC)($at)
    /* 874E78 800C0278 00463021 */  addu       $a2, $v0, $a2
    /* 874E7C 800C027C 8E420004 */  lw         $v0, 0x4($s2)
    /* 874E80 800C0280 02602821 */  addu       $a1, $s3, $zero
    /* 874E84 800C0284 26870078 */  addiu      $a3, $s4, 0x78
    /* 874E88 800C0288 E7A00010 */  swc1       $fv0, 0x10($sp)
    /* 874E8C 800C028C 0C02EB58 */  jal        func_800BAD60
    /* 874E90 800C0290 00473821 */   addu      $a3, $v0, $a3
  .L800C0294:
    /* 874E94 800C0294 3C028017 */  lui        $v0, %hi(gGameMode)
    /* 874E98 800C0298 8C4287A4 */  lw         $v0, %lo(gGameMode)($v0)
    /* 874E9C 800C029C 2442FFFF */  addiu      $v0, $v0, -0x1
    /* 874EA0 800C02A0 2C420002 */  sltiu      $v0, $v0, 0x2
    /* 874EA4 800C02A4 1440000C */  bnez       $v0, .L800C02D8
    /* 874EA8 800C02A8 00000000 */   nop
    /* 874EAC 800C02AC 3C028017 */  lui        $v0, %hi(D_801771B8)
    /* 874EB0 800C02B0 8C4271B8 */  lw         $v0, %lo(D_801771B8)($v0)
    /* 874EB4 800C02B4 14400008 */  bnez       $v0, .L800C02D8
    /* 874EB8 800C02B8 02602021 */   addu      $a0, $s3, $zero
    /* 874EBC 800C02BC 02402821 */  addu       $a1, $s2, $zero
    /* 874EC0 800C02C0 02E03021 */  addu       $a2, $s7, $zero
    /* 874EC4 800C02C4 26A700A0 */  addiu      $a3, $s5, 0xA0
    /* 874EC8 800C02C8 2682001E */  addiu      $v0, $s4, 0x1E
    /* 874ECC 800C02CC AFA20010 */  sw         $v0, 0x10($sp)
    /* 874ED0 800C02D0 0C02FAD0 */  jal        HUD_RacerTracker_Draw
    /* 874ED4 800C02D4 AFA00014 */   sw        $zero, 0x14($sp)
  .L800C02D8:
    /* 874ED8 800C02D8 3C028017 */  lui        $v0, %hi(gGameMode)
    /* 874EDC 800C02DC 8C4287A4 */  lw         $v0, %lo(gGameMode)($v0)
    /* 874EE0 800C02E0 38430002 */  xori       $v1, $v0, 0x2
    /* 874EE4 800C02E4 2C630001 */  sltiu      $v1, $v1, 0x1
    /* 874EE8 800C02E8 38420004 */  xori       $v0, $v0, 0x4
    /* 874EEC 800C02EC 2C420001 */  sltiu      $v0, $v0, 0x1
    /* 874EF0 800C02F0 00621825 */  or         $v1, $v1, $v0
    /* 874EF4 800C02F4 1060000A */  beqz       $v1, .L800C0320
    /* 874EF8 800C02F8 02602021 */   addu      $a0, $s3, $zero
    /* 874EFC 800C02FC 8E420000 */  lw         $v0, 0x0($s2)
    /* 874F00 800C0300 26A500EE */  addiu      $a1, $s5, 0xEE
    /* 874F04 800C0304 8E430004 */  lw         $v1, 0x4($s2)
    /* 874F08 800C0308 26860012 */  addiu      $a2, $s4, 0x12
    /* 874F0C 800C030C 00452821 */  addu       $a1, $v0, $a1
    /* 874F10 800C0310 0C02ECC4 */  jal        func_800BB310
    /* 874F14 800C0314 00663021 */   addu      $a2, $v1, $a2
    /* 874F18 800C0318 080300CF */  j          .L800C033C
    /* 874F1C 800C031C 00000000 */   nop
  .L800C0320:

    jal EG_RectAlign_Origin_Right_Right
    nop

    /* 874F20 800C0320 8E420000 */  lw         $v0, 0x0($s2)
    /* 874F24 800C0324 26A500EE */  addiu      $a1, $s5, 0xEE
    /* 874F28 800C0328 8E430004 */  lw         $v1, 0x4($s2)
    /* 874F2C 800C032C 26860012 */  addiu      $a2, $s4, 0x12
    /* 874F30 800C0330 00452821 */  addu       $a1, $v0, $a1
    /* 874F34 800C0334 0C02ED1F */  jal        HUD_Timer_Draw
    /* 874F38 800C0338 00663021 */   addu      $a2, $v1, $a2

    jal EG_RectAlign_Origin_None_None
    nop

  .L800C033C:
    /* 874F3C 800C033C 8E420000 */  lw         $v0, 0x0($s2)
    /* 874F40 800C0340 02A22821 */  addu       $a1, $s5, $v0
    /* 874F44 800C0344 8E420004 */  lw         $v0, 0x4($s2)
    /* 874F48 800C0348 3C038017 */  lui        $v1, %hi(D_801771B8)
    /* 874F4C 800C034C 8C6371B8 */  lw         $v1, %lo(D_801771B8)($v1)
    /* 874F50 800C0350 24A500F4 */  addiu      $a1, $a1, 0xF4
    /* 874F54 800C0354 02823021 */  addu       $a2, $s4, $v0
    /* 874F58 800C0358 14600020 */  bnez       $v1, .L800C03DC
    /* 874F5C 800C035C 24C60022 */   addiu     $a2, $a2, 0x22
    /* 874F60 800C0360 3C028017 */  lui        $v0, %hi(gMasterDisp)
    /* 874F64 800C0364 8C4289EC */  lw         $v0, %lo(gMasterDisp)($v0)
    /* 874F68 800C0368 3C030600 */  lui        $v1, (0x6000000 >> 16)
    /* 874F6C 800C036C AC430000 */  sw         $v1, 0x0($v0)
    /* 874F70 800C0370 3C038011 */  lui        $v1, %hi(D_80109550)
    /* 874F74 800C0374 24639550 */  addiu      $v1, $v1, %lo(D_80109550)
    /* 874F78 800C0378 AC430004 */  sw         $v1, 0x4($v0)
    /* 874F7C 800C037C 3C03FA00 */  lui        $v1, (0xFA000000 >> 16)
    /* 874F80 800C0380 AC430008 */  sw         $v1, 0x8($v0)
    /* 874F84 800C0384 2403FFFF */  addiu      $v1, $zero, -0x1
    /* 874F88 800C0388 AC43000C */  sw         $v1, 0xC($v0)
    /* 874F8C 800C038C 866405E0 */  lh         $a0, 0x5E0($s3)
    /* 874F90 800C0390 24430008 */  addiu      $v1, $v0, 0x8
    /* 874F94 800C0394 3C018017 */  lui        $at, %hi(gMasterDisp)
    /* 874F98 800C0398 AC2389EC */  sw         $v1, %lo(gMasterDisp)($at)
    /* 874F9C 800C039C 3C038009 */  lui        $v1, %hi(D_80095678)
    /* 874FA0 800C03A0 8C635678 */  lw         $v1, %lo(D_80095678)($v1)
    /* 874FA4 800C03A4 24420010 */  addiu      $v0, $v0, 0x10
    /* 874FA8 800C03A8 3C018017 */  lui        $at, %hi(gMasterDisp)
    /* 874FAC 800C03AC AC2289EC */  sw         $v0, %lo(gMasterDisp)($at)
    /* 874FB0 800C03B0 0004102B */  sltu       $v0, $zero, $a0
    /* 874FB4 800C03B4 00822023 */  subu       $a0, $a0, $v0
    /* 874FB8 800C03B8 0083102A */  slt        $v0, $a0, $v1
    /* 874FBC 800C03BC 50400001 */  beql       $v0, $zero, .L800C03C4
    /* 874FC0 800C03C0 2464FFFF */   addiu     $a0, $v1, -0x1
  .L800C03C4:

    jal EG_RectAlign_Origin_Right_Right
    nop

    /* 874FC4 800C03C4 3C028017 */  lui        $v0, %hi(D_80169CAC)
    /* 874FC8 800C03C8 8C429CAC */  lw         $v0, %lo(D_80169CAC)($v0)
    /* 874FCC 800C03CC 00042100 */  sll        $a0, $a0, 4
    /* 874FD0 800C03D0 24840020 */  addiu      $a0, $a0, 0x20
    /* 874FD4 800C03D4 0C02E66C */  jal        func_DRAW_800B99B0
    /* 874FD8 800C03D8 00442021 */   addu      $a0, $v0, $a0

    jal EG_RectAlign_Origin_None_None
    nop

  .L800C03DC:
    /* 874FDC 800C03DC 8E420000 */  lw         $v0, 0x0($s2)
    /* 874FE0 800C03E0 8E430004 */  lw         $v1, 0x4($s2)
    /* 874FE4 800C03E4 02A2B021 */  addu       $s6, $s5, $v0
    /* 874FE8 800C03E8 26D6001C */  addiu      $s6, $s6, 0x1C
    /* 874FEC 800C03EC 3C028017 */  lui        $v0, %hi(gGameMode)
    /* 874FF0 800C03F0 8C4287A4 */  lw         $v0, %lo(gGameMode)($v0)
    /* 874FF4 800C03F4 02838821 */  addu       $s1, $s4, $v1
    /* 874FF8 800C03F8 2442FFFF */  addiu      $v0, $v0, -0x1
    /* 874FFC 800C03FC 2C420002 */  sltiu      $v0, $v0, 0x2
    /* 875000 800C0400 1440003A */  bnez       $v0, .L800C04EC
    /* 875004 800C0404 26310012 */   addiu     $s1, $s1, 0x12
    /* 875008 800C0408 3C028017 */  lui        $v0, %hi(D_801771B8)
    /* 87500C 800C040C 8C4271B8 */  lw         $v0, %lo(D_801771B8)($v0)
    /* 875010 800C0410 14400037 */  bnez       $v0, .L800C04F0
    /* 875014 800C0414 02602021 */   addu      $a0, $s3, $zero
    /* 875018 800C0418 3C028017 */  lui        $v0, %hi(gMasterDisp)
    /* 87501C 800C041C 8C4289EC */  lw         $v0, %lo(gMasterDisp)($v0)
    /* 875020 800C0420 3C030600 */  lui        $v1, (0x6000000 >> 16)
    /* 875024 800C0424 AC430000 */  sw         $v1, 0x0($v0)
    /* 875028 800C0428 3C038011 */  lui        $v1, %hi(D_80109550)
    /* 87502C 800C042C 24639550 */  addiu      $v1, $v1, %lo(D_80109550)
    /* 875030 800C0430 AC430004 */  sw         $v1, 0x4($v0)
    /* 875034 800C0434 3C03FA00 */  lui        $v1, (0xFA000000 >> 16)
    /* 875038 800C0438 AC430008 */  sw         $v1, 0x8($v0)
    /* 87503C 800C043C 2403FFFF */  addiu      $v1, $zero, -0x1
    /* 875040 800C0440 AC43000C */  sw         $v1, 0xC($v0)
    /* 875044 800C0444 8E640604 */  lw         $a0, 0x604($s3)
    /* 875048 800C0448 24430008 */  addiu      $v1, $v0, 0x8
    /* 87504C 800C044C 24420010 */  addiu      $v0, $v0, 0x10
    /* 875050 800C0450 3C018017 */  lui        $at, %hi(gMasterDisp)
    /* 875054 800C0454 AC2389EC */  sw         $v1, %lo(gMasterDisp)($at)
    /* 875058 800C0458 3C018017 */  lui        $at, %hi(gMasterDisp)
    /* 87505C 800C045C AC2289EC */  sw         $v0, %lo(gMasterDisp)($at)
    /* 875060 800C0460 14800004 */  bnez       $a0, .L800C0474
    /* 875064 800C0464 02C02821 */   addu      $a1, $s6, $zero
    /* 875068 800C0468 8E7005F4 */  lw         $s0, 0x5F4($s3)
    /* 87506C 800C046C 0803011E */  j          .L800C0478
    /* 875070 800C0470 00000000 */   nop
  .L800C0474:
    /* 875074 800C0474 8E700608 */  lw         $s0, 0x608($s3)
  .L800C0478:
    
    jal EG_RectAlign_Origin_Left_Left
    nop
    
    /* 875078 800C0478 02203021 */  addu       $a2, $s1, $zero
    /* 87507C 800C047C 3C028017 */  lui        $v0, %hi(D_80169CAC)
    /* 875080 800C0480 8C429CAC */  lw         $v0, %lo(D_80169CAC)($v0)
    /* 875084 800C0484 00102100 */  sll        $a0, $s0, 4
    /* 875088 800C0488 24840060 */  addiu      $a0, $a0, 0x60
    /* 87508C 800C048C 0C02E66C */  jal        func_DRAW_800B99B0
    /* 875090 800C0490 00442021 */   addu      $a0, $v0, $a0


    /* 875094 800C0494 24020002 */  addiu      $v0, $zero, 0x2
    /* 875098 800C0498 1202000C */  beq        $s0, $v0, .L800C04CC
    /* 87509C 800C049C 2A020003 */   slti      $v0, $s0, 0x3
    /* 8750A0 800C04A0 10400005 */  beqz       $v0, .L800C04B8
    /* 8750A4 800C04A4 24020001 */   addiu     $v0, $zero, 0x1
    /* 8750A8 800C04A8 52020009 */  beql       $s0, $v0, .L800C04D0
    /* 8750AC 800C04AC 24040011 */   addiu     $a0, $zero, 0x11
    /* 8750B0 800C04B0 08030134 */  j          .L800C04D0
    /* 8750B4 800C04B4 24040013 */   addiu     $a0, $zero, 0x13
  .L800C04B8:
    /* 8750B8 800C04B8 24020003 */  addiu      $v0, $zero, 0x3
    /* 8750BC 800C04BC 52020004 */  beql       $s0, $v0, .L800C04D0
    /* 8750C0 800C04C0 24040012 */   addiu     $a0, $zero, 0x12
    /* 8750C4 800C04C4 08030134 */  j          .L800C04D0
    /* 8750C8 800C04C8 24040013 */   addiu     $a0, $zero, 0x13
  .L800C04CC:
    /* 8750CC 800C04CC 24040014 */  addiu      $a0, $zero, 0x14
  .L800C04D0:
    /* 8750D0 800C04D0 26C50008 */  addiu      $a1, $s6, 0x8
    /* 8750D4 800C04D4 3C028017 */  lui        $v0, %hi(D_80169CAC)
    /* 8750D8 800C04D8 8C429CAC */  lw         $v0, %lo(D_80169CAC)($v0)
    /* 8750DC 800C04DC 26260004 */  addiu      $a2, $s1, 0x4
    /* 8750E0 800C04E0 00042100 */  sll        $a0, $a0, 4
    /* 8750E4 800C04E4 0C02E66C */  jal        func_DRAW_800B99B0
    /* 8750E8 800C04E8 00442021 */   addu      $a0, $v0, $a0
        
    jal EG_RectAlign_Origin_None_None
    nop

  .L800C04EC:
    /* 8750EC 800C04EC 02602021 */  addu       $a0, $s3, $zero
  .L800C04F0:

    jal EG_RectAlign_Origin_Right_Right
    nop

    /* 8750F0 800C04F0 8E420000 */  lw         $v0, 0x0($s2)
    /* 8750F4 800C04F4 26A500E6 */  addiu      $a1, $s5, 0xE6
    /* 8750F8 800C04F8 8E460004 */  lw         $a2, 0x4($s2)
    /* 8750FC 800C04FC 269100C3 */  addiu      $s1, $s4, 0xC3
    /* 875100 800C0500 00452821 */  addu       $a1, $v0, $a1
    /* 875104 800C0504 0C02EE4F */  jal        HUD_Speedometer_Draw
    /* 875108 800C0508 00D13021 */   addu      $a2, $a2, $s1

    jal EG_RectAlign_Origin_None_None
    nop

    jal EG_RectAlign_Origin_Left_Left
    nop

    /* 87510C 800C050C 02602021 */  addu       $a0, $s3, $zero
    /* 875110 800C0510 8E450000 */  lw         $a1, 0x0($s2)
    /* 875114 800C0514 8E460004 */  lw         $a2, 0x4($s2)
    /* 875118 800C0518 26B0001C */  addiu      $s0, $s5, 0x1C
    /* 87511C 800C051C 00B02821 */  addu       $a1, $a1, $s0
    /* 875120 800C0520 0C02F003 */  jal        HUD_ShieldMeter_Draw
    /* 875124 800C0524 00D13021 */   addu      $a2, $a2, $s1
    /* 875128 800C0528 8E450000 */  lw         $a1, 0x0($s2)
    /* 87512C 800C052C 02602021 */  addu       $a0, $s3, $zero
    /* 875130 800C0530 8E420004 */  lw         $v0, 0x4($s2)
    /* 875134 800C0534 268600D3 */  addiu      $a2, $s4, 0xD3
    /* 875138 800C0538 00B02821 */  addu       $a1, $a1, $s0
    /* 87513C 800C053C 0C02F103 */  jal        HUD_AmmoMeter_Draw
    /* 875140 800C0540 00463021 */   addu      $a2, $v0, $a2

    jal EG_RectAlign_Origin_None_None
    nop

    /* 875144 800C0544 3C028017 */  lui        $v0, %hi(D_801771B8)
    /* 875148 800C0548 8C4271B8 */  lw         $v0, %lo(D_801771B8)($v0)
    /* 87514C 800C054C 10400007 */  beqz       $v0, .L800C056C
    /* 875150 800C0550 02602021 */   addu      $a0, $s3, $zero
    /* 875154 800C0554 02402821 */  addu       $a1, $s2, $zero
    /* 875158 800C0558 02E03021 */  addu       $a2, $s7, $zero
    /* 87515C 800C055C 0C02F947 */  jal        func_800BE51C
    /* 875160 800C0560 00003821 */   addu      $a3, $zero, $zero
    /* 875164 800C0564 0803016A */  j          .L800C05A8
    /* 875168 800C0568 00000000 */   nop
  .L800C056C:
    /* 87516C 800C056C 02402821 */  addu       $a1, $s2, $zero
    /* 875170 800C0570 02E03021 */  addu       $a2, $s7, $zero
    /* 875174 800C0574 26A200A0 */  addiu      $v0, $s5, 0xA0
    /* 875178 800C0578 44823000 */  mtc1       $v0, $ft1
    /* 87517C 800C057C 468031A0 */  cvt.s.w    $ft1, $ft1
    /* 875180 800C0580 268200B4 */  addiu      $v0, $s4, 0xB4
    /* 875184 800C0584 44820000 */  mtc1       $v0, $fv0
    /* 875188 800C0588 46800020 */  cvt.s.w    $fv0, $fv0
    /* 87518C 800C058C 44073000 */  mfc1       $a3, $ft1
    /* 875190 800C0590 24020060 */  addiu      $v0, $zero, 0x60
    /* 875194 800C0594 AFA20014 */  sw         $v0, 0x14($sp)
    /* 875198 800C0598 24020019 */  addiu      $v0, $zero, 0x19
    /* 87519C 800C059C E7A00010 */  swc1       $fv0, 0x10($sp)
    /* 8751A0 800C05A0 0C02F79F */  jal        func_800BDE7C
    /* 8751A4 800C05A4 AFA20018 */   sw        $v0, 0x18($sp)
  .L800C05A8:
    /* 8751A8 800C05A8 3C028017 */  lui        $v0, %hi(gGameMode)
    /* 8751AC 800C05AC 8C4287A4 */  lw         $v0, %lo(gGameMode)($v0)
    /* 8751B0 800C05B0 38430002 */  xori       $v1, $v0, 0x2
    /* 8751B4 800C05B4 0003182B */  sltu       $v1, $zero, $v1
    /* 8751B8 800C05B8 38420004 */  xori       $v0, $v0, 0x4
    /* 8751BC 800C05BC 0002102B */  sltu       $v0, $zero, $v0
    /* 8751C0 800C05C0 00621824 */  and        $v1, $v1, $v0
    /* 8751C4 800C05C4 10600039 */  beqz       $v1, .L800C06AC
    /* 8751C8 800C05C8 00000000 */   nop
    /* 8751CC 800C05CC 8E420000 */  lw         $v0, 0x0($s2)
    /* 8751D0 800C05D0 02A28821 */  addu       $s1, $s5, $v0
    /* 8751D4 800C05D4 8E420004 */  lw         $v0, 0x4($s2)
    /* 8751D8 800C05D8 8E630728 */  lw         $v1, 0x728($s3)
    /* 8751DC 800C05DC 263100A0 */  addiu      $s1, $s1, 0xA0
    /* 8751E0 800C05E0 02828021 */  addu       $s0, $s4, $v0
    /* 8751E4 800C05E4 10600028 */  beqz       $v1, .L800C0688
    /* 8751E8 800C05E8 261000CB */   addiu     $s0, $s0, 0xCB
    /* 8751EC 800C05EC 3C048017 */  lui        $a0, %hi(gMasterDisp)
    /* 8751F0 800C05F0 248489EC */  addiu      $a0, $a0, %lo(gMasterDisp)
    /* 8751F4 800C05F4 0C018ADE */  jal        func_80062B78
    /* 8751F8 800C05F8 00000000 */   nop
    /* 8751FC 800C05FC 0C01873D */  jal        func_80061CF4
    /* 875200 800C0600 00002021 */   addu      $a0, $zero, $zero
    /* 875204 800C0604 3C02FF00 */  lui        $v0, (0xFF00FFFF >> 16)
    /* 875208 800C0608 3442FFFF */  ori        $v0, $v0, (0xFF00FFFF & 0xFFFF)
    /* 87520C 800C060C 3C048017 */  lui        $a0, %hi(gMasterDisp)
    /* 875210 800C0610 248489EC */  addiu      $a0, $a0, %lo(gMasterDisp)
    /* 875214 800C0614 3C05800A */  lui        $a1, %hi(D_8009C9A4)
    /* 875218 800C0618 24A5C9A4 */  addiu      $a1, $a1, %lo(D_8009C9A4)
    /* 87521C 800C061C 00003021 */  addu       $a2, $zero, $zero
    /* 875220 800C0620 3C01800A */  lui        $at, %hi(D_8009CAF0)
    /* 875224 800C0624 D422CAF0 */  ldc1       $fv1, %lo(D_8009CAF0)($at)
    /* 875228 800C0628 C6600728 */  lwc1       $fv0, 0x728($s3)
    /* 87522C 800C062C 46800021 */  cvt.d.w    $fv0, $fv0
    /* 875230 800C0630 AFA20010 */  sw         $v0, 0x10($sp)
    /* 875234 800C0634 2622FFF6 */  addiu      $v0, $s1, -0xA
    /* 875238 800C0638 46220002 */  mul.d      $fv0, $fv0, $fv1
    /* 87523C 800C063C AFA20018 */  sw         $v0, 0x18($sp)
    /* 875240 800C0640 24020014 */  addiu      $v0, $zero, 0x14
    /* 875244 800C0644 AFA20020 */  sw         $v0, 0x20($sp)
    /* 875248 800C0648 AFA20024 */  sw         $v0, 0x24($sp)
    /* 87524C 800C064C 3C028017 */  lui        $v0, %hi(D_80175398)
    /* 875250 800C0650 24425398 */  addiu      $v0, $v0, %lo(D_80175398)
    /* 875254 800C0654 AFB0001C */  sw         $s0, 0x1C($sp)
    /* 875258 800C0658 AFA20028 */  sw         $v0, 0x28($sp)
    /* 87525C 800C065C 4620008D */  trunc.w.d  $fv1, $fv0
    /* 875260 800C0660 E7A20014 */  swc1       $fv1, 0x14($sp)
    /* 875264 800C0664 0C019101 */  jal        func_80064404
    /* 875268 800C0668 24070010 */   addiu     $a3, $zero, 0x10
    /* 87526C 800C066C 3C048017 */  lui        $a0, %hi(gMasterDisp)
    /* 875270 800C0670 248489EC */  addiu      $a0, $a0, %lo(gMasterDisp)
    /* 875274 800C0674 0C018B20 */  jal        func_80062C80
    /* 875278 800C0678 00000000 */   nop
    /* 87527C 800C067C 8E620728 */  lw         $v0, 0x728($s3)
    /* 875280 800C0680 2442FFFF */  addiu      $v0, $v0, -0x1
    /* 875284 800C0684 AE620728 */  sw         $v0, 0x728($s3)
  .L800C0688:
    /* 875288 800C0688 02602021 */  addu       $a0, $s3, $zero
    /* 87528C 800C068C 24070010 */  addiu      $a3, $zero, 0x10
    /* 875290 800C0690 8E420000 */  lw         $v0, 0x0($s2)
    /* 875294 800C0694 26A500A0 */  addiu      $a1, $s5, 0xA0
    /* 875298 800C0698 8E430004 */  lw         $v1, 0x4($s2)
    /* 87529C 800C069C 268600DF */  addiu      $a2, $s4, 0xDF
    /* 8752A0 800C06A0 00452821 */  addu       $a1, $v0, $a1
    /* 8752A4 800C06A4 0C02FEBD */  jal        func_800BFAF4
    /* 8752A8 800C06A8 00663021 */   addu      $a2, $v1, $a2
  .L800C06AC:
    /* 8752AC 800C06AC 8FBF0058 */  lw         $ra, 0x58($sp)
    /* 8752B0 800C06B0 8FB70054 */  lw         $s7, 0x54($sp)
    /* 8752B4 800C06B4 8FB60050 */  lw         $s6, 0x50($sp)
    /* 8752B8 800C06B8 8FB5004C */  lw         $s5, 0x4C($sp)
    /* 8752BC 800C06BC 8FB40048 */  lw         $s4, 0x48($sp)
    /* 8752C0 800C06C0 8FB30044 */  lw         $s3, 0x44($sp)
    /* 8752C4 800C06C4 8FB20040 */  lw         $s2, 0x40($sp)
    /* 8752C8 800C06C8 8FB1003C */  lw         $s1, 0x3C($sp)
    /* 8752CC 800C06CC 8FB00038 */  lw         $s0, 0x38($sp)
    /* 8752D0 800C06D0 D7B60068 */  ldc1       $fs1, 0x68($sp)
    /* 8752D4 800C06D4 D7B40060 */  ldc1       $fs0, 0x60($sp)
    /* 8752D8 800C06D8 27BD0070 */  addiu      $sp, $sp, 0x70
    /* 8752DC 800C06DC 03E00008 */  jr         $ra
    /* 8752E0 800C06E0 00000000 */   nop
.size HUD_Draw, . - HUD_Draw

// HUD Draw function for 2P
glabel func_800C06E4
    jal EG_gEXEnable
    nop
    jal EG_gEXSetScissor
    nop
    /* 8752E4 800C06E4 3C038017 */  lui        $v1, %hi(gGameMode)
    /* 8752E8 800C06E8 8C6387A4 */  lw         $v1, %lo(gGameMode)($v1)
    /* 8752EC 800C06EC 27BDFF90 */  addiu      $sp, $sp, -0x70
    /* 8752F0 800C06F0 AFB70054 */  sw         $s7, 0x54($sp)
    /* 8752F4 800C06F4 8FB70080 */  lw         $s7, 0x80($sp)
    /* 8752F8 800C06F8 AFB30044 */  sw         $s3, 0x44($sp)
    /* 8752FC 800C06FC 00809821 */  addu       $s3, $a0, $zero
    /* 875300 800C0700 AFB20040 */  sw         $s2, 0x40($sp)
    /* 875304 800C0704 00A09021 */  addu       $s2, $a1, $zero
    /* 875308 800C0708 AFBE0058 */  sw         $fp, 0x58($sp)
    /* 87530C 800C070C F7B60068 */  sdc1       $fs1, 0x68($sp)
    /* 875310 800C0710 4487B000 */  mtc1       $a3, $fs1
    /* 875314 800C0714 2402000C */  addiu      $v0, $zero, 0xC
    /* 875318 800C0718 AFBF005C */  sw         $ra, 0x5C($sp)
    /* 87531C 800C071C AFB60050 */  sw         $s6, 0x50($sp)
    /* 875320 800C0720 AFB5004C */  sw         $s5, 0x4C($sp)
    /* 875324 800C0724 AFB40048 */  sw         $s4, 0x48($sp)
    /* 875328 800C0728 AFB1003C */  sw         $s1, 0x3C($sp)
    /* 87532C 800C072C AFB00038 */  sw         $s0, 0x38($sp)
    /* 875330 800C0730 F7B40060 */  sdc1       $fs0, 0x60($sp)
    /* 875334 800C0734 106201A8 */  beq        $v1, $v0, .L800C0DD8
    /* 875338 800C0738 00C0F021 */   addu      $fp, $a2, $zero
    /* 87533C 800C073C 8E6306F8 */  lw         $v1, 0x6F8($s3)
    /* 875340 800C0740 24020004 */  addiu      $v0, $zero, 0x4
    /* 875344 800C0744 1462000E */  bne        $v1, $v0, .L800C0780
    /* 875348 800C0748 00000000 */   nop
    /* 87534C 800C074C 3C028017 */  lui        $v0, %hi(D_801771B8)
    /* 875350 800C0750 8C4271B8 */  lw         $v0, %lo(D_801771B8)($v0)
    /* 875354 800C0754 104001A0 */  beqz       $v0, .L800C0DD8
    /* 875358 800C0758 00000000 */   nop
    /* 87535C 800C075C 3C028017 */  lui        $v0, %hi(D_80168814)
    /* 875360 800C0760 8C428814 */  lw         $v0, %lo(D_80168814)($v0)
    /* 875364 800C0764 28420003 */  slti       $v0, $v0, 0x3
    /* 875368 800C0768 1440019B */  bnez       $v0, .L800C0DD8
    /* 87536C 800C076C 00000000 */   nop
    /* 875370 800C0770 0C02FF5F */  jal        func_800BFD7C
    /* 875374 800C0774 02402021 */   addu      $a0, $s2, $zero
    /* 875378 800C0778 08030376 */  j          .L800C0DD8
    /* 87537C 800C077C 00000000 */   nop
  .L800C0780:
    /* 875380 800C0780 C66406B8 */  lwc1       $ft0, 0x6B8($s3)
    /* 875384 800C0784 44800000 */  mtc1       $zero, $fv0
    /* 875388 800C0788 46002032 */  c.eq.s     $ft0, $fv0
    /* 87538C 800C078C 00000000 */  nop
    /* 875390 800C0790 4501002B */  bc1t       .L800C0840
    /* 875394 800C0794 0000A021 */   addu      $s4, $zero, $zero
    /* 875398 800C0798 3C01800A */  lui        $at, %hi(D_8009CAF8)
    /* 87539C 800C079C D422CAF8 */  ldc1       $fv1, %lo(D_8009CAF8)($at)
    /* 8753A0 800C07A0 46002021 */  cvt.d.s    $fv0, $ft0
    /* 8753A4 800C07A4 46220002 */  mul.d      $fv0, $fv0, $fv1
    /* 8753A8 800C07A8 3C01800A */  lui        $at, %hi(D_8009CB00)
    /* 8753AC 800C07AC D422CB00 */  ldc1       $fv1, %lo(D_8009CB00)($at)
    /* 8753B0 800C07B0 46200520 */  cvt.s.d    $fs0, $fv0
    /* 8753B4 800C07B4 4600A021 */  cvt.d.s    $fv0, $fs0
    /* 8753B8 800C07B8 4622003C */  c.lt.d     $fv0, $fv1
    /* 8753BC 800C07BC 00000000 */  nop
    /* 8753C0 800C07C0 45000003 */  bc1f       .L800C07D0
    /* 8753C4 800C07C4 00000000 */   nop
    /* 8753C8 800C07C8 3C01800A */  lui        $at, %hi(D_8009CB08)
    /* 8753CC 800C07CC C434CB08 */  lwc1       $fs0, %lo(D_8009CB08)($at)
  .L800C07D0:
    /* 8753D0 800C07D0 4600A00D */  trunc.w.s  $fv0, $fs0
    /* 8753D4 800C07D4 44100000 */  mfc1       $s0, $fv0
    /* 8753D8 800C07D8 00108400 */  sll        $s0, $s0, 16
    /* 8753DC 800C07DC 00108403 */  sra        $s0, $s0, 16
    /* 8753E0 800C07E0 0C015AA7 */  jal        func_80056A9C
    /* 8753E4 800C07E4 02002021 */   addu      $a0, $s0, $zero
    /* 8753E8 800C07E8 3C01800A */  lui        $at, %hi(D_8009CB10)
    /* 8753EC 800C07EC D420CB10 */  ldc1       $fv0, %lo(D_8009CB10)($at)
    /* 8753F0 800C07F0 4600A521 */  cvt.d.s    $fs0, $fs0
    /* 8753F4 800C07F4 4620A502 */  mul.d      $fs0, $fs0, $fv0
    /* 8753F8 800C07F8 00021400 */  sll        $v0, $v0, 16
    /* 8753FC 800C07FC 00021403 */  sra        $v0, $v0, 16
    /* 875400 800C0800 44820000 */  mtc1       $v0, $fv0
    /* 875404 800C0804 46800021 */  cvt.d.w    $fv0, $fv0
    /* 875408 800C0808 46340001 */  sub.d      $fv0, $fv0, $fs0
    /* 87540C 800C080C 4620008D */  trunc.w.d  $fv1, $fv0
    /* 875410 800C0810 44161000 */  mfc1       $s6, $fv1
    /* 875414 800C0814 0C015AA7 */  jal        func_80056A9C
    /* 875418 800C0818 02002021 */   addu      $a0, $s0, $zero
    /* 87541C 800C081C 00021400 */  sll        $v0, $v0, 16
    /* 875420 800C0820 00021403 */  sra        $v0, $v0, 16
    /* 875424 800C0824 44820000 */  mtc1       $v0, $fv0
    /* 875428 800C0828 46800021 */  cvt.d.w    $fv0, $fv0
    /* 87542C 800C082C 46340001 */  sub.d      $fv0, $fv0, $fs0
    /* 875430 800C0830 4620008D */  trunc.w.d  $fv1, $fv0
    /* 875434 800C0834 44141000 */  mfc1       $s4, $fv1
    /* 875438 800C0838 08030211 */  j          .L800C0844
    /* 87543C 800C083C 00000000 */   nop
  .L800C0840:
    /* 875440 800C0840 0000B021 */  addu       $s6, $zero, $zero
  .L800C0844:
    /* 875444 800C0844 3C064270 */  lui        $a2, (0x42700000 >> 16)
    /* 875448 800C0848 3C108017 */  lui        $s0, %hi(gMasterDisp)
    /* 87544C 800C084C 261089EC */  addiu      $s0, $s0, %lo(gMasterDisp)
    /* 875450 800C0850 8E030000 */  lw         $v1, 0x0($s0)
    /* 875454 800C0854 3C01800A */  lui        $at, %hi(D_8009CB18)
    /* 875458 800C0858 C420CB18 */  lwc1       $fv0, %lo(D_8009CB18)($at)
    /* 87545C 800C085C 24620008 */  addiu      $v0, $v1, 0x8
    /* 875460 800C0860 AE020000 */  sw         $v0, 0x0($s0)
    /* 875464 800C0864 3C020600 */  lui        $v0, (0x6000000 >> 16)
    /* 875468 800C0868 AC620000 */  sw         $v0, 0x0($v1)
    /* 87546C 800C086C 3C028011 */  lui        $v0, %hi(D_80109158)
    /* 875470 800C0870 24429158 */  addiu      $v0, $v0, %lo(D_80109158)
    /* 875474 800C0874 AC620004 */  sw         $v0, 0x4($v1)
    /* 875478 800C0878 E7A00010 */  swc1       $fv0, 0x10($sp)
    /* 87547C 800C087C C7C000B0 */  lwc1       $fv0, 0xB0($fp)
    /* 875480 800C0880 46800020 */  cvt.s.w    $fv0, $fv0
    /* 875484 800C0884 46160002 */  mul.s      $fv0, $fv0, $fs1
    /* 875488 800C0888 3C073FAA */  lui        $a3, (0x3FAAAAAB >> 16)
    /* 87548C 800C088C 34E7AAAB */  ori        $a3, $a3, (0x3FAAAAAB & 0xFFFF)
    /* 875490 800C0890 3C118018 */  lui        $s1, %hi(D_8017A830)
    /* 875494 800C0894 2631A830 */  addiu      $s1, $s1, %lo(D_8017A830)
    /* 875498 800C0898 3C01800A */  lui        $at, %hi(D_8009CB1C)
    /* 87549C 800C089C C422CB1C */  lwc1       $fv1, %lo(D_8009CB1C)($at)
    /* 8754A0 800C08A0 02202021 */  addu       $a0, $s1, $zero
    /* 8754A4 800C08A4 27A50030 */  addiu      $a1, $sp, 0x30
    /* 8754A8 800C08A8 E7A20018 */  swc1       $fv1, 0x18($sp)
    /* 8754AC 800C08AC 0C01F658 */  jal        guPerspective
    /* 8754B0 800C08B0 E7A00014 */   swc1      $fv0, 0x14($sp)
    /* 8754B4 800C08B4 3C01800A */  lui        $at, %hi(D_8009CB20)
    /* 8754B8 800C08B8 C420CB20 */  lwc1       $fv0, %lo(D_8009CB20)($at)
    /* 8754BC 800C08BC 44050000 */  mfc1       $a1, $fv0
    /* 8754C0 800C08C0 3C048018 */  lui        $a0, %hi(D_8017A7F0)
    /* 8754C4 800C08C4 2484A7F0 */  addiu      $a0, $a0, %lo(D_8017A7F0)
    /* 8754C8 800C08C8 00A03021 */  addu       $a2, $a1, $zero
    /* 8754CC 800C08CC 0C01F769 */  jal        guScale
    /* 8754D0 800C08D0 00A03821 */   addu      $a3, $a1, $zero

    jal EG_RectAlign_Origin_Left_Left
    nop
    jal EG_gEXViewportOrigin_Left
    nop

    /* 8754D4 800C08D4 3C040103 */  lui        $a0, (0x1030040 >> 16)
    /* 8754D8 800C08D8 8E030000 */  lw         $v1, 0x0($s0)
    /* 8754DC 800C08DC 3C058017 */  lui        $a1, %hi(D_801771B8)
    /* 8754E0 800C08E0 8CA571B8 */  lw         $a1, %lo(D_801771B8)($a1)
    /* 8754E4 800C08E4 34840040 */  ori        $a0, $a0, (0x1030040 & 0xFFFF)
    /* 8754E8 800C08E8 24620008 */  addiu      $v0, $v1, 0x8
    /* 8754EC 800C08EC AE020000 */  sw         $v0, 0x0($s0)
    /* 8754F0 800C08F0 AC640000 */  sw         $a0, 0x0($v1)
    /* 8754F4 800C08F4 14A00008 */  bnez       $a1, .L800C0918
    /* 8754F8 800C08F8 AC710004 */   sw        $s1, 0x4($v1)
    /* 8754FC 800C08FC 02602021 */  addu       $a0, $s3, $zero
    /* 875500 800C0900 8E420000 */  lw         $v0, 0x0($s2)
    /* 875504 800C0904 26C5001C */  addiu      $a1, $s6, 0x1C
    /* 875508 800C0908 8E460004 */  lw         $a2, 0x4($s2)
    /* 87550C 800C090C 00452821 */  addu       $a1, $v0, $a1
    /* 875510 800C0910 0803024C */  j          .L800C0930
    /* 875514 800C0914 26E20025 */   addiu     $v0, $s7, 0x25
  .L800C0918:
    /* 875518 800C0918 02602021 */  addu       $a0, $s3, $zero
    /* 87551C 800C091C 8E420000 */  lw         $v0, 0x0($s2)
    /* 875520 800C0920 26C5001C */  addiu      $a1, $s6, 0x1C
    /* 875524 800C0924 8E460004 */  lw         $a2, 0x4($s2)
    /* 875528 800C0928 00452821 */  addu       $a1, $v0, $a1
    /* 87552C 800C092C 26E20012 */  addiu      $v0, $s7, 0x12
  .L800C0930:
    /* 875530 800C0930 00C23021 */  addu       $a2, $a2, $v0
    /* 875534 800C0934 0C02E93E */  jal        HUD_Turbo_Draw
    /* 875538 800C0938 00D43021 */   addu      $a2, $a2, $s4
    /* 87553C 800C093C 8E630460 */  lw         $v1, 0x460($s3)

    
    jal EG_RectAlign_Origin_None_None
    nop
    jal EG_gEXViewportOrigin_None
    nop

    /* 875540 800C0940 24020001 */  addiu      $v0, $zero, 0x1
    /* 875544 800C0944 1462000B */  bne        $v1, $v0, .L800C0974
    /* 875548 800C0948 02602021 */   addu      $a0, $s3, $zero
    /* 87554C 800C094C 3C073E2E */  lui        $a3, (0x3E2E147B >> 16)
    /* 875550 800C0950 34E7147B */  ori        $a3, $a3, (0x3E2E147B & 0xFFFF)
    /* 875554 800C0954 8E420000 */  lw         $v0, 0x0($s2)
    /* 875558 800C0958 26C50110 */  addiu      $a1, $s6, 0x110
    /* 87555C 800C095C 8E460004 */  lw         $a2, 0x4($s2)
    /* 875560 800C0960 00452821 */  addu       $a1, $v0, $a1
    /* 875564 800C0964 26E20048 */  addiu      $v0, $s7, 0x48
    /* 875568 800C0968 00C23021 */  addu       $a2, $a2, $v0
    /* 87556C 800C096C 0C02EA78 */  jal        func_800BA9E0
    /* 875570 800C0970 00D43021 */   addu      $a2, $a2, $s4
  .L800C0974:
    /* 875574 800C0974 3C028017 */  lui        $v0, %hi(gGameMode)
    /* 875578 800C0978 8C4287A4 */  lw         $v0, %lo(gGameMode)($v0)
    /* 87557C 800C097C 2442FFFF */  addiu      $v0, $v0, -0x1
    /* 875580 800C0980 2C420002 */  sltiu      $v0, $v0, 0x2
    /* 875584 800C0984 14400011 */  bnez       $v0, .L800C09CC
    /* 875588 800C0988 00000000 */   nop
    /* 87558C 800C098C 3C028017 */  lui        $v0, %hi(D_801771B8)
    /* 875590 800C0990 8C4271B8 */  lw         $v0, %lo(D_801771B8)($v0)
    /* 875594 800C0994 1440000D */  bnez       $v0, .L800C09CC
    /* 875598 800C0998 02602021 */   addu      $a0, $s3, $zero
    /* 87559C 800C099C 8E420000 */  lw         $v0, 0x0($s2)
    /* 8755A0 800C09A0 8E430004 */  lw         $v1, 0x4($s2)
    /* 8755A4 800C09A4 02402821 */  addu       $a1, $s2, $zero
    /* 8755A8 800C09A8 03C03021 */  addu       $a2, $fp, $zero
    /* 8755AC 800C09AC 26C700A0 */  addiu      $a3, $s6, 0xA0
    /* 8755B0 800C09B0 AFA00014 */  sw         $zero, 0x14($sp)
    /* 8755B4 800C09B4 00473821 */  addu       $a3, $v0, $a3
    /* 8755B8 800C09B8 26E20014 */  addiu      $v0, $s7, 0x14
    /* 8755BC 800C09BC 00621821 */  addu       $v1, $v1, $v0
    /* 8755C0 800C09C0 00741821 */  addu       $v1, $v1, $s4
    /* 8755C4 800C09C4 0C02FAD0 */  jal        HUD_RacerTracker_Draw
    /* 8755C8 800C09C8 AFA30010 */   sw        $v1, 0x10($sp)
  .L800C09CC:
    /* 8755CC 800C09CC 3C028017 */  lui        $v0, %hi(gGameMode)
    /* 8755D0 800C09D0 8C4287A4 */  lw         $v0, %lo(gGameMode)($v0)
    /* 8755D4 800C09D4 38430002 */  xori       $v1, $v0, 0x2
    /* 8755D8 800C09D8 2C630001 */  sltiu      $v1, $v1, 0x1
    /* 8755DC 800C09DC 38420004 */  xori       $v0, $v0, 0x4
    /* 8755E0 800C09E0 2C420001 */  sltiu      $v0, $v0, 0x1
    /* 8755E4 800C09E4 00621825 */  or         $v1, $v1, $v0
    /* 8755E8 800C09E8 1060000B */  beqz       $v1, .L800C0A18
    /* 8755EC 800C09EC 02602021 */   addu      $a0, $s3, $zero
    /* 8755F0 800C09F0 8E420000 */  lw         $v0, 0x0($s2)
    /* 8755F4 800C09F4 26C500EE */  addiu      $a1, $s6, 0xEE
    /* 8755F8 800C09F8 8E460004 */  lw         $a2, 0x4($s2)
    /* 8755FC 800C09FC 00452821 */  addu       $a1, $v0, $a1
    /* 875600 800C0A00 26E20012 */  addiu      $v0, $s7, 0x12
    /* 875604 800C0A04 00C23021 */  addu       $a2, $a2, $v0
    /* 875608 800C0A08 0C02ECC4 */  jal        func_800BB310
    /* 87560C 800C0A0C 00D43021 */   addu      $a2, $a2, $s4
    /* 875610 800C0A10 0803028E */  j          .L800C0A38
    /* 875614 800C0A14 00000000 */   nop
  .L800C0A18:
  
    jal EG_RectAlign_Origin_Right_Right
    nop

    /* 875618 800C0A18 8E420000 */  lw         $v0, 0x0($s2)
    /* 87561C 800C0A1C 26C500EE */  addiu      $a1, $s6, 0xEE
    /* 875620 800C0A20 8E460004 */  lw         $a2, 0x4($s2)
    /* 875624 800C0A24 00452821 */  addu       $a1, $v0, $a1
    /* 875628 800C0A28 26E20012 */  addiu      $v0, $s7, 0x12
    /* 87562C 800C0A2C 00C23021 */  addu       $a2, $a2, $v0
    /* 875630 800C0A30 0C02ED1F */  jal        HUD_Timer_Draw
    /* 875634 800C0A34 00D43021 */   addu      $a2, $a2, $s4
    
    jal EG_RectAlign_Origin_None_None
    nop

  .L800C0A38:
    /* 875638 800C0A38 8E420000 */  lw         $v0, 0x0($s2)
    /* 87563C 800C0A3C 8E430004 */  lw         $v1, 0x4($s2)
    /* 875640 800C0A40 02C22821 */  addu       $a1, $s6, $v0
    /* 875644 800C0A44 24A500F4 */  addiu      $a1, $a1, 0xF4
    /* 875648 800C0A48 02E33021 */  addu       $a2, $s7, $v1
    /* 87564C 800C0A4C 3C028017 */  lui        $v0, %hi(D_801771B8)
    /* 875650 800C0A50 8C4271B8 */  lw         $v0, %lo(D_801771B8)($v0)
    /* 875654 800C0A54 00D43021 */  addu       $a2, $a2, $s4
    /* 875658 800C0A58 14400020 */  bnez       $v0, .L800C0ADC
    /* 87565C 800C0A5C 24C60022 */   addiu     $a2, $a2, 0x22
    /* 875660 800C0A60 3C028017 */  lui        $v0, %hi(gMasterDisp)
    /* 875664 800C0A64 8C4289EC */  lw         $v0, %lo(gMasterDisp)($v0)
    /* 875668 800C0A68 3C030600 */  lui        $v1, (0x6000000 >> 16)
    /* 87566C 800C0A6C AC430000 */  sw         $v1, 0x0($v0)
    /* 875670 800C0A70 3C038011 */  lui        $v1, %hi(D_80109550)
    /* 875674 800C0A74 24639550 */  addiu      $v1, $v1, %lo(D_80109550)
    /* 875678 800C0A78 AC430004 */  sw         $v1, 0x4($v0)
    /* 87567C 800C0A7C 3C03FA00 */  lui        $v1, (0xFA000000 >> 16)
    /* 875680 800C0A80 AC430008 */  sw         $v1, 0x8($v0)
    /* 875684 800C0A84 2403FFFF */  addiu      $v1, $zero, -0x1
    /* 875688 800C0A88 AC43000C */  sw         $v1, 0xC($v0)
    /* 87568C 800C0A8C 866405E0 */  lh         $a0, 0x5E0($s3)
    /* 875690 800C0A90 24430008 */  addiu      $v1, $v0, 0x8
    /* 875694 800C0A94 3C018017 */  lui        $at, %hi(gMasterDisp)
    /* 875698 800C0A98 AC2389EC */  sw         $v1, %lo(gMasterDisp)($at)
    /* 87569C 800C0A9C 3C038009 */  lui        $v1, %hi(D_80095678)
    /* 8756A0 800C0AA0 8C635678 */  lw         $v1, %lo(D_80095678)($v1)
    /* 8756A4 800C0AA4 24420010 */  addiu      $v0, $v0, 0x10
    /* 8756A8 800C0AA8 3C018017 */  lui        $at, %hi(gMasterDisp)
    /* 8756AC 800C0AAC AC2289EC */  sw         $v0, %lo(gMasterDisp)($at)
    /* 8756B0 800C0AB0 0004102B */  sltu       $v0, $zero, $a0
    /* 8756B4 800C0AB4 00822023 */  subu       $a0, $a0, $v0
    /* 8756B8 800C0AB8 0083102A */  slt        $v0, $a0, $v1
    /* 8756BC 800C0ABC 50400001 */  beql       $v0, $zero, .L800C0AC4
    /* 8756C0 800C0AC0 2464FFFF */   addiu     $a0, $v1, -0x1
  .L800C0AC4:
  
    jal EG_RectAlign_Origin_Right_Right
    nop

    /* 8756C4 800C0AC4 3C028017 */  lui        $v0, %hi(D_80169CAC)
    /* 8756C8 800C0AC8 8C429CAC */  lw         $v0, %lo(D_80169CAC)($v0)
    /* 8756CC 800C0ACC 00042100 */  sll        $a0, $a0, 4
    /* 8756D0 800C0AD0 24840020 */  addiu      $a0, $a0, 0x20
    /* 8756D4 800C0AD4 0C02E66C */  jal        func_DRAW_800B99B0
    /* 8756D8 800C0AD8 00442021 */   addu      $a0, $v0, $a0
    
    jal EG_RectAlign_Origin_None_None
    nop

  .L800C0ADC:
    /* 8756DC 800C0ADC 8E420000 */  lw         $v0, 0x0($s2)
    /* 8756E0 800C0AE0 8E430004 */  lw         $v1, 0x4($s2)
    /* 8756E4 800C0AE4 02C2A821 */  addu       $s5, $s6, $v0
    /* 8756E8 800C0AE8 26B5001C */  addiu      $s5, $s5, 0x1C
    /* 8756EC 800C0AEC 02E38821 */  addu       $s1, $s7, $v1
    /* 8756F0 800C0AF0 3C028017 */  lui        $v0, %hi(gGameMode)
    /* 8756F4 800C0AF4 8C4287A4 */  lw         $v0, %lo(gGameMode)($v0)
    /* 8756F8 800C0AF8 02348821 */  addu       $s1, $s1, $s4
    /* 8756FC 800C0AFC 2442FFFF */  addiu      $v0, $v0, -0x1
    /* 875700 800C0B00 2C420002 */  sltiu      $v0, $v0, 0x2
    /* 875704 800C0B04 1440003A */  bnez       $v0, .L800C0BF0
    /* 875708 800C0B08 26310012 */   addiu     $s1, $s1, 0x12
    /* 87570C 800C0B0C 3C028017 */  lui        $v0, %hi(D_801771B8)
    /* 875710 800C0B10 8C4271B8 */  lw         $v0, %lo(D_801771B8)($v0)
    /* 875714 800C0B14 14400037 */  bnez       $v0, .L800C0BF4
    /* 875718 800C0B18 02602021 */   addu      $a0, $s3, $zero
    /* 87571C 800C0B1C 3C028017 */  lui        $v0, %hi(gMasterDisp)
    /* 875720 800C0B20 8C4289EC */  lw         $v0, %lo(gMasterDisp)($v0)
    /* 875724 800C0B24 3C030600 */  lui        $v1, (0x6000000 >> 16)
    /* 875728 800C0B28 AC430000 */  sw         $v1, 0x0($v0)
    /* 87572C 800C0B2C 3C038011 */  lui        $v1, %hi(D_80109550)
    /* 875730 800C0B30 24639550 */  addiu      $v1, $v1, %lo(D_80109550)
    /* 875734 800C0B34 AC430004 */  sw         $v1, 0x4($v0)
    /* 875738 800C0B38 3C03FA00 */  lui        $v1, (0xFA000000 >> 16)
    /* 87573C 800C0B3C AC430008 */  sw         $v1, 0x8($v0)
    /* 875740 800C0B40 2403FFFF */  addiu      $v1, $zero, -0x1
    /* 875744 800C0B44 AC43000C */  sw         $v1, 0xC($v0)
    /* 875748 800C0B48 8E640604 */  lw         $a0, 0x604($s3)
    /* 87574C 800C0B4C 24430008 */  addiu      $v1, $v0, 0x8
    /* 875750 800C0B50 24420010 */  addiu      $v0, $v0, 0x10
    /* 875754 800C0B54 3C018017 */  lui        $at, %hi(gMasterDisp)
    /* 875758 800C0B58 AC2389EC */  sw         $v1, %lo(gMasterDisp)($at)
    /* 87575C 800C0B5C 3C018017 */  lui        $at, %hi(gMasterDisp)
    /* 875760 800C0B60 AC2289EC */  sw         $v0, %lo(gMasterDisp)($at)
    /* 875764 800C0B64 14800004 */  bnez       $a0, .L800C0B78
    /* 875768 800C0B68 02A02821 */   addu      $a1, $s5, $zero
    /* 87576C 800C0B6C 8E7005F4 */  lw         $s0, 0x5F4($s3)
    /* 875770 800C0B70 080302DF */  j          .L800C0B7C
    /* 875774 800C0B74 00000000 */   nop
  .L800C0B78:
    /* 875778 800C0B78 8E700608 */  lw         $s0, 0x608($s3)
  .L800C0B7C:
      
    jal EG_RectAlign_Origin_Left_Left
    nop
    
    /* 87577C 800C0B7C 02203021 */  addu       $a2, $s1, $zero
    /* 875780 800C0B80 3C028017 */  lui        $v0, %hi(D_80169CAC)
    /* 875784 800C0B84 8C429CAC */  lw         $v0, %lo(D_80169CAC)($v0)
    /* 875788 800C0B88 00102100 */  sll        $a0, $s0, 4
    /* 87578C 800C0B8C 24840060 */  addiu      $a0, $a0, 0x60
    /* 875790 800C0B90 0C02E66C */  jal        func_DRAW_800B99B0
    /* 875794 800C0B94 00442021 */   addu      $a0, $v0, $a0
    /* 875798 800C0B98 24020002 */  addiu      $v0, $zero, 0x2
    /* 87579C 800C0B9C 1202000C */  beq        $s0, $v0, .L800C0BD0
    /* 8757A0 800C0BA0 2A020003 */   slti      $v0, $s0, 0x3
    /* 8757A4 800C0BA4 10400005 */  beqz       $v0, .L800C0BBC
    /* 8757A8 800C0BA8 24020001 */   addiu     $v0, $zero, 0x1
    /* 8757AC 800C0BAC 52020009 */  beql       $s0, $v0, .L800C0BD4
    /* 8757B0 800C0BB0 24040011 */   addiu     $a0, $zero, 0x11
    /* 8757B4 800C0BB4 080302F5 */  j          .L800C0BD4
    /* 8757B8 800C0BB8 24040013 */   addiu     $a0, $zero, 0x13
  .L800C0BBC:
    /* 8757BC 800C0BBC 24020003 */  addiu      $v0, $zero, 0x3
    /* 8757C0 800C0BC0 52020004 */  beql       $s0, $v0, .L800C0BD4
    /* 8757C4 800C0BC4 24040012 */   addiu     $a0, $zero, 0x12
    /* 8757C8 800C0BC8 080302F5 */  j          .L800C0BD4
    /* 8757CC 800C0BCC 24040013 */   addiu     $a0, $zero, 0x13
  .L800C0BD0:
    /* 8757D0 800C0BD0 24040014 */  addiu      $a0, $zero, 0x14
  .L800C0BD4:
    /* 8757D4 800C0BD4 26A50008 */  addiu      $a1, $s5, 0x8
    /* 8757D8 800C0BD8 3C028017 */  lui        $v0, %hi(D_80169CAC)
    /* 8757DC 800C0BDC 8C429CAC */  lw         $v0, %lo(D_80169CAC)($v0)
    /* 8757E0 800C0BE0 26260004 */  addiu      $a2, $s1, 0x4
    /* 8757E4 800C0BE4 00042100 */  sll        $a0, $a0, 4
    /* 8757E8 800C0BE8 0C02E66C */  jal        func_DRAW_800B99B0
    /* 8757EC 800C0BEC 00442021 */   addu      $a0, $v0, $a0
            
    jal EG_RectAlign_Origin_None_None
    nop

  .L800C0BF0:
    /* 8757F0 800C0BF0 02602021 */  addu       $a0, $s3, $zero
  .L800C0BF4:
  
    jal EG_RectAlign_Origin_Right_Right
    nop

    /* 8757F4 800C0BF4 8E420000 */  lw         $v0, 0x0($s2)
    /* 8757F8 800C0BF8 26C500E6 */  addiu      $a1, $s6, 0xE6
    /* 8757FC 800C0BFC 8E460004 */  lw         $a2, 0x4($s2)
    /* 875800 800C0C00 26F10058 */  addiu      $s1, $s7, 0x58
    /* 875804 800C0C04 00452821 */  addu       $a1, $v0, $a1
    /* 875808 800C0C08 00D13021 */  addu       $a2, $a2, $s1
    /* 87580C 800C0C0C 0C02EE4F */  jal        HUD_Speedometer_Draw
    /* 875810 800C0C10 00D43021 */   addu      $a2, $a2, $s4
    
    jal EG_RectAlign_Origin_None_None
    nop

    jal EG_RectAlign_Origin_Left_Left
    nop

    /* 875814 800C0C14 02602021 */  addu       $a0, $s3, $zero
    /* 875818 800C0C18 8E450000 */  lw         $a1, 0x0($s2)
    /* 87581C 800C0C1C 8E460004 */  lw         $a2, 0x4($s2)
    /* 875820 800C0C20 26D0001C */  addiu      $s0, $s6, 0x1C
    /* 875824 800C0C24 00B02821 */  addu       $a1, $a1, $s0
    /* 875828 800C0C28 00D13021 */  addu       $a2, $a2, $s1
    /* 87582C 800C0C2C 0C02F003 */  jal        HUD_ShieldMeter_Draw
    /* 875830 800C0C30 00D43021 */   addu      $a2, $a2, $s4
    /* 875834 800C0C34 8E450000 */  lw         $a1, 0x0($s2)
    /* 875838 800C0C38 02602021 */  addu       $a0, $s3, $zero
    /* 87583C 800C0C3C 8E460004 */  lw         $a2, 0x4($s2)
    /* 875840 800C0C40 26E20068 */  addiu      $v0, $s7, 0x68
    /* 875844 800C0C44 00B02821 */  addu       $a1, $a1, $s0
    /* 875848 800C0C48 00C23021 */  addu       $a2, $a2, $v0
    /* 87584C 800C0C4C 0C02F103 */  jal        HUD_AmmoMeter_Draw
    /* 875850 800C0C50 00D43021 */   addu      $a2, $a2, $s4
        
    jal EG_RectAlign_Origin_None_None
    nop

    /* 875854 800C0C54 3C028017 */  lui        $v0, %hi(D_801771B8)
    /* 875858 800C0C58 8C4271B8 */  lw         $v0, %lo(D_801771B8)($v0)
    /* 87585C 800C0C5C 10400007 */  beqz       $v0, .L800C0C7C
    /* 875860 800C0C60 02602021 */   addu      $a0, $s3, $zero
    /* 875864 800C0C64 02402821 */  addu       $a1, $s2, $zero
    /* 875868 800C0C68 03C03021 */  addu       $a2, $fp, $zero
    /* 87586C 800C0C6C 0C02F947 */  jal        func_800BE51C
    /* 875870 800C0C70 00003821 */   addu      $a3, $zero, $zero
    /* 875874 800C0C74 08030333 */  j          .L800C0CCC
    /* 875878 800C0C78 00000000 */   nop
  .L800C0C7C:
    /* 87587C 800C0C7C 02402821 */  addu       $a1, $s2, $zero
    /* 875880 800C0C80 8E470000 */  lw         $a3, 0x0($s2)
    /* 875884 800C0C84 8E430004 */  lw         $v1, 0x4($s2)
    /* 875888 800C0C88 03C03021 */  addu       $a2, $fp, $zero
    /* 87588C 800C0C8C 24020060 */  addiu      $v0, $zero, 0x60
    /* 875890 800C0C90 AFA20014 */  sw         $v0, 0x14($sp)
    /* 875894 800C0C94 2402001C */  addiu      $v0, $zero, 0x1C
    /* 875898 800C0C98 AFA20018 */  sw         $v0, 0x18($sp)
    /* 87589C 800C0C9C 26C200A0 */  addiu      $v0, $s6, 0xA0
    /* 8758A0 800C0CA0 00E23821 */  addu       $a3, $a3, $v0
    /* 8758A4 800C0CA4 44873000 */  mtc1       $a3, $ft1
    /* 8758A8 800C0CA8 468031A0 */  cvt.s.w    $ft1, $ft1
    /* 8758AC 800C0CAC 26E20078 */  addiu      $v0, $s7, 0x78
    /* 8758B0 800C0CB0 00621821 */  addu       $v1, $v1, $v0
    /* 8758B4 800C0CB4 00741821 */  addu       $v1, $v1, $s4
    /* 8758B8 800C0CB8 44073000 */  mfc1       $a3, $ft1
    /* 8758BC 800C0CBC 44830000 */  mtc1       $v1, $fv0
    /* 8758C0 800C0CC0 46800020 */  cvt.s.w    $fv0, $fv0
    /* 8758C4 800C0CC4 0C02F79F */  jal        func_800BDE7C
    /* 8758C8 800C0CC8 E7A00010 */   swc1      $fv0, 0x10($sp)
  .L800C0CCC:
    /* 8758CC 800C0CCC 3C028017 */  lui        $v0, %hi(gGameMode)
    /* 8758D0 800C0CD0 8C4287A4 */  lw         $v0, %lo(gGameMode)($v0)
    /* 8758D4 800C0CD4 38430002 */  xori       $v1, $v0, 0x2
    /* 8758D8 800C0CD8 0003182B */  sltu       $v1, $zero, $v1
    /* 8758DC 800C0CDC 38420004 */  xori       $v0, $v0, 0x4
    /* 8758E0 800C0CE0 0002102B */  sltu       $v0, $zero, $v0
    /* 8758E4 800C0CE4 00621824 */  and        $v1, $v1, $v0
    /* 8758E8 800C0CE8 1060003B */  beqz       $v1, .L800C0DD8
    /* 8758EC 800C0CEC 00000000 */   nop
    /* 8758F0 800C0CF0 8E420000 */  lw         $v0, 0x0($s2)
    /* 8758F4 800C0CF4 8E430004 */  lw         $v1, 0x4($s2)
    /* 8758F8 800C0CF8 02C28821 */  addu       $s1, $s6, $v0
    /* 8758FC 800C0CFC 263100A0 */  addiu      $s1, $s1, 0xA0
    /* 875900 800C0D00 02E38021 */  addu       $s0, $s7, $v1
    /* 875904 800C0D04 8E620728 */  lw         $v0, 0x728($s3)
    /* 875908 800C0D08 02148021 */  addu       $s0, $s0, $s4
    /* 87590C 800C0D0C 10400028 */  beqz       $v0, .L800C0DB0
    /* 875910 800C0D10 26100060 */   addiu     $s0, $s0, 0x60
    /* 875914 800C0D14 3C048017 */  lui        $a0, %hi(gMasterDisp)
    /* 875918 800C0D18 248489EC */  addiu      $a0, $a0, %lo(gMasterDisp)
    /* 87591C 800C0D1C 0C018ADE */  jal        func_80062B78
    /* 875920 800C0D20 00000000 */   nop
    /* 875924 800C0D24 0C01873D */  jal        func_80061CF4
    /* 875928 800C0D28 00002021 */   addu      $a0, $zero, $zero
    /* 87592C 800C0D2C 3C02FF00 */  lui        $v0, (0xFF00FFFF >> 16)
    /* 875930 800C0D30 3442FFFF */  ori        $v0, $v0, (0xFF00FFFF & 0xFFFF)
    /* 875934 800C0D34 3C048017 */  lui        $a0, %hi(gMasterDisp)
    /* 875938 800C0D38 248489EC */  addiu      $a0, $a0, %lo(gMasterDisp)
    /* 87593C 800C0D3C 3C05800A */  lui        $a1, %hi(D_8009C9A4)
    /* 875940 800C0D40 24A5C9A4 */  addiu      $a1, $a1, %lo(D_8009C9A4)
    /* 875944 800C0D44 00003021 */  addu       $a2, $zero, $zero
    /* 875948 800C0D48 3C01800A */  lui        $at, %hi(D_8009CB28)
    /* 87594C 800C0D4C D422CB28 */  ldc1       $fv1, %lo(D_8009CB28)($at)
    /* 875950 800C0D50 C6600728 */  lwc1       $fv0, 0x728($s3)
    /* 875954 800C0D54 46800021 */  cvt.d.w    $fv0, $fv0
    /* 875958 800C0D58 AFA20010 */  sw         $v0, 0x10($sp)
    /* 87595C 800C0D5C 2622FFF6 */  addiu      $v0, $s1, -0xA
    /* 875960 800C0D60 46220002 */  mul.d      $fv0, $fv0, $fv1
    /* 875964 800C0D64 AFA20018 */  sw         $v0, 0x18($sp)
    /* 875968 800C0D68 24020014 */  addiu      $v0, $zero, 0x14
    /* 87596C 800C0D6C AFA20020 */  sw         $v0, 0x20($sp)
    /* 875970 800C0D70 AFA20024 */  sw         $v0, 0x24($sp)
    /* 875974 800C0D74 3C028017 */  lui        $v0, %hi(D_80175398)
    /* 875978 800C0D78 24425398 */  addiu      $v0, $v0, %lo(D_80175398)
    /* 87597C 800C0D7C AFB0001C */  sw         $s0, 0x1C($sp)
    /* 875980 800C0D80 AFA20028 */  sw         $v0, 0x28($sp)
    /* 875984 800C0D84 4620008D */  trunc.w.d  $fv1, $fv0
    /* 875988 800C0D88 E7A20014 */  swc1       $fv1, 0x14($sp)
    /* 87598C 800C0D8C 0C019101 */  jal        func_80064404
    /* 875990 800C0D90 24070010 */   addiu     $a3, $zero, 0x10
    /* 875994 800C0D94 3C048017 */  lui        $a0, %hi(gMasterDisp)
    /* 875998 800C0D98 248489EC */  addiu      $a0, $a0, %lo(gMasterDisp)
    /* 87599C 800C0D9C 0C018B20 */  jal        func_80062C80
    /* 8759A0 800C0DA0 00000000 */   nop
    /* 8759A4 800C0DA4 8E620728 */  lw         $v0, 0x728($s3)
    /* 8759A8 800C0DA8 2442FFFF */  addiu      $v0, $v0, -0x1
    /* 8759AC 800C0DAC AE620728 */  sw         $v0, 0x728($s3)
  .L800C0DB0:
    /* 8759B0 800C0DB0 02602021 */  addu       $a0, $s3, $zero
    /* 8759B4 800C0DB4 24070010 */  addiu      $a3, $zero, 0x10
    /* 8759B8 800C0DB8 8E420000 */  lw         $v0, 0x0($s2)
    /* 8759BC 800C0DBC 26C500A0 */  addiu      $a1, $s6, 0xA0
    /* 8759C0 800C0DC0 8E460004 */  lw         $a2, 0x4($s2)
    /* 8759C4 800C0DC4 00452821 */  addu       $a1, $v0, $a1
    /* 8759C8 800C0DC8 26E20074 */  addiu      $v0, $s7, 0x74
    /* 8759CC 800C0DCC 00C23021 */  addu       $a2, $a2, $v0
    /* 8759D0 800C0DD0 0C02FEBD */  jal        func_800BFAF4
    /* 8759D4 800C0DD4 00D43021 */   addu      $a2, $a2, $s4
  .L800C0DD8:
    /* 8759D8 800C0DD8 8FBF005C */  lw         $ra, 0x5C($sp)
    /* 8759DC 800C0DDC 8FBE0058 */  lw         $fp, 0x58($sp)
    /* 8759E0 800C0DE0 8FB70054 */  lw         $s7, 0x54($sp)
    /* 8759E4 800C0DE4 8FB60050 */  lw         $s6, 0x50($sp)
    /* 8759E8 800C0DE8 8FB5004C */  lw         $s5, 0x4C($sp)
    /* 8759EC 800C0DEC 8FB40048 */  lw         $s4, 0x48($sp)
    /* 8759F0 800C0DF0 8FB30044 */  lw         $s3, 0x44($sp)
    /* 8759F4 800C0DF4 8FB20040 */  lw         $s2, 0x40($sp)
    /* 8759F8 800C0DF8 8FB1003C */  lw         $s1, 0x3C($sp)
    /* 8759FC 800C0DFC 8FB00038 */  lw         $s0, 0x38($sp)
    /* 875A00 800C0E00 D7B60068 */  ldc1       $fs1, 0x68($sp)
    /* 875A04 800C0E04 D7B40060 */  ldc1       $fs0, 0x60($sp)
    /* 875A08 800C0E08 27BD0070 */  addiu      $sp, $sp, 0x70
    /* 875A0C 800C0E0C 03E00008 */  jr         $ra
    /* 875A10 800C0E10 00000000 */   nop
.size func_800C06E4, . - func_800C06E4