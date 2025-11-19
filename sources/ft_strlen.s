global ft_strlen

section .text

ft_strlen:
	mov		rax, -1				; counter starts at -1
.loop:
	inc		rax					; increment ret
	cmp		byte [rdi + rax], 0	; src[ret] != '\0' ?
	jne		.loop				; if so jump to start of loop
.done:
	ret
