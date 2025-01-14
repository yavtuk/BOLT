; NOTE: Assertions have been autogenerated by utils/update_mir_test_checks.py

; RUN: llc -O0 -mtriple=mipsel-linux-gnu -global-isel -stop-after=irtranslator -verify-machineinstrs %s -o - | FileCheck %s -check-prefixes=FP32
; RUN: llc -O0 -mtriple=mipsel-linux-gnu -mattr=+fp64,+mips32r2 -global-isel -stop-after=irtranslator -verify-machineinstrs %s -o - | FileCheck %s -check-prefixes=FP64

define float @float_in_fpr(float %a, float %b) {
  ; FP32-LABEL: name: float_in_fpr
  ; FP32: bb.1.entry:
  ; FP32-NEXT:   liveins: $f12, $f14
  ; FP32-NEXT: {{  $}}
  ; FP32-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $f12
  ; FP32-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $f14
  ; FP32-NEXT:   $f0 = COPY [[COPY1]](s32)
  ; FP32-NEXT:   RetRA implicit $f0
  ; FP64-LABEL: name: float_in_fpr
  ; FP64: bb.1.entry:
  ; FP64-NEXT:   liveins: $f12, $f14
  ; FP64-NEXT: {{  $}}
  ; FP64-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $f12
  ; FP64-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $f14
  ; FP64-NEXT:   $f0 = COPY [[COPY1]](s32)
  ; FP64-NEXT:   RetRA implicit $f0
entry:
  ret float %b
}

define double @double_in_fpr(double %a, double %b) {
  ; FP32-LABEL: name: double_in_fpr
  ; FP32: bb.1.entry:
  ; FP32-NEXT:   liveins: $d6, $d7
  ; FP32-NEXT: {{  $}}
  ; FP32-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $d6
  ; FP32-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $d7
  ; FP32-NEXT:   $d0 = COPY [[COPY1]](s64)
  ; FP32-NEXT:   RetRA implicit $d0
  ; FP64-LABEL: name: double_in_fpr
  ; FP64: bb.1.entry:
  ; FP64-NEXT:   liveins: $d12_64, $d14_64
  ; FP64-NEXT: {{  $}}
  ; FP64-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $d12_64
  ; FP64-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $d14_64
  ; FP64-NEXT:   $d0_64 = COPY [[COPY1]](s64)
  ; FP64-NEXT:   RetRA implicit $d0_64
entry:
  ret double %b
}

define float @float_in_gpr(i32 %a, float %b) {
  ; FP32-LABEL: name: float_in_gpr
  ; FP32: bb.1.entry:
  ; FP32-NEXT:   liveins: $a0, $a1
  ; FP32-NEXT: {{  $}}
  ; FP32-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $a0
  ; FP32-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $a1
  ; FP32-NEXT:   $f0 = COPY [[COPY1]](s32)
  ; FP32-NEXT:   RetRA implicit $f0
  ; FP64-LABEL: name: float_in_gpr
  ; FP64: bb.1.entry:
  ; FP64-NEXT:   liveins: $a0, $a1
  ; FP64-NEXT: {{  $}}
  ; FP64-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $a0
  ; FP64-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $a1
  ; FP64-NEXT:   $f0 = COPY [[COPY1]](s32)
  ; FP64-NEXT:   RetRA implicit $f0
entry:
  ret float %b
}

define double @double_in_gpr(i32 %a, double %b) {
  ; FP32-LABEL: name: double_in_gpr
  ; FP32: bb.1.entry:
  ; FP32-NEXT:   liveins: $a0, $a2, $a3
  ; FP32-NEXT: {{  $}}
  ; FP32-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $a0
  ; FP32-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $a2
  ; FP32-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $a3
  ; FP32-NEXT:   [[MV:%[0-9]+]]:_(s64) = G_MERGE_VALUES [[COPY1]](s32), [[COPY2]](s32)
  ; FP32-NEXT:   $d0 = COPY [[MV]](s64)
  ; FP32-NEXT:   RetRA implicit $d0
  ; FP64-LABEL: name: double_in_gpr
  ; FP64: bb.1.entry:
  ; FP64-NEXT:   liveins: $a0, $a2, $a3
  ; FP64-NEXT: {{  $}}
  ; FP64-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $a0
  ; FP64-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $a2
  ; FP64-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $a3
  ; FP64-NEXT:   [[MV:%[0-9]+]]:_(s64) = G_MERGE_VALUES [[COPY1]](s32), [[COPY2]](s32)
  ; FP64-NEXT:   $d0_64 = COPY [[MV]](s64)
  ; FP64-NEXT:   RetRA implicit $d0_64
entry:
  ret double %b
}

