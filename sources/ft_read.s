global ft_read

%include "utils.s"

section .text

ft_read:
		xor			rax, rax					; read syscall code is 0
		syscall
		test		rax, rax					; ret < 0 ? (error check)
		jl			.error
		ret
.error:
		neg			rax							; errno > 0
		ERRNO_SET	rax
		mov			rax, -1
		ret
