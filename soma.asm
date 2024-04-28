section .data
	
	msg1 db "Digite o numero 1: "
	tmsg1 equ $ - msg1
	
	msg2 db "Digite o numero 2: "
	tmsg2 equ $ - msg2
	
	msg5 db "Resultado: "
	tmsg3 equ $ - msg3
	
	
section .bss

	n1 resb 1
	n2 resb 1 
	r resb 1

section .text

global _start

_start:

  ; Digite o numero 1
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
	; n1 vale alguma coisa agora

 ; Digite o numero 2
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
  ; n2 vale alguma coisa agora
	
	;--------- soma ----------
	
	mov r8,  [n1]
	mov r9,  [n2]
	
	sub r8,  '0' ; tira o 0011 do ascii do numero, agora só tem o binário
	sub r9,  '0'
		
	add r8, r9 ;soma o conteúdo de r9 com o conteúdo de r8, ou seja r8 <- r9
	
	add r8, '0' ; volta o 0011 para o binário, transformando em ascii
	
	mov [r], r8 ; joga o resultado na variavel de resultado
	;--------- fim soma --------
	
	mov rax, 4
	mov rbx, 1
	mov rcx, msg3
	mov rdx, tmsg3
	int 0x80
	
	mov rax, 4
	mov rbx, 1
	mov rcx, r ; apresenta o resultado
	mov rdx, 1
	int 0x80
	
	mov rax, 4
	mov rbx, 1
	mov [rcx], byte 0xa ; Faz a quebra de linha ao final do resultado
	mov rdx, 1
	int 0x80	
exit:

	mov rax, 1 
	int 0x80
