; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx2 | FileCheck --check-prefixes=AVX2 %s
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx2,+fast-variable-crosslane-shuffle,+fast-variable-perlane-shuffle | FileCheck --check-prefixes=AVX2 %s
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx2,+fast-variable-perlane-shuffle | FileCheck --check-prefixes=AVX2 %s

; These patterns are produced by LoopVectorizer for interleaved stores.

define void @load_i8_stride4_vf2(<8 x i8>* %in.vec, <2 x i8>* %out.vec0, <2 x i8>* %out.vec1, <2 x i8>* %out.vec2, <2 x i8>* %out.vec3) nounwind {
; AVX2-LABEL: load_i8_stride4_vf2:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovq {{.*#+}} xmm0 = mem[0],zero
; AVX2-NEXT:    vpshufb {{.*#+}} xmm1 = xmm0[0,4,u,u,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX2-NEXT:    vpshufb {{.*#+}} xmm2 = xmm0[1,5,u,u,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX2-NEXT:    vpshufb {{.*#+}} xmm3 = xmm0[2,6,u,u,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX2-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[3,7,u,u,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX2-NEXT:    vpextrw $0, %xmm1, (%rsi)
; AVX2-NEXT:    vpextrw $0, %xmm2, (%rdx)
; AVX2-NEXT:    vpextrw $0, %xmm3, (%rcx)
; AVX2-NEXT:    vpextrw $0, %xmm0, (%r8)
; AVX2-NEXT:    retq
  %wide.vec = load <8 x i8>, <8 x i8>* %in.vec, align 32

  %strided.vec0 = shufflevector <8 x i8> %wide.vec, <8 x i8> poison, <2 x i32> <i32 0, i32 4>
  %strided.vec1 = shufflevector <8 x i8> %wide.vec, <8 x i8> poison, <2 x i32> <i32 1, i32 5>
  %strided.vec2 = shufflevector <8 x i8> %wide.vec, <8 x i8> poison, <2 x i32> <i32 2, i32 6>
  %strided.vec3 = shufflevector <8 x i8> %wide.vec, <8 x i8> poison, <2 x i32> <i32 3, i32 7>

  store <2 x i8> %strided.vec0, <2 x i8>* %out.vec0, align 32
  store <2 x i8> %strided.vec1, <2 x i8>* %out.vec1, align 32
  store <2 x i8> %strided.vec2, <2 x i8>* %out.vec2, align 32
  store <2 x i8> %strided.vec3, <2 x i8>* %out.vec3, align 32

  ret void
}

define void @load_i8_stride4_vf4(<16 x i8>* %in.vec, <4 x i8>* %out.vec0, <4 x i8>* %out.vec1, <4 x i8>* %out.vec2, <4 x i8>* %out.vec3) nounwind {
; AVX2-LABEL: load_i8_stride4_vf4:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa (%rdi), %xmm0
; AVX2-NEXT:    vpshufb {{.*#+}} xmm1 = xmm0[0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX2-NEXT:    vpshufb {{.*#+}} xmm2 = xmm0[1,5,9,13,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX2-NEXT:    vpshufb {{.*#+}} xmm3 = xmm0[2,6,10,14,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX2-NEXT:    vpshufb {{.*#+}} xmm0 = xmm0[3,7,11,15,u,u,u,u,u,u,u,u,u,u,u,u]
; AVX2-NEXT:    vmovd %xmm1, (%rsi)
; AVX2-NEXT:    vmovd %xmm2, (%rdx)
; AVX2-NEXT:    vmovd %xmm3, (%rcx)
; AVX2-NEXT:    vmovd %xmm0, (%r8)
; AVX2-NEXT:    retq
  %wide.vec = load <16 x i8>, <16 x i8>* %in.vec, align 32

  %strided.vec0 = shufflevector <16 x i8> %wide.vec, <16 x i8> poison, <4 x i32> <i32 0, i32 4, i32 8, i32 12>
  %strided.vec1 = shufflevector <16 x i8> %wide.vec, <16 x i8> poison, <4 x i32> <i32 1, i32 5, i32 9, i32 13>
  %strided.vec2 = shufflevector <16 x i8> %wide.vec, <16 x i8> poison, <4 x i32> <i32 2, i32 6, i32 10, i32 14>
  %strided.vec3 = shufflevector <16 x i8> %wide.vec, <16 x i8> poison, <4 x i32> <i32 3, i32 7, i32 11, i32 15>

  store <4 x i8> %strided.vec0, <4 x i8>* %out.vec0, align 32
  store <4 x i8> %strided.vec1, <4 x i8>* %out.vec1, align 32
  store <4 x i8> %strided.vec2, <4 x i8>* %out.vec2, align 32
  store <4 x i8> %strided.vec3, <4 x i8>* %out.vec3, align 32

  ret void
}

define void @load_i8_stride4_vf8(<32 x i8>* %in.vec, <8 x i8>* %out.vec0, <8 x i8>* %out.vec1, <8 x i8>* %out.vec2, <8 x i8>* %out.vec3) nounwind {
; AVX2-LABEL: load_i8_stride4_vf8:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm0 = <0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vmovdqa (%rdi), %xmm1
; AVX2-NEXT:    vmovdqa 16(%rdi), %xmm2
; AVX2-NEXT:    vpshufb %xmm0, %xmm2, %xmm3
; AVX2-NEXT:    vpshufb %xmm0, %xmm1, %xmm0
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm0[0],xmm3[0],xmm0[1],xmm3[1]
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm3 = <1,5,9,13,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm3, %xmm2, %xmm4
; AVX2-NEXT:    vpshufb %xmm3, %xmm1, %xmm3
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm3 = xmm3[0],xmm4[0],xmm3[1],xmm4[1]
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm4 = <2,6,10,14,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm4, %xmm2, %xmm5
; AVX2-NEXT:    vpshufb %xmm4, %xmm1, %xmm4
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm4 = xmm4[0],xmm5[0],xmm4[1],xmm5[1]
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm5 = <3,7,11,15,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm5, %xmm2, %xmm2
; AVX2-NEXT:    vpshufb %xmm5, %xmm1, %xmm1
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1]
; AVX2-NEXT:    vmovq %xmm0, (%rsi)
; AVX2-NEXT:    vmovq %xmm3, (%rdx)
; AVX2-NEXT:    vmovq %xmm4, (%rcx)
; AVX2-NEXT:    vmovq %xmm1, (%r8)
; AVX2-NEXT:    retq
  %wide.vec = load <32 x i8>, <32 x i8>* %in.vec, align 32

  %strided.vec0 = shufflevector <32 x i8> %wide.vec, <32 x i8> poison, <8 x i32> <i32 0, i32 4, i32 8, i32 12, i32 16, i32 20, i32 24, i32 28>
  %strided.vec1 = shufflevector <32 x i8> %wide.vec, <32 x i8> poison, <8 x i32> <i32 1, i32 5, i32 9, i32 13, i32 17, i32 21, i32 25, i32 29>
  %strided.vec2 = shufflevector <32 x i8> %wide.vec, <32 x i8> poison, <8 x i32> <i32 2, i32 6, i32 10, i32 14, i32 18, i32 22, i32 26, i32 30>
  %strided.vec3 = shufflevector <32 x i8> %wide.vec, <32 x i8> poison, <8 x i32> <i32 3, i32 7, i32 11, i32 15, i32 19, i32 23, i32 27, i32 31>

  store <8 x i8> %strided.vec0, <8 x i8>* %out.vec0, align 32
  store <8 x i8> %strided.vec1, <8 x i8>* %out.vec1, align 32
  store <8 x i8> %strided.vec2, <8 x i8>* %out.vec2, align 32
  store <8 x i8> %strided.vec3, <8 x i8>* %out.vec3, align 32

  ret void
}

define void @load_i8_stride4_vf16(<64 x i8>* %in.vec, <16 x i8>* %out.vec0, <16 x i8>* %out.vec1, <16 x i8>* %out.vec2, <16 x i8>* %out.vec3) nounwind {
; AVX2-LABEL: load_i8_stride4_vf16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa (%rdi), %xmm0
; AVX2-NEXT:    vmovdqa 16(%rdi), %xmm1
; AVX2-NEXT:    vmovdqa 32(%rdi), %xmm2
; AVX2-NEXT:    vmovdqa 48(%rdi), %xmm3
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm4 = <u,u,u,u,0,4,8,12,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm4, %xmm3, %xmm5
; AVX2-NEXT:    vpshufb %xmm4, %xmm2, %xmm4
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm4 = xmm4[0],xmm5[0],xmm4[1],xmm5[1]
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm5 = <0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm5, %xmm1, %xmm6
; AVX2-NEXT:    vpshufb %xmm5, %xmm0, %xmm5
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm5 = xmm5[0],xmm6[0],xmm5[1],xmm6[1]
; AVX2-NEXT:    vpblendd {{.*#+}} xmm8 = xmm5[0,1],xmm4[2,3]
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm5 = <u,u,u,u,1,5,9,13,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm5, %xmm3, %xmm6
; AVX2-NEXT:    vpshufb %xmm5, %xmm2, %xmm5
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm5 = xmm5[0],xmm6[0],xmm5[1],xmm6[1]
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm6 = <1,5,9,13,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm6, %xmm1, %xmm7
; AVX2-NEXT:    vpshufb %xmm6, %xmm0, %xmm6
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm6 = xmm6[0],xmm7[0],xmm6[1],xmm7[1]
; AVX2-NEXT:    vpblendd {{.*#+}} xmm5 = xmm6[0,1],xmm5[2,3]
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm6 = <u,u,u,u,2,6,10,14,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm6, %xmm3, %xmm7
; AVX2-NEXT:    vpshufb %xmm6, %xmm2, %xmm6
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm6 = xmm6[0],xmm7[0],xmm6[1],xmm7[1]
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm7 = <2,6,10,14,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm7, %xmm1, %xmm4
; AVX2-NEXT:    vpshufb %xmm7, %xmm0, %xmm7
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm4 = xmm7[0],xmm4[0],xmm7[1],xmm4[1]
; AVX2-NEXT:    vpblendd {{.*#+}} xmm4 = xmm4[0,1],xmm6[2,3]
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm6 = <u,u,u,u,3,7,11,15,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm6, %xmm3, %xmm3
; AVX2-NEXT:    vpshufb %xmm6, %xmm2, %xmm2
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1]
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm3 = <3,7,11,15,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm3, %xmm1, %xmm1
; AVX2-NEXT:    vpshufb %xmm3, %xmm0, %xmm0
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; AVX2-NEXT:    vpblendd {{.*#+}} xmm0 = xmm0[0,1],xmm2[2,3]
; AVX2-NEXT:    vmovdqa %xmm8, (%rsi)
; AVX2-NEXT:    vmovdqa %xmm5, (%rdx)
; AVX2-NEXT:    vmovdqa %xmm4, (%rcx)
; AVX2-NEXT:    vmovdqa %xmm0, (%r8)
; AVX2-NEXT:    retq
  %wide.vec = load <64 x i8>, <64 x i8>* %in.vec, align 32

  %strided.vec0 = shufflevector <64 x i8> %wide.vec, <64 x i8> poison, <16 x i32> <i32 0, i32 4, i32 8, i32 12, i32 16, i32 20, i32 24, i32 28, i32 32, i32 36, i32 40, i32 44, i32 48, i32 52, i32 56, i32 60>
  %strided.vec1 = shufflevector <64 x i8> %wide.vec, <64 x i8> poison, <16 x i32> <i32 1, i32 5, i32 9, i32 13, i32 17, i32 21, i32 25, i32 29, i32 33, i32 37, i32 41, i32 45, i32 49, i32 53, i32 57, i32 61>
  %strided.vec2 = shufflevector <64 x i8> %wide.vec, <64 x i8> poison, <16 x i32> <i32 2, i32 6, i32 10, i32 14, i32 18, i32 22, i32 26, i32 30, i32 34, i32 38, i32 42, i32 46, i32 50, i32 54, i32 58, i32 62>
  %strided.vec3 = shufflevector <64 x i8> %wide.vec, <64 x i8> poison, <16 x i32> <i32 3, i32 7, i32 11, i32 15, i32 19, i32 23, i32 27, i32 31, i32 35, i32 39, i32 43, i32 47, i32 51, i32 55, i32 59, i32 63>

  store <16 x i8> %strided.vec0, <16 x i8>* %out.vec0, align 32
  store <16 x i8> %strided.vec1, <16 x i8>* %out.vec1, align 32
  store <16 x i8> %strided.vec2, <16 x i8>* %out.vec2, align 32
  store <16 x i8> %strided.vec3, <16 x i8>* %out.vec3, align 32

  ret void
}

define void @load_i8_stride4_vf32(<128 x i8>* %in.vec, <32 x i8>* %out.vec0, <32 x i8>* %out.vec1, <32 x i8>* %out.vec2, <32 x i8>* %out.vec3) nounwind {
; AVX2-LABEL: load_i8_stride4_vf32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm0 = <u,u,u,u,0,4,8,12,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vmovdqa 112(%rdi), %xmm10
; AVX2-NEXT:    vpshufb %xmm0, %xmm10, %xmm1
; AVX2-NEXT:    vmovdqa 96(%rdi), %xmm11
; AVX2-NEXT:    vpshufb %xmm0, %xmm11, %xmm3
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm1 = xmm3[0],xmm1[0],xmm3[1],xmm1[1]
; AVX2-NEXT:    vinserti128 $1, %xmm1, %ymm0, %ymm1
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm2 = <0,4,8,12,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vmovdqa 80(%rdi), %xmm13
; AVX2-NEXT:    vpshufb %xmm2, %xmm13, %xmm4
; AVX2-NEXT:    vmovdqa 64(%rdi), %xmm5
; AVX2-NEXT:    vpshufb %xmm2, %xmm5, %xmm6
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm4 = xmm6[0],xmm4[0],xmm6[1],xmm4[1]
; AVX2-NEXT:    vinserti128 $1, %xmm4, %ymm0, %ymm4
; AVX2-NEXT:    vpblendd {{.*#+}} ymm8 = ymm4[0,1,2,3,4,5],ymm1[6,7]
; AVX2-NEXT:    vmovdqa (%rdi), %xmm12
; AVX2-NEXT:    vmovdqa 16(%rdi), %xmm14
; AVX2-NEXT:    vmovdqa 32(%rdi), %xmm6
; AVX2-NEXT:    vmovdqa 48(%rdi), %xmm7
; AVX2-NEXT:    vpshufb %xmm0, %xmm7, %xmm1
; AVX2-NEXT:    vpshufb %xmm0, %xmm6, %xmm0
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1]
; AVX2-NEXT:    vpshufb %xmm2, %xmm14, %xmm1
; AVX2-NEXT:    vpshufb %xmm2, %xmm12, %xmm2
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm1 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
; AVX2-NEXT:    vpblendd {{.*#+}} xmm0 = xmm1[0,1],xmm0[2,3]
; AVX2-NEXT:    vpblendd {{.*#+}} ymm8 = ymm0[0,1,2,3],ymm8[4,5,6,7]
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm0 = <u,u,u,u,1,5,9,13,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm0, %xmm10, %xmm1
; AVX2-NEXT:    vpshufb %xmm0, %xmm11, %xmm2
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm1 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
; AVX2-NEXT:    vinserti128 $1, %xmm1, %ymm0, %ymm1
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm2 = <1,5,9,13,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm2, %xmm13, %xmm3
; AVX2-NEXT:    vpshufb %xmm2, %xmm5, %xmm4
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm3 = xmm4[0],xmm3[0],xmm4[1],xmm3[1]
; AVX2-NEXT:    vinserti128 $1, %xmm3, %ymm0, %ymm3
; AVX2-NEXT:    vpblendd {{.*#+}} ymm1 = ymm3[0,1,2,3,4,5],ymm1[6,7]
; AVX2-NEXT:    vpshufb %xmm0, %xmm7, %xmm3
; AVX2-NEXT:    vpshufb %xmm0, %xmm6, %xmm0
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm0[0],xmm3[0],xmm0[1],xmm3[1]
; AVX2-NEXT:    vpshufb %xmm2, %xmm14, %xmm3
; AVX2-NEXT:    vpshufb %xmm2, %xmm12, %xmm2
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1]
; AVX2-NEXT:    vpblendd {{.*#+}} xmm0 = xmm2[0,1],xmm0[2,3]
; AVX2-NEXT:    vpblendd {{.*#+}} ymm9 = ymm0[0,1,2,3],ymm1[4,5,6,7]
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm0 = <u,u,u,u,2,6,10,14,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm0, %xmm10, %xmm1
; AVX2-NEXT:    vpshufb %xmm0, %xmm11, %xmm2
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm1 = xmm2[0],xmm1[0],xmm2[1],xmm1[1]
; AVX2-NEXT:    vinserti128 $1, %xmm1, %ymm0, %ymm1
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm2 = <2,6,10,14,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm2, %xmm13, %xmm3
; AVX2-NEXT:    vpshufb %xmm2, %xmm5, %xmm4
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm3 = xmm4[0],xmm3[0],xmm4[1],xmm3[1]
; AVX2-NEXT:    vinserti128 $1, %xmm3, %ymm0, %ymm3
; AVX2-NEXT:    vpblendd {{.*#+}} ymm1 = ymm3[0,1,2,3,4,5],ymm1[6,7]
; AVX2-NEXT:    vpshufb %xmm0, %xmm7, %xmm3
; AVX2-NEXT:    vpshufb %xmm0, %xmm6, %xmm0
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm0 = xmm0[0],xmm3[0],xmm0[1],xmm3[1]
; AVX2-NEXT:    vpshufb %xmm2, %xmm14, %xmm3
; AVX2-NEXT:    vpshufb %xmm2, %xmm12, %xmm2
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm2 = xmm2[0],xmm3[0],xmm2[1],xmm3[1]
; AVX2-NEXT:    vpblendd {{.*#+}} xmm0 = xmm2[0,1],xmm0[2,3]
; AVX2-NEXT:    vpblendd {{.*#+}} ymm0 = ymm0[0,1,2,3],ymm1[4,5,6,7]
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm1 = <u,u,u,u,3,7,11,15,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm1, %xmm10, %xmm2
; AVX2-NEXT:    vpshufb %xmm1, %xmm11, %xmm3
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm2 = xmm3[0],xmm2[0],xmm3[1],xmm2[1]
; AVX2-NEXT:    vinserti128 $1, %xmm2, %ymm0, %ymm2
; AVX2-NEXT:    vmovdqa {{.*#+}} xmm3 = <3,7,11,15,u,u,u,u,u,u,u,u,u,u,u,u>
; AVX2-NEXT:    vpshufb %xmm3, %xmm13, %xmm4
; AVX2-NEXT:    vpshufb %xmm3, %xmm5, %xmm5
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm4 = xmm5[0],xmm4[0],xmm5[1],xmm4[1]
; AVX2-NEXT:    vinserti128 $1, %xmm4, %ymm0, %ymm4
; AVX2-NEXT:    vpblendd {{.*#+}} ymm2 = ymm4[0,1,2,3,4,5],ymm2[6,7]
; AVX2-NEXT:    vpshufb %xmm1, %xmm7, %xmm4
; AVX2-NEXT:    vpshufb %xmm1, %xmm6, %xmm1
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm1 = xmm1[0],xmm4[0],xmm1[1],xmm4[1]
; AVX2-NEXT:    vpshufb %xmm3, %xmm14, %xmm4
; AVX2-NEXT:    vpshufb %xmm3, %xmm12, %xmm3
; AVX2-NEXT:    vpunpckldq {{.*#+}} xmm3 = xmm3[0],xmm4[0],xmm3[1],xmm4[1]
; AVX2-NEXT:    vpblendd {{.*#+}} xmm1 = xmm3[0,1],xmm1[2,3]
; AVX2-NEXT:    vpblendd {{.*#+}} ymm1 = ymm1[0,1,2,3],ymm2[4,5,6,7]
; AVX2-NEXT:    vmovdqa %ymm8, (%rsi)
; AVX2-NEXT:    vmovdqa %ymm9, (%rdx)
; AVX2-NEXT:    vmovdqa %ymm0, (%rcx)
; AVX2-NEXT:    vmovdqa %ymm1, (%r8)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
  %wide.vec = load <128 x i8>, <128 x i8>* %in.vec, align 32

  %strided.vec0 = shufflevector <128 x i8> %wide.vec, <128 x i8> poison, <32 x i32> <i32 0, i32 4, i32 8, i32 12, i32 16, i32 20, i32 24, i32 28, i32 32, i32 36, i32 40, i32 44, i32 48, i32 52, i32 56, i32 60, i32 64, i32 68, i32 72, i32 76, i32 80, i32 84, i32 88, i32 92, i32 96, i32 100, i32 104, i32 108, i32 112, i32 116, i32 120, i32 124>
  %strided.vec1 = shufflevector <128 x i8> %wide.vec, <128 x i8> poison, <32 x i32> <i32 1, i32 5, i32 9, i32 13, i32 17, i32 21, i32 25, i32 29, i32 33, i32 37, i32 41, i32 45, i32 49, i32 53, i32 57, i32 61, i32 65, i32 69, i32 73, i32 77, i32 81, i32 85, i32 89, i32 93, i32 97, i32 101, i32 105, i32 109, i32 113, i32 117, i32 121, i32 125>
  %strided.vec2 = shufflevector <128 x i8> %wide.vec, <128 x i8> poison, <32 x i32> <i32 2, i32 6, i32 10, i32 14, i32 18, i32 22, i32 26, i32 30, i32 34, i32 38, i32 42, i32 46, i32 50, i32 54, i32 58, i32 62, i32 66, i32 70, i32 74, i32 78, i32 82, i32 86, i32 90, i32 94, i32 98, i32 102, i32 106, i32 110, i32 114, i32 118, i32 122, i32 126>
  %strided.vec3 = shufflevector <128 x i8> %wide.vec, <128 x i8> poison, <32 x i32> <i32 3, i32 7, i32 11, i32 15, i32 19, i32 23, i32 27, i32 31, i32 35, i32 39, i32 43, i32 47, i32 51, i32 55, i32 59, i32 63, i32 67, i32 71, i32 75, i32 79, i32 83, i32 87, i32 91, i32 95, i32 99, i32 103, i32 107, i32 111, i32 115, i32 119, i32 123, i32 127>

  store <32 x i8> %strided.vec0, <32 x i8>* %out.vec0, align 32
  store <32 x i8> %strided.vec1, <32 x i8>* %out.vec1, align 32
  store <32 x i8> %strided.vec2, <32 x i8>* %out.vec2, align 32
  store <32 x i8> %strided.vec3, <32 x i8>* %out.vec3, align 32

  ret void
}
