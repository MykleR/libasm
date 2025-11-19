extern malloc: proc
extern ft_strlen: proc
extern ft_strcpy: proc
extern __errno_location
global ft_strdup

section .data
    ENOMEM equ 12

section .text

ft_strdup:

.strlen_call:
	call	ft_strlen			; ft_strlen(const char* src)
	inc		rax					; size + 1 for '\0'

.malloc_call:
	push	rdi					; saving src 1st arg on stack
	mov		rdi, rax			; ft_strlen output in rdi as 1st arg
	call	malloc wrt ..plt	; malloc(size_t bytes)

.malloc_test:
	pop		rsi					; retreive src as 2nd arg (rsi)
	test	rax, rax			; dst != NULL (malloc failed ?)
	jz		.error

.strcpy_call:
	mov		rdi, rax			; dst as 1st arg (rdi)
	call	ft_strcpy			; ft_strcpy(dst, src)
	ret							; return ft_strcpy output

.error:							; errno set
	call	__errno_location wrt ..plt
	mov		dword [rax], ENOMEM
	xor		rax, rax			; return NULL
	ret
