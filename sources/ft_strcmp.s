global ft_strcmp

%include "utils.inc"

section .text

ft_strcmp:
		STACK_SET
		jmp			.cond
.loop:
		inc			rdi					; s1++
		inc			rsi					; s2++
.cond:	movzx		rax, byte [rdi]
		cmp			al, byte [rsi]		; *s1 != *s2
		jne			.done
		test		al, al				; *s1 != '\0'
		jnz			.loop
.done:	movzx		rcx, byte[rsi]
		sub			rax, rcx			; return *s1 - *s2
		STACK_RET
