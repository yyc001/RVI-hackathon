	.file	"chacha20_c.c"
	.option nopic
	.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0_v1p0_zicsr2p0_zifencei2p0_zbb1p0_zvbb1p0_zve32f1p0_zve32x1p0_zve64d1p0_zve64f1p0_zve64x1p0_zvkb1p0_zvl128b1p0_zvl32b1p0_zvl64b1p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.file 0 "/home/yyc/hachathon/chacha20-xiangshan" "chacha20_c.c"
	.align	1
	.globl	chacha20
	.type	chacha20, @function
chacha20:
.LFB0:
	.file 1 "chacha20_c.c"
	.loc 1 27 1
	.cfi_startproc
.LVL0:
	.loc 1 34 5
	.loc 1 35 5
	.loc 1 37 5
.LBB2:
	.loc 1 37 10
	.loc 1 37 23 discriminator 1
	.loc 1 38 9
	.loc 1 38 21 is_stmt 0
	vsetivli	zero,4,e32,m1,ta,ma
	vle32.v	v1,0(a1)
	.loc 1 37 30 is_stmt 1 discriminator 3
	.loc 1 37 23 discriminator 1
	.loc 1 38 9
.LBE2:
	.loc 1 27 1 is_stmt 0
	addi	sp,sp,-192
	.cfi_def_cfa_offset 192
	sd	s8,120(sp)
	.cfi_offset 24, -72
	mv	s8,a0
	addi	a0,a1,16
.LVL1:
	sd	s0,184(sp)
	vslidedown.vi	v4,v1,1
	vslidedown.vi	v3,v1,2
	vslidedown.vi	v2,v1,3
	sd	s1,176(sp)
	sd	s3,160(sp)
	sd	a0,8(sp)
	.cfi_offset 8, -8
	.cfi_offset 9, -16
	.cfi_offset 19, -32
	lw	s3,28(a1)
	addi	a0,a1,32
	lw	a6,24(a1)
	lw	a7,20(a1)
	lw	t1,16(a1)
.LBB3:
	.loc 1 37 30 is_stmt 1 discriminator 3
	.loc 1 37 23 discriminator 1
	.loc 1 38 9
	lw	t0,44(a1)
	lw	s0,40(a1)
	lw	s1,36(a1)
	lw	t6,32(a1)
	.loc 1 37 30 discriminator 3
	.loc 1 37 23 discriminator 1
	.loc 1 38 9
	lw	a5,60(a1)
	lw	a4,56(a1)
	lw	a3,52(a1)
	lw	a2,48(a1)
	.loc 1 37 30 discriminator 3
	.loc 1 37 23 discriminator 1
.LBE3:
	.loc 1 27 1 is_stmt 0
	sd	s2,168(sp)
	sd	a0,16(sp)
	vmv.x.s	t3,v4
	addi	a0,a1,48
	.cfi_offset 18, -24
	vmv.x.s	s2,v3
	vmv.x.s	t5,v2
	vmv.x.s	t4,v1
	sd	s4,152(sp)
	sd	s5,144(sp)
	sd	s6,136(sp)
	sd	s7,128(sp)
	sd	s9,112(sp)
	sd	s10,104(sp)
	sd	s11,96(sp)
	.cfi_offset 20, -40
	.cfi_offset 21, -48
	.cfi_offset 22, -56
	.cfi_offset 23, -64
	.cfi_offset 25, -80
	.cfi_offset 26, -88
	.cfi_offset 27, -96
	sd	a0,24(sp)
.LBB4:
	.loc 1 38 21
	li	t2,10
