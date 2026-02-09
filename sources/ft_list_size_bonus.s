global ft_list_size

section .text

ft_list_size:
		mov		rax, -1
.loop:	inc		rax
		test	rdi, rdi
		jz		.done
		mov		rdi, [rdi + 8]
		jmp		.loop
.done:	ret
