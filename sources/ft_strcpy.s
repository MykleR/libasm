
global ft_strcpy

section .text

ft_strcpy:
	xor rcx, rcx
	xor rax, rax
	mov rax, rdi
.loop:
	movzx rcx, byte [rsi]
	test cl, cl
	jz .done
	mov [rdi], cl
	inc rsi
	inc rdi
	jmp .loop
.done:
	mov [rdi], 0x0
	ret
