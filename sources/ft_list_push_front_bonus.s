extern malloc: proc
global ft_list_push_front

section .text

ft_list_push_front:
	; Parameters:
	; RDI: pointer to the pointer of the head of the list (t_list **head)
	; RSI: pointer to the data to be added as a node (void *data)

	; Check if new_node or head is NULL
	test	rdi, rdi                ; Test if head pointer is NULL
	jz      .done                   ; If NULL, do nothing and return
	test    rsi, rsi                ; Test if data is NULL
	jz      .done                   ; If NULL, do nothing and return

	; Allocate memory for new node
	push	rdi						; Save head pointer on stack
	push	rsi						; Save data pointer on stack
	mov     rdi, 16					; Size of t_list struct (assuming 64-bit pointers)
	call    malloc wrt ..plt        ; Call malloc to allocate memory
	pop     rsi                     ; Restore data pointer from stack
	pop     rdi                     ; Restore head pointer from stack
	test    rax, rax                ; Check if malloc succeeded
	jz      .done                   ; If NULL, do nothing and return
	; Set up new node
	mov     [rax], rsi              ; new_node->data = data
	mov		rsi, [rdi]				; Address of new_node->next
	mov		[rax + 8], rsi			; new_node->next = (*head);
	mov		[rdi], rax				; *(head) = new_node;
.done:
	ret
