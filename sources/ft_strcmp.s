
global ft_strcmp

section .text

ft_strcmp:
	jmp		.condition

.body:							; s1++, s2++;
	inc		rdi
	inc		rsi

.condition:
	movzx	rax, byte [rdi]
	cmp		al, byte [rsi]		; *s1 != *s2
	jne		.done
	test	al, al				; *s1 != '\0'
	jnz		.body

.done:
	movzx	rcx, byte[rsi]
	sub		rax, rcx			; return *s1 - *s2
	ret
