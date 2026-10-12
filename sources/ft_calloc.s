global ft_calloc

%include "utils.inc"

section .text

ft_calloc:
		STACK_SET
		mov			rax, rdi			; rax = nmemb
		mul			rsi					; rax = nmemb * size
		jo			.error				; if (overflow) return NULL
		jc			.error				; if (carry) return NULL
		mov			rdi, rax			; rdi = nmemb * size
		MALLOC		rdi					; malloc call macro wrapper (saves rdi)
		test		rax, rax			; if (rax == NULL) malloc failed
		jz			.error
		ZERO_MEM	rax, rdi			; zero out the allocated memory
		STACK_RET
.error:
		ERRNO_SET	ENOMEM
		xor			rax, rax			; return NULL
		STACK_RET
