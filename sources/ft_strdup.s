extern malloc: proc
extern ft_strlen: proc
extern ft_strcpy: proc
extern __errno_location
global ft_strdup

section .data
    ENOMEM equ 12

section .text

ft_strdup:
	call ft_strlen
	inc rax
	push rdi
	mov rdi, rax
	call malloc wrt ..plt
	pop rsi
	test rax, rax
	jz .error
	mov rdi, rax
	call ft_strcpy
	ret
.error:
	call __errno_location wrt ..plt
	mov dword [rax], ENOMEM
	xor rax, rax
	ret