.L2:
.LBE4:
	.loc 1 42 9 is_stmt 1
	.loc 1 43 9 is_stmt 0
	addw	t3,a7,t3
	.loc 1 42 9
	addw	t4,t1,t4
	.loc 1 44 9
	addw	s2,s2,a6
	.loc 1 45 9
	addw	t5,s3,t5
	.loc 1 43 9
	xor	a3,t3,a3
	.loc 1 42 9
	xor	a2,t4,a2
	.loc 1 44 9
	xor	a4,s2,a4
	.loc 1 45 9
	xor	a5,t5,a5
	.loc 1 43 9
	roriw	a3,a3,16
	.loc 1 44 9
	roriw	a4,a4,16
	.loc 1 43 9
	addw	s1,a3,s1
	.loc 1 42 9
	roriw	a2,a2,16
	.loc 1 45 9
	roriw	a5,a5,16
	.loc 1 42 9
	addw	t6,a2,t6
	.loc 1 44 9
	addw	s0,a4,s0
	.loc 1 45 9
	addw	t0,a5,t0
	.loc 1 43 9
	xor	a7,s1,a7
	.loc 1 45 9
	xor	s3,t0,s3
	.loc 1 43 9
	roriw	a0,a7,20
	.loc 1 42 9
	xor	t1,t6,t1
	.loc 1 44 9
	xor	a6,s0,a6
	.loc 1 45 9
	roriw	a7,s3,20
	.loc 1 43 9
	addw	t3,t3,a0
	.loc 1 42 9
	roriw	t1,t1,20
	.loc 1 44 9
	roriw	a6,a6,20
	.loc 1 42 9
	addw	t4,t4,t1
	.loc 1 44 9
	addw	s2,s2,a6
	.loc 1 45 9
	addw	t5,t5,a7
	.loc 1 43 9
	xor	a3,t3,a3
	.loc 1 44 9
	xor	s3,s2,a4
	.loc 1 42 9
	xor	a2,t4,a2
	.loc 1 45 9
	xor	a5,t5,a5
	.loc 1 43 9
	roriw	a3,a3,24
	.loc 1 42 9
	roriw	a4,a2,24
	.loc 1 43 9
	addw	s1,s1,a3
	.loc 1 44 9
	roriw	a2,s3,24
	.loc 1 45 9
	roriw	a5,a5,24
	.loc 1 42 9
	addw	t6,t6,a4
	.loc 1 44 9
	addw	s0,s0,a2
	.loc 1 45 9
	addw	t0,t0,a5
	.loc 1 43 9
	xor	a0,s1,a0
	.loc 1 42 9
	xor	t1,t6,t1
	.loc 1 44 9
	xor	a6,s0,a6
	.loc 1 45 9
	xor	a7,t0,a7
	.loc 1 43 9
	roriw	a0,a0,25
	.loc 1 47 9
	addw	t4,t4,a0
	.loc 1 42 9
	roriw	t1,t1,25
	.loc 1 43 9 is_stmt 1
	.loc 1 44 9
	roriw	a6,a6,25
	.loc 1 45 9
	roriw	a7,a7,25
	.loc 1 47 9
	.loc 1 48 9 is_stmt 0
	addw	t3,t3,a6
	.loc 1 50 9
	addw	t5,t1,t5
	.loc 1 49 9
	addw	s2,s2,a7
	.loc 1 47 9
	xor	a5,t4,a5
	.loc 1 48 9
	xor	a4,t3,a4
	.loc 1 50 9
	xor	a2,t5,a2
	.loc 1 49 9
	xor	a3,s2,a3
	.loc 1 47 9
	roriw	a5,a5,16
	addw	s0,s0,a5
	.loc 1 48 9
	roriw	a4,a4,16
	.loc 1 50 9
	roriw	a2,a2,16
	.loc 1 49 9
	roriw	a3,a3,16
	.loc 1 50 9
	addw	s1,s1,a2
	.loc 1 48 9
	addw	t0,t0,a4
	.loc 1 49 9
	addw	t6,t6,a3
	.loc 1 47 9
	xor	a0,s0,a0
	.loc 1 50 9
	xor	t1,s1,t1
	.loc 1 48 9
	xor	a6,t0,a6
	.loc 1 49 9
	xor	a7,t6,a7
	.loc 1 47 9
	roriw	a0,a0,20
	.loc 1 50 9
	roriw	t1,t1,20
	.loc 1 48 9
	roriw	a6,a6,20
	.loc 1 49 9
	roriw	a7,a7,20
	.loc 1 47 9
	addw	t4,t4,a0
	.loc 1 50 9
	addw	t5,t5,t1
	.loc 1 48 9
	addw	t3,t3,a6
	.loc 1 49 9
	addw	s2,s2,a7
	.loc 1 47 9
	xor	a5,t4,a5
	.loc 1 50 9
	xor	a2,t5,a2
	.loc 1 48 9
	xor	a4,t3,a4
	.loc 1 47 9
	roriw	a5,a5,24
	.loc 1 49 9
	xor	a3,s2,a3
	.loc 1 50 9
	roriw	s5,a2,24
	.loc 1 49 9
	roriw	a3,a3,24
	.loc 1 48 9
	roriw	a2,a4,24
	.loc 1 47 9
	addw	s0,s0,a5
	.loc 1 50 9
	addw	s1,s1,s5
	.loc 1 48 9
	addw	t0,t0,a2
	.loc 1 49 9
	addw	t6,t6,a3
	.loc 1 47 9
	xor	a0,s0,a0
	.loc 1 49 9
	xor	a7,t6,a7
	.loc 1 50 9
	xor	t1,s1,t1
	.loc 1 48 9
	xor	a6,t0,a6
	.loc 1 47 9
	roriw	s10,a0,25
	.loc 1 41 20 discriminator 1
	addiw	t2,t2,-1
	.loc 1 49 9
	roriw	s3,a7,25
	.loc 1 47 9
	mv	s4,a5
	.loc 1 50 9
	roriw	t1,t1,25
	.loc 1 48 9
	roriw	a6,a6,25
	.loc 1 47 9
	sext.w	a7,s10
	.loc 1 48 9 is_stmt 1
	.loc 1 49 9
	.loc 1 50 9
	.loc 1 41 27 discriminator 3
	.loc 1 41 20 discriminator 1
	.loc 1 50 9 is_stmt 0
	sext.w	a4,s5
	.loc 1 41 20 discriminator 1
	bne	t2,zero,.L2
	addi	a5,a1,4
	sw	t4,32(sp)
	sw	s4,92(sp)
	sw	s0,72(sp)
	sw	s10,52(sp)
	sw	t3,36(sp)
	sw	a2,80(sp)
	sw	t0,76(sp)
	sw	a6,56(sp)
	sw	s2,40(sp)
	sw	a3,84(sp)
	sw	t6,64(sp)
	sw	s3,60(sp)
	sw	t5,44(sp)
	sw	s5,88(sp)
	sw	s1,68(sp)
	sw	t1,48(sp)
	sub	a5,s8,a5
	li	a4,8
	bleu	a5,a4,.L3
	.loc 1 54 9 is_stmt 1
	.loc 1 54 25 is_stmt 0
	addi	a5,sp,32
	.loc 1 54 29
	vle32.v	v2,0(a5)
	.loc 1 54 25
	addi	a5,sp,48
	.loc 1 54 29
	vle32.v	v4,0(a5)
	.loc 1 54 25
	addi	a5,sp,64
	.loc 1 54 29
	vle32.v	v3,0(a5)
	ld	a5,8(sp)
	vadd.vv	v1,v2,v1
	.loc 1 54 22
	addi	a3,s8,16
	addi	a4,s8,32
	vse32.v	v1,0(s8)
	.loc 1 53 25 is_stmt 1 discriminator 3
	.loc 1 53 19 discriminator 1
	.loc 1 54 9
	.loc 1 54 29 is_stmt 0
	vle32.v	v1,0(a5)
	.loc 1 54 25
	addi	a5,sp,80
	.loc 1 54 29
	vle32.v	v2,0(a5)
	.loc 1 54 22
	addi	a5,s8,48
	.loc 1 54 29
	vadd.vv	v1,v1,v4
	.loc 1 54 22
	vse32.v	v1,0(a3)
	.loc 1 53 25 is_stmt 1 discriminator 3
	.loc 1 53 19 discriminator 1
	.loc 1 54 9
	.loc 1 54 29 is_stmt 0
	ld	a3,16(sp)
	vle32.v	v1,0(a3)
	vadd.vv	v1,v1,v3
	.loc 1 54 22
	vse32.v	v1,0(a4)
	.loc 1 53 25 is_stmt 1 discriminator 3
	.loc 1 53 19 discriminator 1
	.loc 1 54 9
	.loc 1 54 29 is_stmt 0
	ld	a4,24(sp)
	vle32.v	v1,0(a4)
	vadd.vv	v1,v1,v2
	.loc 1 54 22
	vse32.v	v1,0(a5)
	.loc 1 53 25 is_stmt 1 discriminator 3
	.loc 1 53 19 discriminator 1
.L6:
	.loc 1 55 1 is_stmt 0
	ld	s0,184(sp)
	.cfi_remember_state
	.cfi_restore 8
	ld	s1,176(sp)
	.cfi_restore 9
	ld	s2,168(sp)
	.cfi_restore 18
	ld	s3,160(sp)
	.cfi_restore 19
	ld	s4,152(sp)
	.cfi_restore 20
	ld	s5,144(sp)
	.cfi_restore 21
	ld	s6,136(sp)
	.cfi_restore 22
	ld	s7,128(sp)
	.cfi_restore 23
	ld	s8,120(sp)
	.cfi_restore 24
.LVL2:
	ld	s9,112(sp)
	.cfi_restore 25
	ld	s10,104(sp)
	.cfi_restore 26
	ld	s11,96(sp)
	.cfi_restore 27
	addi	sp,sp,192
	.cfi_def_cfa_offset 0
	jr	ra
.LVL3:
.L3:
	.cfi_restore_state
	.loc 1 54 9 is_stmt 1
	.loc 1 54 29 is_stmt 0
	lw	a5,0(a1)
	addw	a5,a5,t4
	.loc 1 54 22
	sw	a5,0(s8)
	.loc 1 53 25 is_stmt 1 discriminator 3
.LVL4:
	.loc 1 53 19 discriminator 1
	.loc 1 54 9
	.loc 1 54 29 is_stmt 0
	lw	a5,4(a1)
	addw	a5,a5,t3
	.loc 1 54 22
	sw	a5,4(s8)
	.loc 1 53 25 is_stmt 1 discriminator 3
.LVL5:
	.loc 1 53 19 discriminator 1
	.loc 1 54 9
	.loc 1 54 29 is_stmt 0
	lw	a5,8(a1)
	addw	a5,a5,s2
	.loc 1 54 22
	sw	a5,8(s8)
	.loc 1 53 25 is_stmt 1 discriminator 3
.LVL6:
	.loc 1 53 19 discriminator 1
	.loc 1 54 9
	.loc 1 54 29 is_stmt 0
	lw	a5,12(a1)
	addw	a5,a5,t5
	.loc 1 54 22
	sw	a5,12(s8)
	.loc 1 53 25 is_stmt 1 discriminator 3
