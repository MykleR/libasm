extern ft_strlen: proc
extern ft_strcpy: proc
global ft_strdup

%include "utils.s"

section .text

ft_strdup:
		STACK_SET
		call		ft_strlen			; ft_strlen(src)
		inc			rax					; len + 1 for '\0'
		MALLOC		rax					; malloc call macro wrapper (saves rdi)
		test		rax, rax			; if (rax == NULL) malloc failed
		jz			.error
		mov			rsi, rdi			; src = rdi
		mov			rdi, rax			; dst = rax
		call		ft_strcpy			; ft_strcpy(dst, src)
		STACK_RET
.error:
		xor			rax, rax			; return NULL
		ERRNO_SET	ENOMEN
		STACK_RET
