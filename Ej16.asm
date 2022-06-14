! recibe a través de la pila dos numeros en punto flotante simple precisión
! los compara y devuelve 1 -> mayor primero, 2 -> mayor el segundo
! devuelve mediante la pila

.begin 
.org 2048

	ld [num1], %r1
	ld [num2], %r2
	ld [stack], %r14 ! inicializo el stack

	add %r14, -4, %r14 ! habilito espacio en el stack
	st %r1, %r14
	add %r14, -4, %r14 ! habilito espacio en el stack
	st %r2, %r14
	
	st %r15, %r30

	call comparador
	
	st %r14, [resultado]
	add %r14, 4, %r14 ! libero espacio en el stack
	jmpl %r30 + 4, %r0

! r20 -> x
! r21 -> y
! r22 -> singo x
! r23 -> signo y
! r24 -> exponente x 
! r25 -> exponente y
! r26 -> mantiza x
! r27 -> mantiza y

!r19 -> comparador mantiza
!r18 -> comparador exponente
!r17 -> comparador signo

comparador: 
	st %r14, %r20
	add %r14, 4, %r14
	st %r14, %r21
	add %r14, 4, %r14
	
	st %r15, %r29 ! me guardo el retorno

! Tiene que dividir signo, exponente y mantiza.

separar_signo:
	ld [signo], %r17	
	and %r20, %r17, %r22 ! guardo signo x
	and %r21, %r17, %r23 ! guardo signo y

separar_exponente:
	ld [signo], %r18
	and %r20, %r17, %r24 ! guardo exponente x
	and %r21, %r17, %r25 ! guardo exponente y

separar_mantiza:
	ld [signo], %r19
	and %r20, %r17, %r26 ! guardo mantiza x
	and %r21, %r17, %r27 ! guardo mantiza y

comparar_signos:
	subcc %r22, %r23, %r0 ! veo los flags
	be comprar_exponente
	
comprar_exponentes:
	subcc %r24, %r25, %r0 ! veo los flags
	be comparar_matiza

comparar_mantiza :
	subcc %r26, %r27, %r0 !veo flags
	be iguales

iguales:
	add %r14, 4, %r14
	add %r0, 4, %r14
	ba terminar

terminar:
	jmpl %r29 + 4, %r0

num1 : A563CB01h ! 1010 0101 0110 0011 1100 1011 0000 0001
num2 : A563CB02h ! 1010 0101 0110 0011 1100 1011 0000 0010
stack : 5000
resultado : 0
! compuerta and en 1 me copia lo que hay
signo: 80000000h ! 1000 0000 0000 0000...
expediente : 7F80000h ! 0111 1111 1000 0000...
mantiza : 007FFFFFh ! 0000 0000 0111 1111 1111 1111 1111 1111
.end