.LVL7:
	.loc 1 53 19 discriminator 1
	.loc 1 54 9
	.loc 1 54 29 is_stmt 0
	lw	a5,16(a1)
	addw	s11,t1,a5
	.loc 1 54 22
	sw	s11,16(s8)
	.loc 1 53 25 is_stmt 1 discriminator 3
.LVL8:
	.loc 1 53 19 discriminator 1
	.loc 1 54 9
	.loc 1 54 29 is_stmt 0
	lw	a5,20(a1)
	addw	s10,s10,a5
	.loc 1 54 22
	sw	s10,20(s8)
	.loc 1 53 25 is_stmt 1 discriminator 3
.LVL9:
	.loc 1 53 19 discriminator 1
	.loc 1 54 9
	.loc 1 54 29 is_stmt 0
	lw	a5,24(a1)
	addw	s9,a6,a5
	.loc 1 54 22
	sw	s9,24(s8)
	.loc 1 53 25 is_stmt 1 discriminator 3
.LVL10:
	.loc 1 53 19 discriminator 1
	.loc 1 54 9
	.loc 1 54 29 is_stmt 0
	lw	a5,28(a1)
	addw	a0,s3,a5
	.loc 1 54 22
	sw	a0,28(s8)
	.loc 1 53 25 is_stmt 1 discriminator 3
.LVL11:
	.loc 1 53 19 discriminator 1
	.loc 1 54 9
	.loc 1 54 29 is_stmt 0
	lw	a5,32(a1)
	addw	a5,a5,t6
	.loc 1 54 22
	sw	a5,32(s8)
	.loc 1 53 25 is_stmt 1 discriminator 3
.LVL12:
	.loc 1 53 19 discriminator 1
	.loc 1 54 9
	.loc 1 54 29 is_stmt 0
	lw	a5,36(a1)
	addw	a5,a5,s1
	.loc 1 54 22
	sw	a5,36(s8)
	.loc 1 53 25 is_stmt 1 discriminator 3
.LVL13:
	.loc 1 53 19 discriminator 1
	.loc 1 54 9
	.loc 1 54 29 is_stmt 0
	lw	a5,40(a1)
	addw	a5,a5,s0
	.loc 1 54 22
	sw	a5,40(s8)
	.loc 1 53 25 is_stmt 1 discriminator 3
.LVL14:
	.loc 1 53 19 discriminator 1
	.loc 1 54 9
	.loc 1 54 29 is_stmt 0
	lw	a5,44(a1)
	addw	a5,a5,t0
	.loc 1 54 22
	sw	a5,44(s8)
	.loc 1 53 25 is_stmt 1 discriminator 3
.LVL15:
	.loc 1 53 19 discriminator 1
	.loc 1 54 9
	.loc 1 54 29 is_stmt 0
	lw	a5,48(a1)
	addw	s7,a2,a5
	.loc 1 54 22
	sw	s7,48(s8)
	.loc 1 53 25 is_stmt 1 discriminator 3
.LVL16:
	.loc 1 53 19 discriminator 1
	.loc 1 54 9
	.loc 1 54 29 is_stmt 0
	lw	a5,52(a1)
	addw	s6,a3,a5
	.loc 1 54 22
	sw	s6,52(s8)
	.loc 1 53 25 is_stmt 1 discriminator 3
.LVL17:
	.loc 1 53 19 discriminator 1
	.loc 1 54 9
	.loc 1 54 29 is_stmt 0
	lw	a5,56(a1)
	addw	s5,s5,a5
	.loc 1 54 22
	sw	s5,56(s8)
	.loc 1 53 25 is_stmt 1 discriminator 3
.LVL18:
	.loc 1 53 19 discriminator 1
	.loc 1 54 9
	.loc 1 54 29 is_stmt 0
	lw	a5,60(a1)
	addw	s4,s4,a5
	.loc 1 54 22
	sw	s4,60(s8)
	.loc 1 53 25 is_stmt 1 discriminator 3
.LVL19:
	.loc 1 53 19 discriminator 1
	.loc 1 55 1 is_stmt 0
	j	.L6
	.cfi_endproc
.LFE0:
	.size	chacha20, .-chacha20
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align	3
.LC0:
	.string	"v["
	.align	3
.LC1:
	.string	"] = "
	.text
	.align	1
	.globl	print_vec
	.type	print_vec, @function
print_vec:
.LFB1:
	.loc 1 58 24 is_stmt 1
	.cfi_startproc
.LVL20:
	.loc 1 59 5
.LBB5:
	.loc 1 59 10
	.loc 1 59 23 discriminator 1
.LBE5:
	.loc 1 58 24 is_stmt 0
	addi	sp,sp,-32
	.cfi_def_cfa_offset 32
	sd	s0,16(sp)
	sd	s1,8(sp)
	sd	s2,0(sp)
	sd	ra,24(sp)
	.cfi_offset 8, -16
	.cfi_offset 9, -24
	.cfi_offset 18, -32
	.cfi_offset 1, -8
	.loc 1 58 24
	mv	s1,a0
	li	s0,0
.LBB6:
	.loc 1 59 23 discriminator 1
	li	s2,16
.LVL21:
.L11:
	.loc 1 60 9 is_stmt 1
	lla	a0,.LC0
	call	print_s
.LVL22:
	.loc 1 61 9
	mv	a0,s0
	call	print_long
.LVL23:
	.loc 1 62 9
	lla	a0,.LC1
	call	print_s
.LVL24:
	.loc 1 63 9
	lw	a0,0(s1)
	.loc 1 59 23 is_stmt 0 discriminator 1
	addi	s0,s0,1
.LVL25:
	addi	s1,s1,4
	.loc 1 63 9
	call	print_hex32
.LVL26:
	.loc 1 59 30 is_stmt 1 discriminator 3
	.loc 1 59 23 discriminator 1
	bne	s0,s2,.L11
.LBE6:
	.loc 1 65 1 is_stmt 0
	ld	ra,24(sp)
	.cfi_restore 1
	ld	s0,16(sp)
	.cfi_restore 8
	ld	s1,8(sp)
	.cfi_restore 9
	ld	s2,0(sp)
	.cfi_restore 18
	addi	sp,sp,32
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE1:
	.size	print_vec, .-print_vec
	.section	.rodata.str1.8
	.align	3
.LC2:
	.string	"input/output misaliged\n"
	.text
	.align	1
	.globl	chacha20v
	.type	chacha20v, @function
chacha20v:
.LFB2:
	.loc 1 83 1 is_stmt 1
	.cfi_startproc
.LVL27:
	.loc 1 85 5
	.loc 1 92 5
	.loc 1 92 38 is_stmt 0 discriminator 1
	or	a5,a1,a0
	andi	a5,a5,15
	bne	a5,zero,.L16
	.loc 1 97 5 is_stmt 1
	.loc 1 113 23 is_stmt 0
	addi	a5,a1,16
	.loc 1 114 23
	addi	a4,a1,32
	.loc 1 115 23
	addi	a3,a1,48
	.loc 1 97 5
	lla	a2,.LANCHOR0
	lla	a6,.LANCHOR0+16
	lla	a7,.LANCHOR0+32
	lla	t1,.LANCHOR0+48
 #APP
