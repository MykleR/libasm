global ft_simd_memchr

%include "utils.inc"

section .text

ft_simd_memchr:
	STACK_SET

	movdqu		xmm0, [rdi]			; Load 16 bytes from haystack 
	movd		xmm1, esi			; Load needle
	pxor		xmm2, xmm2			; Clear xmm2
	pshufb		xmm1, xmm2			; Broadcast needle across full xmm1
	pcmpeqb		xmm0, xmm1			; Compare haystack bytes with needle
	pmovmskb	eax, xmm0			; create a bitmask from the comparison result
	bsf			eax, eax			; Find the index of the first set bit (if any)
	jz			.not_found			; If no match found, jump to not_found
	add			rax, rdi				; Add the index to the base address of haystack
	STACK_RET
.not_found:
	xor			rax, rax				; Return NULL (0) if not found
	STACK_RET
