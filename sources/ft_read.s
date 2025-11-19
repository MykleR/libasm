extern __errno_location
global ft_read

section .text

ft_read:
	xor		rax, rax					; read syscall code is 0
	syscall
	test	rax, rax					; ret < 0 ? (error check)
	jl		.error
	ret									; else returns syscall result

.error:
	neg		rax							; errno > 0
	mov		rdi, rax					; tmp = rax
	call	__errno_location wrt ..plt	; rax = pointer to errno
	mov		[rax], rdi					; *rax = tmp
	mov		rax, -1
	ret
