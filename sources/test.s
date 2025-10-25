;; intel_syntax
global _start

_start:
	jmp _end

_end:
	mov rax, 60
	mov rdi, 1
	syscall