# 97 "chacha20_c.c" 1
	vsetivli t0, 4, e32, m1, ta, ma         
	vle32.v    v0, (a1)                  
	vle32.v    v1, (a5)                  
	vle32.v    v2, (a4)                  
	vle32.v    v3, (a3)                  
	vmv.v.v    v12, v0                       
	vmv.v.v    v13, v1                       
	vmv.v.v    v14, v2                       
	vmv.v.v    v15, v3                       
	vle32.v    v8, (a2)                  
	vle32.v    v9, (a6)                  
	vle32.v    v10, (a7)                  
	vle32.v    v11, (t1)                  
	
# 0 "" 2
	.loc 1 131 9 is_stmt 1
# 131 "chacha20_c.c" 1
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 16           
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 12           
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 8            
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 7            
	
# 0 "" 2
	.loc 1 151 9
# 151 "chacha20_c.c" 1
	vrgather.vv v4, v0, v8       
	vrgather.vv v5, v1, v9       
	vrgather.vv v6, v2, v10       
	vrgather.vv v7, v3, v11       
	
# 0 "" 2
	.loc 1 159 9
# 159 "chacha20_c.c" 1
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	
# 0 "" 2
	.loc 1 178 9
# 178 "chacha20_c.c" 1
	vrgather.vv v0, v4, v8       
	vrgather.vv v1, v5, v11      
	vrgather.vv v2, v6, v10      
	vrgather.vv v3, v7, v9       
	
# 0 "" 2
	.loc 1 189 9
# 189 "chacha20_c.c" 1
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 16           
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 12           
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 8            
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 7            
	
# 0 "" 2
	.loc 1 209 9
# 209 "chacha20_c.c" 1
	vrgather.vv v4, v0, v8       
	vrgather.vv v5, v1, v9       
	vrgather.vv v6, v2, v10       
	vrgather.vv v7, v3, v11       
	
# 0 "" 2
	.loc 1 217 9
# 217 "chacha20_c.c" 1
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	
# 0 "" 2
	.loc 1 236 9
# 236 "chacha20_c.c" 1
	vrgather.vv v0, v4, v8       
	vrgather.vv v1, v5, v11      
	vrgather.vv v2, v6, v10      
	vrgather.vv v3, v7, v9       
	
# 0 "" 2
	.loc 1 247 9
# 247 "chacha20_c.c" 1
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 16           
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 12           
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 8            
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 7            
	
# 0 "" 2
	.loc 1 267 9
# 267 "chacha20_c.c" 1
	vrgather.vv v4, v0, v8       
	vrgather.vv v5, v1, v9       
	vrgather.vv v6, v2, v10       
	vrgather.vv v7, v3, v11       
	
# 0 "" 2
	.loc 1 275 9
# 275 "chacha20_c.c" 1
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	
# 0 "" 2
	.loc 1 294 9
# 294 "chacha20_c.c" 1
	vrgather.vv v0, v4, v8       
	vrgather.vv v1, v5, v11      
	vrgather.vv v2, v6, v10      
	vrgather.vv v3, v7, v9       
	
# 0 "" 2
	.loc 1 305 9
# 305 "chacha20_c.c" 1
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 16           
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 12           
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 8            
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 7            
	
# 0 "" 2
	.loc 1 325 9
# 325 "chacha20_c.c" 1
	vrgather.vv v4, v0, v8       
	vrgather.vv v5, v1, v9       
	vrgather.vv v6, v2, v10       
	vrgather.vv v7, v3, v11       
	
# 0 "" 2
	.loc 1 333 9
# 333 "chacha20_c.c" 1
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	
# 0 "" 2
	.loc 1 352 9
# 352 "chacha20_c.c" 1
	vrgather.vv v0, v4, v8       
	vrgather.vv v1, v5, v11      
	vrgather.vv v2, v6, v10      
	vrgather.vv v3, v7, v9       
	
# 0 "" 2
	.loc 1 363 9
# 363 "chacha20_c.c" 1
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 16           
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 12           
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 8            
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 7            
	
# 0 "" 2
	.loc 1 383 9
# 383 "chacha20_c.c" 1
	vrgather.vv v4, v0, v8       
	vrgather.vv v5, v1, v9       
	vrgather.vv v6, v2, v10       
	vrgather.vv v7, v3, v11       
	
# 0 "" 2
	.loc 1 391 9
# 391 "chacha20_c.c" 1
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	
# 0 "" 2
	.loc 1 410 9
# 410 "chacha20_c.c" 1
	vrgather.vv v0, v4, v8       
	vrgather.vv v1, v5, v11      
	vrgather.vv v2, v6, v10      
	vrgather.vv v3, v7, v9       
	
# 0 "" 2
	.loc 1 421 9
# 421 "chacha20_c.c" 1
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 16           
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 12           
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 8            
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 7            
	
# 0 "" 2
	.loc 1 441 9
# 441 "chacha20_c.c" 1
	vrgather.vv v4, v0, v8       
	vrgather.vv v5, v1, v9       
	vrgather.vv v6, v2, v10       
	vrgather.vv v7, v3, v11       
	
# 0 "" 2
	.loc 1 449 9
# 449 "chacha20_c.c" 1
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	
# 0 "" 2
	.loc 1 468 9
# 468 "chacha20_c.c" 1
	vrgather.vv v0, v4, v8       
	vrgather.vv v1, v5, v11      
	vrgather.vv v2, v6, v10      
	vrgather.vv v3, v7, v9       
	
# 0 "" 2
	.loc 1 479 9
# 479 "chacha20_c.c" 1
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 16           
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 12           
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 8            
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 7            
	
# 0 "" 2
	.loc 1 499 9
# 499 "chacha20_c.c" 1
	vrgather.vv v4, v0, v8       
	vrgather.vv v5, v1, v9       
	vrgather.vv v6, v2, v10       
	vrgather.vv v7, v3, v11       
	
# 0 "" 2
	.loc 1 507 9
# 507 "chacha20_c.c" 1
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	
# 0 "" 2
	.loc 1 526 9
# 526 "chacha20_c.c" 1
	vrgather.vv v0, v4, v8       
	vrgather.vv v1, v5, v11      
	vrgather.vv v2, v6, v10      
	vrgather.vv v3, v7, v9       
	
# 0 "" 2
	.loc 1 537 9
# 537 "chacha20_c.c" 1
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 16           
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 12           
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 8            
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 7            
	
# 0 "" 2
	.loc 1 557 9
# 557 "chacha20_c.c" 1
	vrgather.vv v4, v0, v8       
	vrgather.vv v5, v1, v9       
	vrgather.vv v6, v2, v10       
	vrgather.vv v7, v3, v11       
	
# 0 "" 2
	.loc 1 565 9
# 565 "chacha20_c.c" 1
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	
# 0 "" 2
	.loc 1 584 9
# 584 "chacha20_c.c" 1
	vrgather.vv v0, v4, v8       
	vrgather.vv v1, v5, v11      
	vrgather.vv v2, v6, v10      
	vrgather.vv v3, v7, v9       
	
# 0 "" 2
	.loc 1 595 9
# 595 "chacha20_c.c" 1
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 16           
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 12           
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 8            
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 7            
	
# 0 "" 2
	.loc 1 615 9
# 615 "chacha20_c.c" 1
	vrgather.vv v4, v0, v8       
	vrgather.vv v5, v1, v9       
	vrgather.vv v6, v2, v10       
	vrgather.vv v7, v3, v11       
	
# 0 "" 2
	.loc 1 623 9
# 623 "chacha20_c.c" 1
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	
# 0 "" 2
	.loc 1 642 9
