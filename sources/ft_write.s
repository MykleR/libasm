extern __errno_location
global ft_write

section .text

ft_write:
	mov		rax, 1						; write syscall code is 1
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
