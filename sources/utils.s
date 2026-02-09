
%macro STACK_SET 0
	push	rbx
	push	r12
	push	r13
	push	r14
	push	r15
	push	rbp
	mov		rbp, rsp
%endm

%macro STACK_RET 0
	pop		rbp
	pop		r15
	pop		r14
	pop		r13
	pop		r12
	pop		rbx
	ret
%endm
