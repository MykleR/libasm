%ifndef UTILS_S
%define UTILS_S

extern malloc: proc
extern __errno_location

ENOMEM equ 12
SIZEOF_LIST equ 16

%macro STACK_SET 0
	push_all	rbx, r12, r13, r14, r15, rbp
	mov			rbp, rsp
	sub			rsp, 8
%endm

%macro STACK_RET 0
	mov			rsp, rbp
	pop_all		rbp, r15, r14, r13, r12, rbx
	ret
%endm

%macro MALLOC 1
	push_all	rdi, rsi, %1
	pop			rdi
	call		malloc wrt ..plt
	pop_all		rsi, rdi
%endm

%macro ERRNO_SET 1
	push_all	rax, rcx, %1
	pop			rcx
	call		__errno_location wrt ..plt
	mov			[rax], rcx
	pop_all		rcx, rax
%endm

%macro push_all 1-*
    %rep %0             ; Repeat %0 times
        push %1         ; Push current argument
        %rotate 1       ; Next argument
    %endrep
%endmacro

%macro pop_all 1-*
    %rep %0
        pop %1
        %rotate 1
    %endrep
%endmacro

%macro ZERO_MEM 2
    pushfq
	push_all rax, rcx, rdi, %1, %2

    pop rcx
    pop rdi

    xor eax, eax
    cld
    rep stosb

	pop_all rdi, rcx, rax
    popfq
%endmacro

%endif
