global ft_atoi_base

section .text

; ft_check_base:
;	Clobbers rax, rdx, r8, r9
; @param RSI: Pointer to the null-terminated base string.
; @return RAX: 0 if the base is invalid.
;              The length of the base (>1) if it is valid.
ft_check_base:
.init_array:
			xor			rdx, rdx
			sub			rsp, 32
			mov			rax, 0x280100003e00		; Magic mask for forbidden chars
			mov			qword [rsp], rax		; Init with mask, flags: + - (space) \r \f \v \n \t
			mov			qword [rsp + 0x8], 0
			mov			qword [rsp + 0x10], 0
			mov			qword [rsp + 0x18], 0
   			mov			rax, rsi				; rax = current pointer
.loop_check:
			movzx		r8, byte [rax]			; Load char into 64-bit register
			test		r8b, r8b				; \0 End of string reached ?
			jz			.loop_end
			bts			[rsp], r8				; Test and set the bit
			jc			.done					; CF=1 if bit was set (duplicate or forbidden)
			inc			rax
			jmp			.loop_check
.loop_end:	sub			rax, rsi				; Calculate length
			cmp			rax, 2					; Compare length with 2
.done:		cmovc		rax, rdx				; If jumped via: 'jc' duplicate, or: 'cmp' len < 2, set to 0
			add			rsp, 32
			ret

ft_skip_empty:
			mov			r9, 0x100003e00			; MASK for [space], \t, \n, \r, \v, \f
.loop:		movzx		r8, byte [rdi]
			cmp			r8, 32					; Check if char > 32
			jg			.done					; If > 32, safe from modulo collision
			bt			r9, r8
			jnc			.done
			inc			rdi
			jmp			.loop
.done:		ret

ft_get_sign:
			xor			r10d, r10d
			jmp			.check
.negative:	inc			r10d					; Count +1 minus
.positive:	inc			rdi						; Next character
.check:		cmp			byte [rdi], '+'         ; Is it '+'?
			je			.positive				; Yes, continue next character
			cmp			byte [rdi], '-'			; Is it '-'?
			je			.negative				; Yes, continue next and inc r10d
.done:		and			r10d, 1					; 1 means negative and 0 positive
			neg			r10d					; 0 -> 0, 1 -> -1 (0xFF...FF)
			ret

ft_atoi_base:
			call		ft_check_base
			test		rax, rax
			jz			.fail
			call		ft_skip_empty
			call		ft_get_sign
			mov			r8, rax
			xor			rax, rax
.atoi:
			cmp			byte [rdi], 0
			je			.done
			mov			r9, -1					; Index in base, used after in calcul
			mov			r11b, byte [rdi]		; ...
.schbase:	inc			r9						; Loop
			cmp			byte [rsi + r9], r11b	; Character found in base ?
			je			.calcul					; Yes -> update result
			cmp			byte [rsi + r9], 0		; Reached end of string base ?
			je			.done					; Yes -> not in base, done.
			jmp			.schbase				; No  -> continue loop
.calcul:
			imul		rax, r8					; rax = rax * base_len + char_index
			add			rax, r9					; ...
			inc			rdi
			jmp			.atoi
.done:		xor			rax, r10				; If neg: invert bits (One's Complement)
			sub			rax, r10				; If neg: add 1 (Complete Two's Complement) subtracting -1 <=> adding 1
			ret
.fail:		xor			rax, rax
			ret
