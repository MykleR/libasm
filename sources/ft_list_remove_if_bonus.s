extern free: proc
global ft_list_remove_if

%include "utils.s"

section .text

ft_list_remove_if:
			STACK_SET
			test		rdi,rdi			; if (head == NULL)ret
			jz			.done
			test		rdx,rdx			; if (cmp == NULL) ret
			jz			.done
			mov			r15, rcx		; Save free_fct
			mov			r14, rdx		; Save cmp
			mov			r13, rsi		; Save data_ref
			mov			r12, rdi		; Save head
.loop_start:mov			rbx, [r12]		; t_list *tmp = *head
			test		rbx, rbx			; if (tmp == NULL) break
			jz			.done
			mov			rdi, [rbx]		; rdi = tmp->data
			mov			rsi, r13		; rsi = data_ref
			call		r14				; cmp(tmp->data, data_ref)
			test		rax, rax		; if (rax != 0) -> next
			jnz			.loop_next
			mov			r9, [rbx + 8]	; next = tmp->next;
			mov			[r12], r9		; *head = next;
			test		r15, r15		; if (free_fct != NULL) free_fct()
			jz			.loop_free
			mov			rdi, [rbx]		; rdi = tmp->data;
			call		r15				; free_fct(tmp->data);
.loop_free: mov			rdi, rbx			; rdi = tmp;
			call		free wrt ..plt	; free(tmp);
			jmp			.loop_start
.loop_next:
			mov			r12, [r12]
			lea			r12, [r12 + 8]	; head = &(*head)->next
			jmp			.loop_start

.done:		STACK_RET
