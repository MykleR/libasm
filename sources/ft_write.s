global ft_write

%include "utils.s"

section .text

ft_write:
		mov			rax, 1			; write syscall code is 1
		syscall
		test		rax, rax		; ret < 0 ? (error check)
		jl			.error
		ret
.error:
		neg			rax				; errno > 0
		ERRNO_SET	rax				; errno = rax
		mov			rax, -1
		ret
