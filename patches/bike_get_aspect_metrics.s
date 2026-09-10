.include "macro.inc"
#include "macro_float_reg.h"

.set noat
.set noreorder

.section .text, "ax"

.extern recomp_get_target_aspect_ratio

glabel bike_select_get_aspect_metrics
    addiu      $sp, $sp, -0x10
    sw         $ra, 0xC($sp)
    lui        $at, 0x3FAA
    ori        $at, $at, 0xAAAB
    mtc1       $at, $f12
    jal        recomp_get_target_aspect_ratio
     nop

    lui        $at, 0x42F0              # 120.0f
    mtc1       $at, $fv1
    mul.s      $fv1, $fv0, $fv1
    lui        $at, 0x3F00              # 0.5f
    mtc1       $at, $ft0
    add.s      $fv1, $fv1, $ft0
    trunc.w.s  $fv1, $fv1
    mfc1       $v0, $fv1

    lui        $at, 0x4240              # 48.0f
    mtc1       $at, $fv1
    mul.s      $fv1, $fv0, $fv1
    add.s      $fv1, $fv1, $ft0
    trunc.w.s  $fv1, $fv1
    mfc1       $v1, $fv1

    lw         $ra, 0xC($sp)
    addiu      $sp, $sp, 0x10
    jr         $ra
     nop
.size bike_select_get_aspect_metrics, . - bike_select_get_aspect_metrics