# 642 "chacha20_c.c" 1
	vrgather.vv v0, v4, v8       
	vrgather.vv v1, v5, v11      
	vrgather.vv v2, v6, v10      
	vrgather.vv v3, v7, v9       
	
# 0 "" 2
	.loc 1 653 9
# 653 "chacha20_c.c" 1
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 16           
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 12           
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 8            
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 7            
	
# 0 "" 2
	.loc 1 673 9
# 673 "chacha20_c.c" 1
	vrgather.vv v4, v0, v8       
	vrgather.vv v5, v1, v9       
	vrgather.vv v6, v2, v10       
	vrgather.vv v7, v3, v11       
	
# 0 "" 2
	.loc 1 681 9
# 681 "chacha20_c.c" 1
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	
# 0 "" 2
	.loc 1 700 9
# 700 "chacha20_c.c" 1
	vrgather.vv v0, v4, v8       
	vrgather.vv v1, v5, v11      
	vrgather.vv v2, v6, v10      
	vrgather.vv v3, v7, v9       
	
# 0 "" 2
	.loc 1 711 9
# 711 "chacha20_c.c" 1
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 16           
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 12           
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 8            
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 7            
	
# 0 "" 2
	.loc 1 731 9
# 731 "chacha20_c.c" 1
	vrgather.vv v4, v0, v8       
	vrgather.vv v5, v1, v9       
	vrgather.vv v6, v2, v10       
	vrgather.vv v7, v3, v11       
	
# 0 "" 2
	.loc 1 739 9
# 739 "chacha20_c.c" 1
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	
# 0 "" 2
	.loc 1 758 9
# 758 "chacha20_c.c" 1
	vrgather.vv v0, v4, v8       
	vrgather.vv v1, v5, v11      
	vrgather.vv v2, v6, v10      
	vrgather.vv v3, v7, v9       
	
# 0 "" 2
	.loc 1 769 9
# 769 "chacha20_c.c" 1
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 16           
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 12           
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 8            
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 7            
	
# 0 "" 2
	.loc 1 789 9
# 789 "chacha20_c.c" 1
	vrgather.vv v4, v0, v8       
	vrgather.vv v5, v1, v9       
	vrgather.vv v6, v2, v10       
	vrgather.vv v7, v3, v11       
	
# 0 "" 2
	.loc 1 797 9
# 797 "chacha20_c.c" 1
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	
# 0 "" 2
	.loc 1 816 9
# 816 "chacha20_c.c" 1
	vrgather.vv v0, v4, v8       
	vrgather.vv v1, v5, v11      
	vrgather.vv v2, v6, v10      
	vrgather.vv v3, v7, v9       
	
# 0 "" 2
	.loc 1 827 9
# 827 "chacha20_c.c" 1
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 16           
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 12           
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 8            
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 7            
	
# 0 "" 2
	.loc 1 847 9
# 847 "chacha20_c.c" 1
	vrgather.vv v4, v0, v8       
	vrgather.vv v5, v1, v9       
	vrgather.vv v6, v2, v10       
	vrgather.vv v7, v3, v11       
	
# 0 "" 2
	.loc 1 855 9
# 855 "chacha20_c.c" 1
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	
# 0 "" 2
	.loc 1 874 9
# 874 "chacha20_c.c" 1
	vrgather.vv v0, v4, v8       
	vrgather.vv v1, v5, v11      
	vrgather.vv v2, v6, v10      
	vrgather.vv v3, v7, v9       
	
# 0 "" 2
	.loc 1 885 9
# 885 "chacha20_c.c" 1
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 16           
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 12           
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 8            
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 7            
	
# 0 "" 2
	.loc 1 905 9
# 905 "chacha20_c.c" 1
	vrgather.vv v4, v0, v8       
	vrgather.vv v5, v1, v9       
	vrgather.vv v6, v2, v10       
	vrgather.vv v7, v3, v11       
	
# 0 "" 2
	.loc 1 913 9
# 913 "chacha20_c.c" 1
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	
# 0 "" 2
	.loc 1 932 9
# 932 "chacha20_c.c" 1
	vrgather.vv v0, v4, v8       
	vrgather.vv v1, v5, v11      
	vrgather.vv v2, v6, v10      
	vrgather.vv v3, v7, v9       
	
# 0 "" 2
	.loc 1 943 9
# 943 "chacha20_c.c" 1
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 16           
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 12           
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 8            
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 7            
	
# 0 "" 2
	.loc 1 963 9
# 963 "chacha20_c.c" 1
	vrgather.vv v4, v0, v8       
	vrgather.vv v5, v1, v9       
	vrgather.vv v6, v2, v10       
	vrgather.vv v7, v3, v11       
	
# 0 "" 2
	.loc 1 971 9
# 971 "chacha20_c.c" 1
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	
# 0 "" 2
	.loc 1 990 9
# 990 "chacha20_c.c" 1
	vrgather.vv v0, v4, v8       
	vrgather.vv v1, v5, v11      
	vrgather.vv v2, v6, v10      
	vrgather.vv v3, v7, v9       
	
# 0 "" 2
	.loc 1 1001 9
# 1001 "chacha20_c.c" 1
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 16           
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 12           
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 8            
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 7            
	
# 0 "" 2
	.loc 1 1021 9
# 1021 "chacha20_c.c" 1
	vrgather.vv v4, v0, v8       
	vrgather.vv v5, v1, v9       
	vrgather.vv v6, v2, v10       
	vrgather.vv v7, v3, v11       
	
# 0 "" 2
	.loc 1 1029 9
# 1029 "chacha20_c.c" 1
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	
# 0 "" 2
	.loc 1 1048 9
# 1048 "chacha20_c.c" 1
	vrgather.vv v0, v4, v8       
	vrgather.vv v1, v5, v11      
	vrgather.vv v2, v6, v10      
	vrgather.vv v3, v7, v9       
	
# 0 "" 2
	.loc 1 1059 9
# 1059 "chacha20_c.c" 1
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 16           
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 12           
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 8            
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 7            
	
# 0 "" 2
	.loc 1 1079 9
# 1079 "chacha20_c.c" 1
	vrgather.vv v4, v0, v8       
	vrgather.vv v5, v1, v9       
	vrgather.vv v6, v2, v10       
	vrgather.vv v7, v3, v11       
	
# 0 "" 2
	.loc 1 1087 9
# 1087 "chacha20_c.c" 1
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	
# 0 "" 2
	.loc 1 1106 9
# 1106 "chacha20_c.c" 1
	vrgather.vv v0, v4, v8       
	vrgather.vv v1, v5, v11      
	vrgather.vv v2, v6, v10      
	vrgather.vv v3, v7, v9       
	
# 0 "" 2
	.loc 1 1117 9
# 1117 "chacha20_c.c" 1
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 16           
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 12           
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 8            
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 7            
	
# 0 "" 2
	.loc 1 1137 9
# 1137 "chacha20_c.c" 1
	vrgather.vv v4, v0, v8       
	vrgather.vv v5, v1, v9       
	vrgather.vv v6, v2, v10       
	vrgather.vv v7, v3, v11       
	
# 0 "" 2
	.loc 1 1145 9
# 1145 "chacha20_c.c" 1
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	
# 0 "" 2
	.loc 1 1164 9
# 1164 "chacha20_c.c" 1
	vrgather.vv v0, v4, v8       
	vrgather.vv v1, v5, v11      
	vrgather.vv v2, v6, v10      
	vrgather.vv v3, v7, v9       
	
