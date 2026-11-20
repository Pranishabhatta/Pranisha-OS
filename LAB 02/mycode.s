	.arch armv8-a
	.file	"mycode.c"
	.text
	.section	.rodata
	.align	3
.LC0:
	.string	"function return:%d\n"
	.text
	.align	2
	.global	main
	.type	main, %function
main:
.LFB0:
	.cfi_startproc
	stp	x29, x30, [sp, -32]!
	.cfi_def_cfa_offset 32
	.cfi_offset 29, -32
	.cfi_offset 30, -24
	mov	x29, sp
	bl	hello
	str	w0, [sp, 28]
	ldr	w1, [sp, 28]
	adrp	x0, .LC0
	add	x0, x0, :lo12:.LC0
	bl	printf
	mov	w0, 0
	ldp	x29, x30, [sp], 32
	.cfi_restore 30
	.cfi_restore 29
	.cfi_def_cfa_offset 0
	ret
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.align	2
	.global	hello
	.type	hello, %function
hello:
.LFB1:
	.cfi_startproc
	mov	w0, 25
	ret
	.cfi_endproc
.LFE1:
	.size	hello, .-hello
	.ident	"GCC: (Ubuntu 15.2.0-16ubuntu1) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
