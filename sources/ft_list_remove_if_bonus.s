extern free: proc
global ft_list_remove_if

%include "utils.s"

section .text

ft_list_remove_if:
	STACK_SET
	test	rdi,rdi		; if (head == NULL)ret
	jz		.done
	test	rdx,rdx		; if (cmp == NULL)ret
	jz		.done
	mov		r15, rcx	; Save free_fct
	mov		r14, rdx	; Save cmp
	mov		r13, rsi	; Save data_ref
	mov		r12, rdi	; Save head

.loop_start:
	mov		r8, [r12]
	test	r8, r8
	jz		.done
	mov		rdi, [r8]
	mov		rsi, r13
	call	r14
	test	rax,rax
	jnz		.loop_nofree
	mov		r8, [r12]
	mov		r9, [r8 + 8]
	mov		[r12], r9
	test	r15, r15
	jz		.loop_free
	mov		rdi, [r8]
	call	r15
.loop_free:
	mov		rdi, r8
	call	free wrt ..plt
	jmp	.loop_start

.loop_nofree:
	mov		r12, [r12]
	lea		r12, [r12 + 8]
	jmp		.loop_start

.done:
	STACK_RET
