
global ft_strcmp

section .text

ft_strcmp:
	xor rax, rax
.loop:
	movzx rax, byte [rdi]
	cmp al, byte [rsi]
	jne .done
	test al, al
	je .done
	inc rdi
	inc rsi
	jmp .loop
.done:
	movzx rcx, byte[rsi]
	sub rax, rcx
	ret
