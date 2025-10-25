global test

section .text

test:
	push rbp
	mov rbp, rsp
	mov eax, edi
	add eax, esi
	mov [rbp-0x4], eax
	pop rbp
	ret