define float @call_float_in_fpr(float %a, float %b) {
  ; FP32-LABEL: name: call_float_in_fpr
  ; FP32: bb.1.entry:
  ; FP32-NEXT:   liveins: $f12, $f14
  ; FP32-NEXT: {{  $}}
  ; FP32-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $f12
  ; FP32-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $f14
  ; FP32-NEXT:   ADJCALLSTACKDOWN 16, 0, implicit-def $sp, implicit $sp
  ; FP32-NEXT:   $f12 = COPY [[COPY]](s32)
  ; FP32-NEXT:   $f14 = COPY [[COPY1]](s32)
  ; FP32-NEXT:   JAL @float_in_fpr, csr_o32, implicit-def $ra, implicit-def $sp, implicit $f12, implicit $f14, implicit-def $f0
  ; FP32-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $f0
  ; FP32-NEXT:   ADJCALLSTACKUP 16, 0, implicit-def $sp, implicit $sp
  ; FP32-NEXT:   $f0 = COPY [[COPY2]](s32)
  ; FP32-NEXT:   RetRA implicit $f0
  ; FP64-LABEL: name: call_float_in_fpr
  ; FP64: bb.1.entry:
  ; FP64-NEXT:   liveins: $f12, $f14
  ; FP64-NEXT: {{  $}}
  ; FP64-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $f12
  ; FP64-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $f14
  ; FP64-NEXT:   ADJCALLSTACKDOWN 16, 0, implicit-def $sp, implicit $sp
  ; FP64-NEXT:   $f12 = COPY [[COPY]](s32)
  ; FP64-NEXT:   $f14 = COPY [[COPY1]](s32)
  ; FP64-NEXT:   JAL @float_in_fpr, csr_o32_fp64, implicit-def $ra, implicit-def $sp, implicit $f12, implicit $f14, implicit-def $f0
  ; FP64-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $f0
  ; FP64-NEXT:   ADJCALLSTACKUP 16, 0, implicit-def $sp, implicit $sp
  ; FP64-NEXT:   $f0 = COPY [[COPY2]](s32)
  ; FP64-NEXT:   RetRA implicit $f0
entry:
  %call = call float @float_in_fpr(float %a, float %b)
  ret float %call
}

define double @call_double_in_fpr(double %a, double %b) {
  ; FP32-LABEL: name: call_double_in_fpr
  ; FP32: bb.1.entry:
  ; FP32-NEXT:   liveins: $d6, $d7
  ; FP32-NEXT: {{  $}}
  ; FP32-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $d6
  ; FP32-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $d7
  ; FP32-NEXT:   ADJCALLSTACKDOWN 16, 0, implicit-def $sp, implicit $sp
  ; FP32-NEXT:   $d6 = COPY [[COPY]](s64)
  ; FP32-NEXT:   $d7 = COPY [[COPY1]](s64)
  ; FP32-NEXT:   JAL @double_in_fpr, csr_o32, implicit-def $ra, implicit-def $sp, implicit $d6, implicit $d7, implicit-def $d0
  ; FP32-NEXT:   [[COPY2:%[0-9]+]]:_(s64) = COPY $d0
  ; FP32-NEXT:   ADJCALLSTACKUP 16, 0, implicit-def $sp, implicit $sp
  ; FP32-NEXT:   $d0 = COPY [[COPY2]](s64)
  ; FP32-NEXT:   RetRA implicit $d0
  ; FP64-LABEL: name: call_double_in_fpr
  ; FP64: bb.1.entry:
  ; FP64-NEXT:   liveins: $d12_64, $d14_64
  ; FP64-NEXT: {{  $}}
  ; FP64-NEXT:   [[COPY:%[0-9]+]]:_(s64) = COPY $d12_64
  ; FP64-NEXT:   [[COPY1:%[0-9]+]]:_(s64) = COPY $d14_64
  ; FP64-NEXT:   ADJCALLSTACKDOWN 16, 0, implicit-def $sp, implicit $sp
  ; FP64-NEXT:   $d12_64 = COPY [[COPY]](s64)
  ; FP64-NEXT:   $d14_64 = COPY [[COPY1]](s64)
  ; FP64-NEXT:   JAL @double_in_fpr, csr_o32_fp64, implicit-def $ra, implicit-def $sp, implicit $d12_64, implicit $d14_64, implicit-def $d0_64
  ; FP64-NEXT:   [[COPY2:%[0-9]+]]:_(s64) = COPY $d0_64
  ; FP64-NEXT:   ADJCALLSTACKUP 16, 0, implicit-def $sp, implicit $sp
  ; FP64-NEXT:   $d0_64 = COPY [[COPY2]](s64)
  ; FP64-NEXT:   RetRA implicit $d0_64
entry:
  %call = call double @double_in_fpr(double %a, double %b)
  ret double %call
}

