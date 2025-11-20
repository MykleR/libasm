global ft_atoi_base

section .text

%macro ALLOC_ZERO_STACK 1
    ; Allocates %1 bytes on the stack and zeros them with rep stosb.
    ; Clobbers: rcx, al; caller must preserve if needed.
    sub     rsp, %1
    mov     rcx, %1
	push	rdi
    lea     rdi, [rsp]
    xor     al, al
    cld
    rep     stosb
	pop		rdi
%endmacro

%macro LOT_CHECK 2
	cmp		byte [%1], 0
	jnz		%2
%endmacro

ft_check_base:
.init_array:
	ALLOC_ZERO_STACK 256	; Allocate 256 bytes on stack and zero them
   	mov		rax, rsi		; Copy pointer to char *base
   	jmp		.loop_cond
.loop_body:
   	mov		byte [rsp + rcx], 1
    inc		rax
.loop_cond:
	movzx	rcx, byte [rax]
	cmp		byte [rsp + rcx], 0
	jnz		.fail
	test	cl, cl
	jnz		.loop_body
.loop_end:
	sub		rax, rsi
	cmp		rax, 2
	jl		.fail
	LOT_CHECK rsp + '+', .fail
	LOT_CHECK rsp + '-', .fail
	LOT_CHECK rsp + ' ', .fail
	LOT_CHECK rsp + 9, .fail	;\r
	LOT_CHECK rsp + 10, .fail	;\n
	LOT_CHECK rsp + 11, .fail	;\t
	LOT_CHECK rsp + 12, .fail	;\v
	LOT_CHECK rsp + 13, .fail	;\f
	add		rsp, 256	; Clear Stack
	ret
.fail:
	add		rsp, 256	; Clear Stack
	xor		rax, rax
	ret

ft_atoi_base:
	call ft_check_base
	ret