# 0 "" 2
	.loc 1 1175 9
# 1175 "chacha20_c.c" 1
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 16           
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 12           
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 8            
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 7            
	
# 0 "" 2
	.loc 1 1195 9
# 1195 "chacha20_c.c" 1
	vrgather.vv v4, v0, v8       
	vrgather.vv v5, v1, v9       
	vrgather.vv v6, v2, v10       
	vrgather.vv v7, v3, v11       
	
# 0 "" 2
	.loc 1 1203 9
# 1203 "chacha20_c.c" 1
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	
# 0 "" 2
	.loc 1 1222 9
# 1222 "chacha20_c.c" 1
	vrgather.vv v0, v4, v8       
	vrgather.vv v1, v5, v11      
	vrgather.vv v2, v6, v10      
	vrgather.vv v3, v7, v9       
	
# 0 "" 2
	.loc 1 1233 9
# 1233 "chacha20_c.c" 1
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 16           
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 12           
	vadd.vv    v0, v0, v1           
	vxor.vv    v3, v3, v0           
	vror.vi    v3, v3, 8            
	vadd.vv    v2, v2, v3           
	vxor.vv    v1, v1, v2           
	vror.vi    v1, v1, 7            
	
# 0 "" 2
	.loc 1 1253 9
# 1253 "chacha20_c.c" 1
	vrgather.vv v4, v0, v8       
	vrgather.vv v5, v1, v9       
	vrgather.vv v6, v2, v10       
	vrgather.vv v7, v3, v11       
	
# 0 "" 2
	.loc 1 1261 9
# 1261 "chacha20_c.c" 1
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	vadd.vv    v4, v4, v5           
	vxor.vv    v7, v7, v4           
	vror.vi    v7, v7, 16           
	vadd.vv    v6, v6, v7           
	vxor.vv    v5, v5, v6           
	vror.vi    v5, v5, 12           
	
# 0 "" 2
	.loc 1 1280 9
# 1280 "chacha20_c.c" 1
	vrgather.vv v0, v4, v8       
	vrgather.vv v1, v5, v11      
	vrgather.vv v2, v6, v10      
	vrgather.vv v3, v7, v9       
	
# 0 "" 2
	.loc 1 1297 5
	.loc 1 1308 25 is_stmt 0
 #NO_APP
	addi	a5,a0,16
	.loc 1 1309 25
	addi	a4,a0,32
	.loc 1 1310 25
	addi	a3,a0,48
	.loc 1 1297 5
 #APP
# 1297 "chacha20_c.c" 1
	vadd.vv    v0, v0, v12               
	vadd.vv    v1, v1, v13               
	vadd.vv    v2, v2, v14               
	vadd.vv    v3, v3, v15               
	vse32.v    v0, (a0)           
	vse32.v    v1, (a5)           
	vse32.v    v2, (a4)           
	vse32.v    v3, (a3)           
	
# 0 "" 2
	.loc 1 1315 1
 #NO_APP
	ret
.L16:
	.loc 1 93 9 is_stmt 1
	lla	a0,.LC2
.LVL28:
	tail	print_s
.LVL29:
	.cfi_endproc
.LFE2:
	.size	chacha20v, .-chacha20v
	.section	.rodata
	.align	4
	.set	.LANCHOR0,. + 0
	.type	index.0, @object
	.size	index.0, 64
index.0:
	.word	0
	.word	1
	.word	2
	.word	3
	.word	1
	.word	2
	.word	3
	.word	0
	.word	2
	.word	3
	.word	0
	.word	1
	.word	3
	.word	0
	.word	1
	.word	2
	.text