define float @call_float_in_gpr(i32 %a, float %b) {
  ; FP32-LABEL: name: call_float_in_gpr
  ; FP32: bb.1.entry:
  ; FP32-NEXT:   liveins: $a0, $a1
  ; FP32-NEXT: {{  $}}
  ; FP32-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $a0
  ; FP32-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $a1
  ; FP32-NEXT:   ADJCALLSTACKDOWN 16, 0, implicit-def $sp, implicit $sp
  ; FP32-NEXT:   $a0 = COPY [[COPY]](s32)
  ; FP32-NEXT:   $a1 = COPY [[COPY1]](s32)
  ; FP32-NEXT:   JAL @float_in_gpr, csr_o32, implicit-def $ra, implicit-def $sp, implicit $a0, implicit $a1, implicit-def $f0
  ; FP32-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $f0
  ; FP32-NEXT:   ADJCALLSTACKUP 16, 0, implicit-def $sp, implicit $sp
  ; FP32-NEXT:   $f0 = COPY [[COPY2]](s32)
  ; FP32-NEXT:   RetRA implicit $f0
  ; FP64-LABEL: name: call_float_in_gpr
  ; FP64: bb.1.entry:
  ; FP64-NEXT:   liveins: $a0, $a1
  ; FP64-NEXT: {{  $}}
  ; FP64-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $a0
  ; FP64-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $a1
  ; FP64-NEXT:   ADJCALLSTACKDOWN 16, 0, implicit-def $sp, implicit $sp
  ; FP64-NEXT:   $a0 = COPY [[COPY]](s32)
  ; FP64-NEXT:   $a1 = COPY [[COPY1]](s32)
  ; FP64-NEXT:   JAL @float_in_gpr, csr_o32_fp64, implicit-def $ra, implicit-def $sp, implicit $a0, implicit $a1, implicit-def $f0
  ; FP64-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $f0
  ; FP64-NEXT:   ADJCALLSTACKUP 16, 0, implicit-def $sp, implicit $sp
  ; FP64-NEXT:   $f0 = COPY [[COPY2]](s32)
  ; FP64-NEXT:   RetRA implicit $f0
entry:
  %call = call float @float_in_gpr(i32 %a, float %b)
  ret float %call
}


define double @call_double_in_gpr(i32 %a, double %b) {
  ; FP32-LABEL: name: call_double_in_gpr
  ; FP32: bb.1.entry:
  ; FP32-NEXT:   liveins: $a0, $a2, $a3
  ; FP32-NEXT: {{  $}}
  ; FP32-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $a0
  ; FP32-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $a2
  ; FP32-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $a3
  ; FP32-NEXT:   [[MV:%[0-9]+]]:_(s64) = G_MERGE_VALUES [[COPY1]](s32), [[COPY2]](s32)
  ; FP32-NEXT:   ADJCALLSTACKDOWN 16, 0, implicit-def $sp, implicit $sp
  ; FP32-NEXT:   $a0 = COPY [[COPY]](s32)
  ; FP32-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[MV]](s64)
  ; FP32-NEXT:   $a2 = COPY [[UV]](s32)
  ; FP32-NEXT:   $a3 = COPY [[UV1]](s32)
  ; FP32-NEXT:   JAL @double_in_gpr, csr_o32, implicit-def $ra, implicit-def $sp, implicit $a0, implicit-def $d0
  ; FP32-NEXT:   [[COPY3:%[0-9]+]]:_(s64) = COPY $d0
  ; FP32-NEXT:   ADJCALLSTACKUP 16, 0, implicit-def $sp, implicit $sp
  ; FP32-NEXT:   $d0 = COPY [[COPY3]](s64)
  ; FP32-NEXT:   RetRA implicit $d0
  ; FP64-LABEL: name: call_double_in_gpr
  ; FP64: bb.1.entry:
  ; FP64-NEXT:   liveins: $a0, $a2, $a3
  ; FP64-NEXT: {{  $}}
  ; FP64-NEXT:   [[COPY:%[0-9]+]]:_(s32) = COPY $a0
  ; FP64-NEXT:   [[COPY1:%[0-9]+]]:_(s32) = COPY $a2
  ; FP64-NEXT:   [[COPY2:%[0-9]+]]:_(s32) = COPY $a3
  ; FP64-NEXT:   [[MV:%[0-9]+]]:_(s64) = G_MERGE_VALUES [[COPY1]](s32), [[COPY2]](s32)
  ; FP64-NEXT:   ADJCALLSTACKDOWN 16, 0, implicit-def $sp, implicit $sp
  ; FP64-NEXT:   $a0 = COPY [[COPY]](s32)
  ; FP64-NEXT:   [[UV:%[0-9]+]]:_(s32), [[UV1:%[0-9]+]]:_(s32) = G_UNMERGE_VALUES [[MV]](s64)
  ; FP64-NEXT:   $a2 = COPY [[UV]](s32)
  ; FP64-NEXT:   $a3 = COPY [[UV1]](s32)
  ; FP64-NEXT:   JAL @double_in_gpr, csr_o32_fp64, implicit-def $ra, implicit-def $sp, implicit $a0, implicit-def $d0_64
  ; FP64-NEXT:   [[COPY3:%[0-9]+]]:_(s64) = COPY $d0_64
  ; FP64-NEXT:   ADJCALLSTACKUP 16, 0, implicit-def $sp, implicit $sp
  ; FP64-NEXT:   $d0_64 = COPY [[COPY3]](s64)
  ; FP64-NEXT:   RetRA implicit $d0_64
entry:
  %call = call double @double_in_gpr(i32 %a, double %b)
  ret double %call
}
