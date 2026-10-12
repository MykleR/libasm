global ft_write

%include "utils.inc"

section .text

ft_write:
		STACK_SET
		mov			rax, 1			; write syscall code is 1
		syscall
		test		rax, rax		; ret < 0 ? (error check)
		jl			.error
		STACK_RET
.error:
		neg			rax				; errno > 0
		ERRNO_SET	rax				; errno = rax
		mov			rax, -1
		STACK_RET