.Letext0:
	.file 2 "src/chacha20.h"
	.file 3 "/home/yyc/riscv/riscv64-unknown-elf/include/machine/_default_types.h"
	.file 4 "/home/yyc/riscv/riscv64-unknown-elf/include/sys/_stdint.h"
	.file 5 "lib/textio.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x2b8
	.2byte	0x5
	.byte	0x1
	.byte	0x8
	.4byte	.Ldebug_abbrev0
	.uleb128 0x11
	.4byte	.LASF20
	.byte	0x1d
	.4byte	.LASF0
	.4byte	.LASF1
	.8byte	.Ltext0
	.8byte	.Letext0-.Ltext0
	.4byte	.Ldebug_line0
	.uleb128 0xc
	.string	"u32"
	.byte	0x4
	.byte	0x16
	.4byte	0x3e
	.uleb128 0x2
	.4byte	0x2e
	.uleb128 0x1
	.byte	0x4
	.byte	0x7
	.4byte	.LASF2
	.uleb128 0xc
	.string	"u8"
	.byte	0x5
	.byte	0x17
	.4byte	0x4f
	.uleb128 0x1
	.byte	0x1
	.byte	0x8
	.4byte	.LASF3
	.uleb128 0x12
	.byte	0x40
	.byte	0x2
	.byte	0x7
	.byte	0x9
	.4byte	0x72
	.uleb128 0xd
	.string	"u"
	.byte	0x8
	.byte	0x9
	.4byte	0x72
	.uleb128 0xd
	.string	"c"
	.byte	0x9
	.byte	0x8
	.4byte	0x89
	.byte	0
	.uleb128 0x5
	.4byte	0x2e
	.4byte	0x82
	.uleb128 0x6
	.4byte	0x82
	.byte	0xf
	.byte	0
	.uleb128 0x1
	.byte	0x8
	.byte	0x7
	.4byte	.LASF4
	.uleb128 0x5
	.4byte	0x45
	.4byte	0x99
	.uleb128 0x6
	.4byte	0x82
	.byte	0x3f
	.byte	0
	.uleb128 0x7
	.4byte	.LASF5
	.byte	0x2
	.byte	0xa
	.byte	0x3
	.4byte	0x56
	.uleb128 0x1
	.byte	0x1
	.byte	0x6
	.4byte	.LASF6
	.uleb128 0x1
	.byte	0x2
	.byte	0x5
	.4byte	.LASF7
	.uleb128 0x1
	.byte	0x2
	.byte	0x7
	.4byte	.LASF8
	.uleb128 0x13
	.byte	0x4
	.byte	0x5
	.string	"int"
	.uleb128 0x2
	.4byte	0xba
	.uleb128 0x1
	.byte	0x8
	.byte	0x5
	.4byte	.LASF9
	.uleb128 0x7
	.4byte	.LASF10
	.byte	0x3
	.byte	0xe8
	.byte	0x1a
	.4byte	0x82
	.uleb128 0x7
	.4byte	.LASF11
	.byte	0x4
	.byte	0x52
	.byte	0x15
	.4byte	0xcd
	.uleb128 0x8
	.4byte	.LASF12
	.byte	0x5
	.4byte	0xf5
	.uleb128 0x9
	.4byte	0x3e
	.byte	0
	.uleb128 0x8
	.4byte	.LASF13
	.byte	0x2
	.4byte	0x105
	.uleb128 0x9
	.4byte	0xc6
	.byte	0
	.uleb128 0x8
	.4byte	.LASF14
	.byte	0x1
	.4byte	0x115
	.uleb128 0x9
	.4byte	0x115
	.byte	0
	.uleb128 0x3
	.4byte	0x121
	.uleb128 0x1
	.byte	0x1
	.byte	0x8
	.4byte	.LASF15
	.uleb128 0x2
	.4byte	0x11a
	.uleb128 0xe
	.4byte	.LASF18
	.byte	0x52
	.8byte	.LFB2
	.8byte	.LFE2-.LFB2
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x193
	.uleb128 0xa
	.4byte	.LASF16
	.byte	0x52
	.byte	0x1c
	.4byte	0x193
	.4byte	.LLST6
	.uleb128 0xa
	.4byte	.LASF17
	.byte	0x52
	.byte	0x2e
	.4byte	0x198
	.4byte	.LLST7
	.uleb128 0x14
	.4byte	.LASF21
	.byte	0x1
	.byte	0x55
	.byte	0x16
	.4byte	0x1ad
	.byte	0x10
	.uleb128 0x9
	.byte	0x3
	.8byte	index.0
	.uleb128 0x15
	.8byte	.LVL29
	.4byte	0x105
	.uleb128 0x4
	.uleb128 0x1
	.byte	0x5a
	.uleb128 0x9
	.byte	0x3
	.8byte	.LC2
	.byte	0
	.byte	0
	.uleb128 0x3
	.4byte	0x99
	.uleb128 0x3
	.4byte	0x39
	.uleb128 0x5
	.4byte	0xc1
	.4byte	0x1ad
	.uleb128 0x6
	.4byte	0x82
	.byte	0xf
	.byte	0
	.uleb128 0x2
	.4byte	0x19d
	.uleb128 0xe
	.4byte	.LASF19
	.byte	0x3a
	.8byte	.LFB1
	.8byte	.LFE1-.LFB1
	.uleb128 0x1
	.byte	0x9c
	.4byte	0x253
	.uleb128 0x16
	.string	"a"
	.byte	0x1
	.byte	0x3a
	.byte	0x15
	.4byte	0x253
	.4byte	.LLST3
	.uleb128 0xf
	.4byte	.LLRL4
	.uleb128 0x10
	.string	"i"
	.byte	0x3b
	.byte	0xe
	.4byte	0xba
	.4byte	.LLST5
	.uleb128 0xb
	.8byte	.LVL22
	.4byte	0x105
	.4byte	0x20d
	.uleb128 0x4
	.uleb128 0x1
	.byte	0x5a
	.uleb128 0x9
	.byte	0x3
	.8byte	.LC0
	.byte	0
	.uleb128 0xb
	.8byte	.LVL23
	.4byte	0xf5
	.4byte	0x225
	.uleb128 0x4
	.uleb128 0x1
	.byte	0x5a
	.uleb128 0x2
	.byte	0x78
	.sleb128 0
	.byte	0
	.uleb128 0xb
	.8byte	.LVL24
	.4byte	0x105
	.4byte	0x244
	.uleb128 0x4
	.uleb128 0x1
	.byte	0x5a
	.uleb128 0x9
	.byte	0x3
	.8byte	.LC1
	.byte	0
	.uleb128 0x17
	.8byte	.LVL26
	.4byte	0xe5
	.byte	0
	.byte	0
	.uleb128 0x3
	.4byte	0x2e
	.uleb128 0x18
	.4byte	.LASF22
	.byte	0x1
	.byte	0x1a
	.byte	0x6
	.8byte	.LFB0
	.8byte	.LFE0-.LFB0
	.uleb128 0x1
	.byte	0x9c
	.uleb128 0xa
	.4byte	.LASF16
	.byte	0x1a
	.byte	0x1b
	.4byte	0x193
	.4byte	.LLST0
	.uleb128 0x19
	.4byte	.LASF17
	.byte	0x1
	.byte	0x1a
	.byte	0x2d
	.4byte	0x198
	.uleb128 0x1
	.byte	0x5b
	.uleb128 0x1a
	.string	"x"
	.byte	0x1
	.byte	0x22
	.byte	0x9
	.4byte	0x72
	.uleb128 0x3
	.byte	0x91
	.sleb128 -160
	.uleb128 0x10
	.string	"i"
	.byte	0x23
	.byte	0x9
	.4byte	0xba
	.4byte	.LLST1
	.uleb128 0xf
	.4byte	.LLRL2
	.uleb128 0x1b
	.string	"i"
	.byte	0x1
	.byte	0x25
	.byte	0xe
	.4byte	0xba
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.uleb128 0x1
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0xe
	.byte	0
	.byte	0
	.uleb128 0x2
	.uleb128 0x26
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x3
	.uleb128 0xf
	.byte	0
	.uleb128 0xb
	.uleb128 0x21
	.sleb128 8
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x4
	.uleb128 0x49
	.byte	0
	.uleb128 0x2
	.uleb128 0x18
	.uleb128 0x7e
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x5
	.uleb128 0x1
	.byte	0x1
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x6
	.uleb128 0x21
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2f
	.uleb128 0xb
	.byte	0
	.byte	0
	.uleb128 0x7
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x8
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 5
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 6
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x3c
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x9
	.uleb128 0x5
	.byte	0
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xa
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0xb
	.uleb128 0x48
	.byte	0x1
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xc
	.uleb128 0x16
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 2
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xd
	.uleb128 0xd
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 2
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xe
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0x21
	.sleb128 6
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0xf
	.uleb128 0xb
	.byte	0x1
	.uleb128 0x55
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x10
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0x21
	.sleb128 1
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x11
	.uleb128 0x11
	.byte	0x1
	.uleb128 0x25
	.uleb128 0xe
	.uleb128 0x13
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x1f
	.uleb128 0x1b
	.uleb128 0x1f
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x10
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x12
	.uleb128 0x17
	.byte	0x1
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x1
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x13
	.uleb128 0x24
	.byte	0
	.uleb128 0xb
	.uleb128 0xb
	.uleb128 0x3e
	.uleb128 0xb
	.uleb128 0x3
	.uleb128 0x8
	.byte	0
	.byte	0
	.uleb128 0x14
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x88
	.uleb128 0xb
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x15
	.uleb128 0x48
	.byte	0x1
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x82
	.uleb128 0x19
	.uleb128 0x7f
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x16
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x17
	.byte	0
	.byte	0
	.uleb128 0x17
	.uleb128 0x48
	.byte	0
	.uleb128 0x7d
	.uleb128 0x1
	.uleb128 0x7f
	.uleb128 0x13
	.byte	0
	.byte	0
	.uleb128 0x18
	.uleb128 0x2e
	.byte	0x1
	.uleb128 0x3f
	.uleb128 0x19
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x27
	.uleb128 0x19
	.uleb128 0x11
	.uleb128 0x1
	.uleb128 0x12
	.uleb128 0x7
	.uleb128 0x40
	.uleb128 0x18
	.uleb128 0x7a
	.uleb128 0x19
	.byte	0
	.byte	0
	.uleb128 0x19
	.uleb128 0x5
	.byte	0
	.uleb128 0x3
	.uleb128 0xe
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1a
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.uleb128 0x2
	.uleb128 0x18
	.byte	0
	.byte	0
	.uleb128 0x1b
	.uleb128 0x34
	.byte	0
	.uleb128 0x3
	.uleb128 0x8
	.uleb128 0x3a
	.uleb128 0xb
	.uleb128 0x3b
	.uleb128 0xb
	.uleb128 0x39
	.uleb128 0xb
	.uleb128 0x49
	.uleb128 0x13
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_loclists,"",@progbits
	.4byte	.Ldebug_loc3-.Ldebug_loc2
.Ldebug_loc2:
	.2byte	0x5
	.byte	0x8
	.byte	0
	.4byte	0
