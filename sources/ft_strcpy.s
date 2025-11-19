
global ft_strcpy

section .text

ft_strcpy:
	mov		rax, rdi		; ret = dst (saves 1st arg)
	jmp		.condition

.body:						; *dst++ = *src++
	mov		[rdi], cl
	inc		rsi
	inc		rdi

.condition:
	movzx	rcx, byte [rsi]	; c = (unsigned char)(*src)
	test	cl, cl			; c != '\0'
	jnz		.body

.done:
	mov		[rdi], 0x0		; *dst = '\0'
	ret						; return dst (saved at start)
