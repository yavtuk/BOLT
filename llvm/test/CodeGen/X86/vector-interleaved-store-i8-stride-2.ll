; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx2 | FileCheck --check-prefixes=AVX2 %s
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx2,+fast-variable-crosslane-shuffle,+fast-variable-perlane-shuffle | FileCheck --check-prefixes=AVX2 %s
; RUN: llc < %s -mtriple=x86_64-- -mattr=+avx2,+fast-variable-perlane-shuffle | FileCheck --check-prefixes=AVX2 %s

; These patterns are produced by LoopVectorizer for interleaved stores.

define void @store_i8_stride2_vf2(<2 x i8>* %in.vecptr0, <2 x i8>* %in.vecptr1, <4 x i8>* %out.vec) nounwind {
; AVX2-LABEL: store_i8_stride2_vf2:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa (%rdi), %xmm0
; AVX2-NEXT:    vpunpcklbw {{.*#+}} xmm0 = xmm0[0],mem[0],xmm0[1],mem[1],xmm0[2],mem[2],xmm0[3],mem[3],xmm0[4],mem[4],xmm0[5],mem[5],xmm0[6],mem[6],xmm0[7],mem[7]
; AVX2-NEXT:    vmovd %xmm0, (%rdx)
; AVX2-NEXT:    retq
  %in.vec0 = load <2 x i8>, <2 x i8>* %in.vecptr0, align 32
  %in.vec1 = load <2 x i8>, <2 x i8>* %in.vecptr1, align 32

  %concat01 = shufflevector <2 x i8> %in.vec0, <2 x i8> %in.vec1, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %interleaved.vec = shufflevector <4 x i8> %concat01, <4 x i8> poison, <4 x i32> <i32 0, i32 2, i32 1, i32 3>

  store <4 x i8> %interleaved.vec, <4 x i8>* %out.vec, align 32

  ret void
}

define void @store_i8_stride2_vf4(<4 x i8>* %in.vecptr0, <4 x i8>* %in.vecptr1, <8 x i8>* %out.vec) nounwind {
; AVX2-LABEL: store_i8_stride2_vf4:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa (%rdi), %xmm0
; AVX2-NEXT:    vpunpcklbw {{.*#+}} xmm0 = xmm0[0],mem[0],xmm0[1],mem[1],xmm0[2],mem[2],xmm0[3],mem[3],xmm0[4],mem[4],xmm0[5],mem[5],xmm0[6],mem[6],xmm0[7],mem[7]
; AVX2-NEXT:    vmovq %xmm0, (%rdx)
; AVX2-NEXT:    retq
  %in.vec0 = load <4 x i8>, <4 x i8>* %in.vecptr0, align 32
  %in.vec1 = load <4 x i8>, <4 x i8>* %in.vecptr1, align 32

  %concat01 = shufflevector <4 x i8> %in.vec0, <4 x i8> %in.vec1, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %interleaved.vec = shufflevector <8 x i8> %concat01, <8 x i8> poison, <8 x i32> <i32 0, i32 4, i32 1, i32 5, i32 2, i32 6, i32 3, i32 7>

  store <8 x i8> %interleaved.vec, <8 x i8>* %out.vec, align 32

  ret void
}

define void @store_i8_stride2_vf8(<8 x i8>* %in.vecptr0, <8 x i8>* %in.vecptr1, <16 x i8>* %out.vec) nounwind {
; AVX2-LABEL: store_i8_stride2_vf8:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovq {{.*#+}} xmm0 = mem[0],zero
; AVX2-NEXT:    vmovq {{.*#+}} xmm1 = mem[0],zero
; AVX2-NEXT:    vpunpcklbw {{.*#+}} xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
; AVX2-NEXT:    vmovdqa %xmm0, (%rdx)
; AVX2-NEXT:    retq
  %in.vec0 = load <8 x i8>, <8 x i8>* %in.vecptr0, align 32
  %in.vec1 = load <8 x i8>, <8 x i8>* %in.vecptr1, align 32

  %concat01 = shufflevector <8 x i8> %in.vec0, <8 x i8> %in.vec1, <16 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15>
  %interleaved.vec = shufflevector <16 x i8> %concat01, <16 x i8> poison, <16 x i32> <i32 0, i32 8, i32 1, i32 9, i32 2, i32 10, i32 3, i32 11, i32 4, i32 12, i32 5, i32 13, i32 6, i32 14, i32 7, i32 15>

  store <16 x i8> %interleaved.vec, <16 x i8>* %out.vec, align 32

  ret void
}

define void @store_i8_stride2_vf16(<16 x i8>* %in.vecptr0, <16 x i8>* %in.vecptr1, <32 x i8>* %out.vec) nounwind {
; AVX2-LABEL: store_i8_stride2_vf16:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa (%rdi), %xmm0
; AVX2-NEXT:    vinserti128 $1, (%rsi), %ymm0, %ymm0
; AVX2-NEXT:    vpermq {{.*#+}} ymm0 = ymm0[0,2,1,3]
; AVX2-NEXT:    vpshufb {{.*#+}} ymm0 = ymm0[0,8,1,9,2,10,3,11,4,12,5,13,6,14,7,15,16,24,17,25,18,26,19,27,20,28,21,29,22,30,23,31]
; AVX2-NEXT:    vmovdqa %ymm0, (%rdx)
; AVX2-NEXT:    vzeroupper
; AVX2-NEXT:    retq
  %in.vec0 = load <16 x i8>, <16 x i8>* %in.vecptr0, align 32
  %in.vec1 = load <16 x i8>, <16 x i8>* %in.vecptr1, align 32

  %concat01 = shufflevector <16 x i8> %in.vec0, <16 x i8> %in.vec1, <32 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31>
  %interleaved.vec = shufflevector <32 x i8> %concat01, <32 x i8> poison, <32 x i32> <i32 0, i32 16, i32 1, i32 17, i32 2, i32 18, i32 3, i32 19, i32 4, i32 20, i32 5, i32 21, i32 6, i32 22, i32 7, i32 23, i32 8, i32 24, i32 9, i32 25, i32 10, i32 26, i32 11, i32 27, i32 12, i32 28, i32 13, i32 29, i32 14, i32 30, i32 15, i32 31>

  store <32 x i8> %interleaved.vec, <32 x i8>* %out.vec, align 32

  ret void
}

define void @store_i8_stride2_vf32(<32 x i8>* %in.vecptr0, <32 x i8>* %in.vecptr1, <64 x i8>* %out.vec) nounwind {
; AVX2-LABEL: store_i8_stride2_vf32:
; AVX2:       # %bb.0:
; AVX2-NEXT:    vmovdqa (%rsi), %xmm0
; AVX2-NEXT:    vmovdqa 16(%rsi), %xmm1
; AVX2-NEXT:    vmovdqa (%rdi), %xmm2
; AVX2-NEXT:    vmovdqa 16(%rdi), %xmm3
; AVX2-NEXT:    vpunpckhbw {{.*#+}} xmm4 = xmm2[8],xmm0[8],xmm2[9],xmm0[9],xmm2[10],xmm0[10],xmm2[11],xmm0[11],xmm2[12],xmm0[12],xmm2[13],xmm0[13],xmm2[14],xmm0[14],xmm2[15],xmm0[15]
; AVX2-NEXT:    vpunpcklbw {{.*#+}} xmm0 = xmm2[0],xmm0[0],xmm2[1],xmm0[1],xmm2[2],xmm0[2],xmm2[3],xmm0[3],xmm2[4],xmm0[4],xmm2[5],xmm0[5],xmm2[6],xmm0[6],xmm2[7],xmm0[7]
; AVX2-NEXT:    vpunpckhbw {{.*#+}} xmm2 = xmm3[8],xmm1[8],xmm3[9],xmm1[9],xmm3[10],xmm1[10],xmm3[11],xmm1[11],xmm3[12],xmm1[12],xmm3[13],xmm1[13],xmm3[14],xmm1[14],xmm3[15],xmm1[15]
; AVX2-NEXT:    vpunpcklbw {{.*#+}} xmm1 = xmm3[0],xmm1[0],xmm3[1],xmm1[1],xmm3[2],xmm1[2],xmm3[3],xmm1[3],xmm3[4],xmm1[4],xmm3[5],xmm1[5],xmm3[6],xmm1[6],xmm3[7],xmm1[7]
; AVX2-NEXT:    vmovdqa %xmm1, 32(%rdx)
; AVX2-NEXT:    vmovdqa %xmm2, 48(%rdx)
; AVX2-NEXT:    vmovdqa %xmm0, (%rdx)
; AVX2-NEXT:    vmovdqa %xmm4, 16(%rdx)
; AVX2-NEXT:    retq
  %in.vec0 = load <32 x i8>, <32 x i8>* %in.vecptr0, align 32
  %in.vec1 = load <32 x i8>, <32 x i8>* %in.vecptr1, align 32

  %concat01 = shufflevector <32 x i8> %in.vec0, <32 x i8> %in.vec1, <64 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7, i32 8, i32 9, i32 10, i32 11, i32 12, i32 13, i32 14, i32 15, i32 16, i32 17, i32 18, i32 19, i32 20, i32 21, i32 22, i32 23, i32 24, i32 25, i32 26, i32 27, i32 28, i32 29, i32 30, i32 31, i32 32, i32 33, i32 34, i32 35, i32 36, i32 37, i32 38, i32 39, i32 40, i32 41, i32 42, i32 43, i32 44, i32 45, i32 46, i32 47, i32 48, i32 49, i32 50, i32 51, i32 52, i32 53, i32 54, i32 55, i32 56, i32 57, i32 58, i32 59, i32 60, i32 61, i32 62, i32 63>
  %interleaved.vec = shufflevector <64 x i8> %concat01, <64 x i8> poison, <64 x i32> <i32 0, i32 32, i32 1, i32 33, i32 2, i32 34, i32 3, i32 35, i32 4, i32 36, i32 5, i32 37, i32 6, i32 38, i32 7, i32 39, i32 8, i32 40, i32 9, i32 41, i32 10, i32 42, i32 11, i32 43, i32 12, i32 44, i32 13, i32 45, i32 14, i32 46, i32 15, i32 47, i32 16, i32 48, i32 17, i32 49, i32 18, i32 50, i32 19, i32 51, i32 20, i32 52, i32 21, i32 53, i32 22, i32 54, i32 23, i32 55, i32 24, i32 56, i32 25, i32 57, i32 26, i32 58, i32 27, i32 59, i32 28, i32 60, i32 29, i32 61, i32 30, i32 62, i32 31, i32 63>

  store <64 x i8> %interleaved.vec, <64 x i8>* %out.vec, align 32

  ret void
}