.Ldebug_loc0:
.LLST6:
	.byte	0x4
	.uleb128 .LVL27-.Ltext0
	.uleb128 .LVL28-.Ltext0
	.uleb128 0x1
	.byte	0x5a
	.byte	0x4
	.uleb128 .LVL28-.Ltext0
	.uleb128 .LFE2-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x5a
	.byte	0x9f
	.byte	0
.LLST7:
	.byte	0x4
	.uleb128 .LVL27-.Ltext0
	.uleb128 .LVL29-1-.Ltext0
	.uleb128 0x1
	.byte	0x5b
	.byte	0x4
	.uleb128 .LVL29-1-.Ltext0
	.uleb128 .LFE2-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x5b
	.byte	0x9f
	.byte	0
.LLST3:
	.byte	0x4
	.uleb128 .LVL20-.Ltext0
	.uleb128 .LVL21-.Ltext0
	.uleb128 0x1
	.byte	0x5a
	.byte	0x4
	.uleb128 .LVL21-.Ltext0
	.uleb128 .LFE1-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x5a
	.byte	0x9f
	.byte	0
.LLST5:
	.byte	0x4
	.uleb128 .LVL20-.Ltext0
	.uleb128 .LVL21-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL21-.Ltext0
	.uleb128 .LVL25-.Ltext0
	.uleb128 0x1
	.byte	0x58
	.byte	0x4
	.uleb128 .LVL25-.Ltext0
	.uleb128 .LVL26-.Ltext0
	.uleb128 0x3
	.byte	0x78
	.sleb128 -1
	.byte	0x9f
	.byte	0
.LLST0:
	.byte	0x4
	.uleb128 .LVL0-.Ltext0
	.uleb128 .LVL1-.Ltext0
	.uleb128 0x1
	.byte	0x5a
	.byte	0x4
	.uleb128 .LVL1-.Ltext0
	.uleb128 .LVL2-.Ltext0
	.uleb128 0x1
	.byte	0x68
	.byte	0x4
	.uleb128 .LVL2-.Ltext0
	.uleb128 .LVL3-.Ltext0
	.uleb128 0x4
	.byte	0xa3
	.uleb128 0x1
	.byte	0x5a
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL3-.Ltext0
	.uleb128 .LFE0-.Ltext0
	.uleb128 0x1
	.byte	0x68
	.byte	0
.LLST1:
	.byte	0x4
	.uleb128 .LVL3-.Ltext0
	.uleb128 .LVL4-.Ltext0
	.uleb128 0x2
	.byte	0x30
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL4-.Ltext0
	.uleb128 .LVL5-.Ltext0
	.uleb128 0x2
	.byte	0x31
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL5-.Ltext0
	.uleb128 .LVL6-.Ltext0
	.uleb128 0x2
	.byte	0x32
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL6-.Ltext0
	.uleb128 .LVL7-.Ltext0
	.uleb128 0x2
	.byte	0x33
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL7-.Ltext0
	.uleb128 .LVL8-.Ltext0
	.uleb128 0x2
	.byte	0x34
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL8-.Ltext0
	.uleb128 .LVL9-.Ltext0
	.uleb128 0x2
	.byte	0x35
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL9-.Ltext0
	.uleb128 .LVL10-.Ltext0
	.uleb128 0x2
	.byte	0x36
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL10-.Ltext0
	.uleb128 .LVL11-.Ltext0
	.uleb128 0x2
	.byte	0x37
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL11-.Ltext0
	.uleb128 .LVL12-.Ltext0
	.uleb128 0x2
	.byte	0x38
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL12-.Ltext0
	.uleb128 .LVL13-.Ltext0
	.uleb128 0x2
	.byte	0x39
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL13-.Ltext0
	.uleb128 .LVL14-.Ltext0
	.uleb128 0x2
	.byte	0x3a
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL14-.Ltext0
	.uleb128 .LVL15-.Ltext0
	.uleb128 0x2
	.byte	0x3b
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL15-.Ltext0
	.uleb128 .LVL16-.Ltext0
	.uleb128 0x2
	.byte	0x3c
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL16-.Ltext0
	.uleb128 .LVL17-.Ltext0
	.uleb128 0x2
	.byte	0x3d
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL17-.Ltext0
	.uleb128 .LVL18-.Ltext0
	.uleb128 0x2
	.byte	0x3e
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL18-.Ltext0
	.uleb128 .LVL19-.Ltext0
	.uleb128 0x2
	.byte	0x3f
	.byte	0x9f
	.byte	0x4
	.uleb128 .LVL19-.Ltext0
	.uleb128 .LFE0-.Ltext0
	.uleb128 0x2
	.byte	0x40
	.byte	0x9f
	.byte	0
.Ldebug_loc3:
	.section	.debug_aranges,"",@progbits
	.4byte	0x2c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x8
	.byte	0
	.2byte	0
	.2byte	0
	.8byte	.Ltext0
	.8byte	.Letext0-.Ltext0
	.8byte	0
	.8byte	0
	.section	.debug_rnglists,"",@progbits
.Ldebug_ranges0:
	.4byte	.Ldebug_ranges3-.Ldebug_ranges2
.Ldebug_ranges2:
	.2byte	0x5
	.byte	0x8
	.byte	0
	.4byte	0
.LLRL2:
	.byte	0x4
	.uleb128 .LBB2-.Ltext0
	.uleb128 .LBE2-.Ltext0
	.byte	0x4
	.uleb128 .LBB3-.Ltext0
	.uleb128 .LBE3-.Ltext0
	.byte	0x4
	.uleb128 .LBB4-.Ltext0
	.uleb128 .LBE4-.Ltext0
	.byte	0
.LLRL4:
	.byte	0x4
	.uleb128 .LBB5-.Ltext0
	.uleb128 .LBE5-.Ltext0
	.byte	0x4
	.uleb128 .LBB6-.Ltext0
	.uleb128 .LBE6-.Ltext0
	.byte	0
.Ldebug_ranges3:
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF20:
	.string	"GNU C17 14.2.0 -mcmodel=medany -mabi=lp64d -mtune=rocket -misa-spec=20191213 -march=rv64imafdcv_zicsr_zifencei_zbb_zvbb_zve32f_zve32x_zve64d_zve64f_zve64x_zvkb_zvl128b_zvl32b_zvl64b -g -O3 -fno-builtin"
.LASF19:
	.string	"print_vec"
.LASF11:
	.string	"uintptr_t"
.LASF10:
	.string	"__uintptr_t"
.LASF14:
	.string	"print_s"
.LASF22:
	.string	"chacha20"
.LASF3:
	.string	"unsigned char"
.LASF17:
	.string	"input"
.LASF4:
	.string	"long unsigned int"
.LASF8:
	.string	"short unsigned int"
.LASF13:
	.string	"print_long"
.LASF2:
	.string	"unsigned int"
.LASF15:
	.string	"char"
.LASF5:
	.string	"chacha_buf"
.LASF21:
	.string	"index"
.LASF7:
	.string	"short int"
.LASF12:
	.string	"print_hex32"
.LASF16:
	.string	"output"
.LASF9:
	.string	"long int"
.LASF18:
	.string	"chacha20v"
.LASF6:
	.string	"signed char"
	.section	.debug_line_str,"MS",@progbits,1
.LASF1:
	.string	"/home/yyc/hachathon/chacha20-xiangshan"
.LASF0:
	.string	"chacha20_c.c"
	.ident	"GCC: () 14.2.0"
	.section	.note.GNU-stack,"",@progbits
