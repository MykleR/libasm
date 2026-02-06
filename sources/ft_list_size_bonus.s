global ft_list_size

section .text

ft_list_size:
	xor		rax, rax
	jmp		.check_end
.count_up:
	inc		rax
	mov		rdi, [rdi + 8]
.check_end:
	test	rdi, rdi
	jnz		.count_up
	ret
