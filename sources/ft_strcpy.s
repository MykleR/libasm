global ft_strcpy

%include "utils.inc"

section .text

ft_strcpy:
		STACK_SET
		mov			rax, rdi				; ret = dst (saves 1st arg)
		jmp			.cond
.loop:	mov			[rdi], cl				; *dst = *src
		inc			rsi						; src++
		inc			rdi						; dst++
.cond:	movzx		rcx, byte [rsi]			; c = (unsigned char)(*src)
		test		cl, cl					; c != '\0'
		jnz			.loop
.done:	mov			byte [rdi], 0x0			; *dst = '\0'
		STACK_RET							; return dst (saved at start)
