global ft_list_push_front

%include "utils.s"

section .text

; Parameters:
; RDI: pointer to the pointer of the head of the list (t_list **head)
; RSI: pointer to the data to be added as a node (void *data)
ft_list_push_front:
		STACK_SET
		test		rdi, rdi                ; Test if head pointer is NULL
		jz			.done                   ; If NULL, do nothing and return
		MALLOC		SIZEOF_LIST				; Allocate memory for new node
		test		rax, rax                ; Check if malloc succeeded
		jz			.done                   ; If NULL, do nothing and return
		mov			[rax], rsi              ; new_node->data = data
		mov			rsi, [rdi]				; Dereferencing head, rsi = *head
		mov			[rax + 8], rsi			; new_node->next = (*head);
		mov			[rdi], rax				; *(head) = new_node;
.done:	STACK_RET
