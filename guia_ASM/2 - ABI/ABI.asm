extern sumar_c
extern restar_c
extern multiplicarFloatsAInt32_c
extern multiplicarFloats_c
;########### SECCION DE DATOS
section .data

;########### SECCION DE TEXTO (PROGRAMA)
section .text

;########### LISTA DE FUNCIONES EXPORTADAS

global alternate_sum_4
global alternate_sum_4_using_c
global alternate_sum_4_using_c_alternative
global alternate_sum_8
global product_2_f
global product_9_f

;########### DEFINICION DE FUNCIONES
; uint32_t alternate_sum_4(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; parametros: 
; x1 --> EDI
; x2 --> ESI
; x3 --> EDX
; x4 --> ECX
alternate_sum_4:
  sub EDI, ESI
  add EDI, EDX
  sub EDI, ECX

  mov EAX, EDI
  ret

; uint32_t alternate_sum_4_using_c(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4);
; parametros: 
; x1 --> EDI
; x2 --> ESI
; x3 --> EDX
; x4 --> ECX
alternate_sum_4_using_c:
  ;prologo
  push RBP ;pila alineada
  mov RBP, RSP ;strack frame armado
  push R12
  push R13	; preservo no volatiles, al ser 2 la pila queda alineada

  mov R12D, EDX ; guardo los parámetros x3 y x4 ya que están en registros volátiles
  mov R13D, ECX ; y tienen que sobrevivir al llamado a función

  call restar_c 
  ;recibe los parámetros por EDI y ESI, de acuerdo a la convención, y resulta que ya tenemos los valores en esos registros
  
  mov EDI, EAX ;tomamos el resultado del llamado anterior y lo pasamos como primer parámetro
  mov ESI, R12D
  call sumar_c

  mov EDI, EAX
  mov ESI, R13D
  call restar_c

  ;el resultado final ya está en EAX, así que no hay que hacer más nada

  ;epilogo
  pop R13 ;restauramos los registros no volátiles
  pop R12
  pop RBP ;pila desalineada, RBP restaurado, RSP apuntando a la dirección de retorno
  ret


alternate_sum_4_using_c_alternative:
  ;prologo
  push RBP ;pila alineada
  mov RBP, RSP ;strack frame armado
  sub RSP, 16 ; muevo el tope de la pila 8 bytes para guardar x4, y 8 bytes para que quede alineada

  mov [RBP-8], RCX ; guardo x4 en la pila

  push RDX  ;preservo x3 en la pila, desalineandola
  sub RSP, 8 ;alineo
  call restar_c 
  add RSP, 8 ;restauro tope
  pop RDX ;recupero x3
  
  mov EDI, EAX
  mov ESI, EDX
  call sumar_c

  mov EDI, EAX
  mov ESI, [RBP - 8] ;leo x4 de la pila
  call restar_c

  ;el resultado final ya está en EAX, así que no hay que hacer más nada

  ;epilogo
  add RSP, 16 ;restauro tope de pila
  pop RBP ;pila desalineada, RBP restaurado, RSP apuntando a la dirección de retorno
  ret


; uint32_t alternate_sum_8(uint32_t x1, uint32_t x2, uint32_t x3, uint32_t x4, uint32_t x5, uint32_t x6, uint32_t x7, uint32_t x8);
; registros y pila: x1[RDI], x2[RSI], x3[RDX], x4[RCX], x5[R8], x6[R9], x7[?], x8[?]
alternate_sum_8:
	;prologo
  push RBP ; alineada
  mov RBP, RSP
  push R12 ;64bit 8bytes
  push R13
  push R14
  push R15 ; alineada

  mov R12D, EDX ;x3 32bits
  mov R13D, ECX
  mov R14D, R8D
  mov R15D, R9D ;x6

  mov EAX, EDI

  sub EAX, ESI

  mov ESI, R12D ; x3
  add EAX, ESI
  
  ; x4
  mov ESI, R13D
  sub EAX, ESI
  
  ; x5
  mov ESI, R14D
  add EAX, ESI
  
  ; x6
  mov ESI, R15D
  sub EAX, ESI
  
  ; x7
  mov ESI, [RBP + 16]
  add EAX, ESI
  
  ; x8
  mov ESI, [RBP + 24]
  sub EAX, ESI


	;epilogo
  pop R15
  pop R14
  pop R13
  pop R12
  pop RBP
	ret


; SUGERENCIA: investigar uso de instrucciones para convertir enteros a floats y viceversa
;void product_2_f(uint32_t * destination, uint32_t x1, float f1);
;registros: destination[rdi], x1[rsi], f1[xmm0]
product_2_f:
  ;prologo
  push rbp
  mov rbp, rsp
  push R12

  ;guardamos destination
  mov R12, RDI
  ; multiplicar rsi por el float rdx

  ; CVTSI2SS — Convert Doubleword Integer to Scalar Single Precision Floating-Point Value
  CVTSI2SS XMM1, RSI
  ; XMM0 ya tiene nuestro primer float como parametro
  MULSS XMM1, XMM0
  ;call multiplicarFloatsAInt32_c
  ;resultado en XMM0

  ; CVTSS2SI — Convert Scalar Single Precision Floating-Point Value to Doubleword Integer
  CVTSS2SI EAX, XMM1

  mov [R12], EAX

  ;epilogo
  pop R12
  pop rbp
	ret


; double(double d1, double d2)

;extern void product_9_f(double * destination
;, uint32_t x1, float f1, uint32_t x2, float f2, uint32_t x3, float f3, uint32_t x4, float f4
;, uint32_t x5, float f5, uint32_t x6, float f6, uint32_t x7, float f7, uint32_t x8, float f8
;, uint32_t x9, float f9);

;registros y pila: destination[rdi], x1[rsi], f1[XMM0], x2[rdx], f2[XMM1], x3[rcx], f3[XMM2], x4[r8], f4[XMM3]
;	, x5[r9], f5[XMM4], x6[ [RBP + 16] ], f6[XMM5], x7[ [RBP + 24] ], f7[XMM6], x8[ [RBP + 32] ], f8[XMM7],
;	, x9[ [RBP + 40] ], f9[ [RBP + 48] ]
; se pushea de derecha  a izquieda, el primero en pushear es f9 entonces seria el mas alejado de RBP
; transformar todo a double
; usar las instrucciones de multiplicacion, no usar C
mlt:

  
  ret

product_9_f:
	;prologo
	push rbp
	mov rbp, rsp
  
  pxor xmm8, xmm8

  cvtss2sd xmm0, xmm0
  cvtss2sd xmm1, XMM1
  cvtss2sd xmm2, xmm2
  cvtss2sd xmm3, xmm3
  cvtss2sd xmm4, XMM4
  cvtss2sd xmm5, xmm5
  cvtss2sd xmm6, xmm6
  cvtss2sd xmm7, XMM7
  
  cvtss2sd xmm8, [RBP + 48]

  mulpd xmm0, xmm1
  mulpd xmm0, xmm2
  mulpd xmm0, XMM3
  mulpd xmm0, XMM4
  mulpd xmm0, XMM5
  mulpd xmm0, XMM6
  mulpd xmm0, XMM7
  mulpd xmm0, xmm8

  pxor xmm1, xmm1
  cvtsi2sd xmm1, RSI
  mulpd xmm0, xmm1

  pxor xmm1, xmm1
  cvtsi2sd xmm1, RDX
  mulpd xmm0, xmm1

  pxor xmm1, xmm1
  cvtsi2sd xmm1, RCX
  mulpd xmm0, xmm1

  pxor xmm1, xmm1
  cvtsi2sd xmm1, R8
  mulpd xmm0, xmm1

  pxor xmm1, xmm1
  cvtsi2sd xmm1, R9
  mulpd xmm0, xmm1

  pxor xmm1, xmm1
  cvtsi2sd xmm1, [rbp + 16]
  mulpd xmm0, xmm1

  pxor xmm1, xmm1
  cvtsi2sd xmm1, [rbp + 24]
  mulpd xmm0, xmm1

  pxor xmm1, xmm1
  cvtsi2sd xmm1, [rbp + 32]
  mulpd xmm0, xmm1

  pxor xmm1, xmm1
  cvtsi2sd xmm1, [rbp + 40]
  mulpd xmm0, xmm1

  movq [rdi], xmm0


	; epilogo
	pop rbp
	ret

