global ft_list_sort

section .text

%macro SET_STACK 0
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

ft_list_sort:
			SET_STACK
			mov			r15, rsi			; Save int (*cmp)()
			test		rdi, rdi			; if (head == NUL) ret
			jz			.done
			test		rsi, rsi			; if (cmp == NULL) ret
			jz			.done
			mov			r14, [rdi]			; t_list *inner = *head;
.outer_loop:test		r14, r14			; if (inner == NULL) break
			jz			.done
			mov			r13, [r14 + 8]		; t_list *outer = inner->next;
.inner_loop:test		r13, r13			; if (outer == NULL) break
			jz			.outer_next
			mov			rdi, [r14]			; void *rdi = outer->data;
			mov			rsi, [r13]			; void *rsi = inner->data;
			call		r15					; int eax = cmp(rdi, rsi)
			test		eax, eax			; if (eax <= 0) no swap
			jle			.inner_next
			mov			r8, [r14]			; void *tmp1 = outer->data;
			mov			r9, [r13]			; void *tmp2 = inner->data;
			mov			[r14], r9			; outer->data = tmp2;
			mov			[r13], r8			; inner->data = tmp1;
.inner_next:mov			r13, [r13 + 8]		; inner = inner->next;
			jmp			.inner_loop
.outer_next:mov			r14, [r14 + 8]		; outer = outer->next;
			jmp			.outer_loop
.done:		STACK_RET
