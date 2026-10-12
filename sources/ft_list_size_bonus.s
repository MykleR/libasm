global ft_list_size

%include "utils.inc"

section .text

ft_list_size:
		STACK_SET
		mov		rax, -1
.loop:	inc		rax
		test	rdi, rdi
		jz		.done
		mov		rdi, [rdi + 8]
		jmp		.loop
.done:	STACK_RET
