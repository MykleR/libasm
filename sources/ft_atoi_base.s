global ft_atoi_base

section .text

; ft_check_base:
;   Checks if a base string is valid for atoi_base.
;	Clobbers rax, rdx, r8, r9
;
; @param RSI: Pointer to the null-terminated base string.
;
; @return RAX: 0 if the base is invalid.
;              The length of the base (>1) if it is valid.
ft_check_base:
.init_array:
	xor		rdx, rdx
    sub     rsp, 32
	mov		rax, 0x280100003e00		; Magic mask for forbidden chars
	mov		qword [rsp], rax		; Init with mask, flags: + - (space) \r \f \v \n \t
	mov		qword [rsp + 0x8], 0
	mov		qword [rsp + 0x10], 0
	mov		qword [rsp + 0x18], 0
   	mov		rax, rsi				; rax = current pointer
.loop_cond:
	movzx	r8, byte [rax]			; Load char into 64-bit register
	test	r8b, r8b				; \0 End of string reached ?
	jz		.loop_end
    bts     [rsp], r8				; Test and set the bit
    jc      .fail                   ; CF=1 if bit was set (duplicate or forbidden)
    inc		rax
	jmp		.loop_cond
.loop_end:
	sub		rax, rsi				; Calculate length
	cmp		rax, 2					; Compare length with 2
.fail:
    ; If we jumped here via 'jc' (duplicate found), CF is 1.
    ; If we fell through via 'cmp' (len < 2), CF is 1.
    ; If we fell through via 'cmp' (len >= 2), CF is 0.
	cmovc	rax, rdx
	add		rsp, 32
	ret

ft_atoi_base:
	call ft_check_base
	ret
