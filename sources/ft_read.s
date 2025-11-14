extern __errno_location
global ft_read

section .text

ft_read:
	push rbp
	mov rbp, rsp
	call __errno_location wrt ..plt
	mov dword [rax], 1
	mov rax, 0
	pop rbp
	ret
