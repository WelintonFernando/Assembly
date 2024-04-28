section .data
	
	msg1 db "Digite valor A: "
	tmsg1 equ $ - msg1
	
	msg2 db "Digite valor B: "
	tmsg2 equ $ - msg2
	
	msg3 db "A + B = "
	tmsg3 equ $ - msg3
	
	msg4 db "A - B = "
	tmsg4 equ $ - msg4
	
	msg5 db "A x B = "
	tmsg5 equ $ - msg5
	
	msg6 db "A / B = "
	tmsg6 equ $ - msg6
	
	msg7 db "Resto = "
	tmsg7 equ $ - msg7
	
	
section .bss

  ; resq -> reserva uma quad-word, 64 bits.
	n1 resq 1
	n2 resq 1 

	rsoma resq 1
	rsub resq 1
	rmult resq 1
	rdiv resq 1
	resto resq 1

section .text

global _start

_start:

	; digite o valor A:
	
	mov rax, 4 ;saida padrao
	mov rbx, 1
	mov rcx, msg1
	mov rdx, tmsg1
	int 0x80
	
	mov rax, 3 ;entrada padrao
	mov rbx, 0
	mov rcx, n1
	mov rdx, 2
	int 0x80
	
	; digite o valor B:
	
	mov rax, 4
	mov rbx, 1
	mov rcx, msg2
	mov rdx, tmsg2
	int 0x80
	
	mov rax, 3 ;entrada padrao
	mov rbx, 0
	mov rcx, n2
	mov rdx, 2
	int 0x80
	
	;--------- soma ----------
	
	mov r9,  [n1]
	mov r10,  [n2]
	
	sub r9,  '0' ; tira o 0011 do ascii do numero, agora só tem o binário
	sub r10,  '0'
	
	add r9, r10
	
	add r9, '0'
	mov [rsoma], r9
		
	;--------- fim soma --------
	
	
	;--------- sub ----------
	
	mov r9,  [n1]
	mov r10,  [n2]
	
	sub r9,  '0' ; tira o 0011 do ascii do numero, agora só tem o binário
	sub r10,  '0'
	
	sub r9, r10
	
	add r9, '0'
	mov [rsub], r9
		
	;--------- fim sub --------
	
	
	;--------- mult ----------
	
	mov rax,  [n1]
	mov r9,  [n2]
	
	sub rax,  '0' ; tira o 0011 do ascii do numero, agora só tem o binário
	sub r9,  '0'
	mul r9
	
	add rax, '0'
	mov [rmult], rax
		
	;--------- fim mult --------
	
	;--------- div ----------
	
	mov rax, 0
	mov rbx, 0
	mov rcx, 0
	mov rdx, 0
	mov r10, 0
	
	mov rax,  [n1]
	mov r10,  [n2]
	
	sub rax,  0x0a30 ; tira o 0011 do ascii do numero e o enter
	sub r10,  0x0a30
	
	div r10
	
	add rax, 0x0a30
	add rdx, 0x0a30
	
	mov [rdiv], rax
	mov [resto], rdx
	
	;--------- fim div --------
	
	; A + B msg3 | rsoma
	; A - B msg4 | rsub
	; A x B msg5 | rmult
	; A / B msg6 | rdiv
	; resto msg7 | resto
	
	mov rax, 4
	mov rbx, 1
	mov rcx, msg3
	mov rdx, tmsg3
	int 0x80
	
	mov rax, 4
	mov rbx, 1
	mov rcx, rsoma
	mov rdx, 1
	int 0x80
	
	mov rax, 4
	mov rbx, 1
	mov [rcx], byte 0xa
	mov rdx, 1
	int 0x80
	
	;--------------------------	
	
	mov rax, 4
	mov rbx, 1
	mov rcx, msg4
	mov rdx, tmsg4
	int 0x80
	
	mov rax, 4
	mov rbx, 1
	mov rcx, rsub
	mov rdx, 1
	int 0x80
	
	mov rax, 4
	mov rbx, 1
	mov [rcx], byte 0xa
	mov rdx, 1
	int 0x80
	
	;--------------------------
	
	mov rax, 4
	mov rbx, 1
	mov rcx, msg5
	mov rdx, tmsg5
	int 0x80
	
	mov rax, 4
	mov rbx, 1
	mov rcx, rmult
	mov rdx, 1
	int 0x80
	
	mov rax, 4
	mov rbx, 1
	mov [rcx], byte 0xa
	mov rdx, 1
	int 0x80
	
	;--------------------------
	
	mov rax, 4
	mov rbx, 1
	mov rcx, msg6
	mov rdx, tmsg6
	int 0x80
	
	mov rax, 4
	mov rbx, 1
	mov rcx, rdiv
	mov rdx, 1
	int 0x80
	
	mov rax, 4
	mov rbx, 1
	mov [rcx], byte 0xa
	mov rdx, 1
	int 0x80
	
	;--------- Resto --------
	
	mov rax, 4
	mov rbx, 1
	mov rcx, msg7
	mov rdx, tmsg7
	int 0x80
	
	mov rax, 4
	mov rbx, 1
	mov rcx, resto
	mov rdx, 1
	int 0x80
	
	mov rax, 4
	mov rbx, 1
	mov [rcx], byte 0xa
	mov rdx, 1
	int 0x80
	
	;--------------------------
	
exit:

	mov rax, 1
	int 0x80
