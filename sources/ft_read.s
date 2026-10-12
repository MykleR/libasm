global ft_read

%include "utils.inc"

section .text

ft_read:
		STACK_SET
		xor			rax, rax					; read syscall code is 0
		syscall
		test		rax, rax					; ret < 0 ? (error check)
		jl			.error
		STACK_RET
.error:
		neg			rax							; errno > 0
		ERRNO_SET	rax
		mov			rax, -1
		STACK_RET
