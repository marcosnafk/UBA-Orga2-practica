extern malloc
extern free
extern fprintf

section .data

section .text

global strCmp
global strClone
global strDelete
global strPrint
global strLen

; ** String **





; void strDelete(char* a)
strDelete:
	ret

; void strPrint(char* a, FILE* pFile)
strPrint:
	ret

; uint32_t strLen(char* a)
; char* a = rdi
strLen:
	push rbp
	mov rbp, rsp

	xor rax, rax
	xor rbx, rbx
	mov bl, [rdi]

	.tagWhile:
		cmp bl, 0
		je .tagReturn

		add rax, 1
		add rdi, 1
		mov bl, [rdi]
		jmp .tagWhile

	
	.tagReturn:

	pop rbp

	ret

; int32_t strCmp(char* a, char* b)
; rdi[a], rsi[b]
strCmp:
	push rbp
	mov rbp, rsp

	xor rax, rax
	xor rbx, rbx
	xor rcx, rcx
	xor rdx, rdx

	.tagWhile:
		;revisamos si estan ambos vacios
		mov cl, [rdi]
		mov bl, [rsi]
		or cl, bl
		cmp cl, 0
		je .tagReturn ; si ambos terminaron vamos a return

		; comparamos cada char
		mov cl, [rdi]
		mov dl, [rsi]
		cmp cl, dl

		; si es menor restamos y vamos a return
		jl .tagLesser; Jump short if less (SF≠ OF).

		; si es mayor sumamos y vamos a return
		jg .tagGreater; Jump short if greater (ZF=0 and SF=OF).

		add rdi, 1
		add rsi, 1
		jmp .tagWhile

		.tagLesser:
			mov rax, 1
			jmp .tagReturn
		
		.tagGreater:
			mov rax, -1
			jmp .tagReturn

	.tagReturn:

	pop rbp

	ret


; char* strClone(char* a)
; rax[el puntero nuevo] rdi[a]
strClone:
	push rbp
	mov rbp, RSP
	push R12
	push R13 ; alineado

	xor R12, R12 ; limpiamos R12 por las dudas
	mov R12, rdi ; guardamos strin source

	call strLen ; ya tenemos en rdi el char* que nos interesa
	; en rax o especificamente eax el int32 con el tamanio
	add rax, 1 ; sumamos 1 para el caracter vacio

	xor rdi, rdi ;limpiamos rdi 
	mov edi, eax ; movemos en primer parametro el tamanio para malloc
	; no limpiamos rax ya que el putnero son 8 bytes y escribiria todo el rax
	call malloc ; rax tenemos nuestor puntero reservado

	; empezamos a copiar el string
	; R12 tiene nuestro RDI inicial, o puntero a string a copiar
	mov rdi, rax ; usaremos rdi para avanzar en las posicones a escribir

	; rax = punter a retornar
	; rdi = puntero a string target, que  avanza
	; R12 = puntero al string source, que tambien avanzara

	xor rcx, rcx
	.tagWhile:
		mov cl, [R12] ; char source en cl
		cmp cl, 0
		je .tagReturn ; si char source es 0, terminamos de copiar

		mov [rdi], cl

		add R12, 1
		add rdi, 1
		jmp .tagWhile

	.tagReturn:
		; si estamos aca, es porque cl es 0
		mov [rdi], cl ; ponemos el 0 final del string target

	; en rax ya tenemos el puntero que reservamos con el string copiado a nuestro RDI de inicio

	pop R13
	pop R12
	pop rbp

	ret