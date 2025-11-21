global ft_atoi_base

section .text

ft_check_base:
.init_array:
    sub     rsp, 16
	mov		rax, 0x280100003e00		; Binary mask sets forbidden chars to 1 in lookup tab
	mov		qword [rsp], rax		; Init first half with mask
	mov		qword [rsp + 8], 0		; Init second half with zero
	xor		rdx, rdx
   	mov		rax, rsi				; Copy pointer to char *base
.loop_cond:
	movzx	r8, byte [rax]
    mov		r9, r8					; r9 = C
	test	r8b, r8b
	jz		.loop_end
    shr     r8, 3					; r8 = byte index
    and     r9, 7					; r9 = bit index
    bts     [rsp + r8], r9			; Test and set the bit
    jc      .fail                   ; If carry flag is set, it was a duplicate
    inc		rax
	jmp		.loop_cond
.loop_end:
	sub		rax, rsi
	cmp		rax, 2
.fail:
	cmovc	rax, rdx		; mov 0 in rax if less than 2
	add		rsp, 16
	ret

ft_atoi_base:
	call ft_check_base
	ret
