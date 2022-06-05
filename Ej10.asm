! recibe porpila dos numeros en complemento a2 y determina si su
! suma es representable en 32 bits

! 1 -> si 
! 4 -> no

.begin
.org 2048

	ld [x], %r1 ! cargo x en r1
	ld [y], %r2 ! cargo y en r2
	ld [stack], %r14 ! inicializo el stack

	add %r14, -4, %r14 ! habilito espacio en el stack
	st %r1, %r14 ! escribo el valor de r1 en el stack
	add %r14, -4, %r14 ! habilito espacio en el stack
	st %r2, %r14 ! escribo el valor de r2 en el stack

	st %r15, %r30 ! me guardo el retorno

	call es_representable
	
	ld %r14, %r3 ! cargo el resultado en r3
	add %r14, 4, %r14 ! libero espacio en el stack

	st %r3, [resultado] ! escribo el resultado en resultado
	jmpl %r30 + 4, %r0

es_representable: 
	ld %r14, %r20 ! cargo el valor en r20
	add %r14, 4, %r14 ! libero espacio
	ld %r14, %r21 ! cargo el valor en r21
	add %r14, 4, %r14 ! libero espacio

	addcc %r20, %r21, %r0 ! modifico los flags
	add %r14, -4, %r14 ! habilito espacio en el stack
	bvs no_es

si_es: 
	add %r0, 1, %r20
	st %r20, %r14
	ba volver
no_es:
	! para que me devuelva 0 st %r0, %r14 pero para entenderlo mejor
	! hago que me devuelva otro numero
	add %r0, 4, %r20
	st %r20, %r14 ! cargo en el stack
	ba volver

volver: 
	jmpl %r15 + 4, %r0

x : 2147483647
y : 214748364
stack: 6000
resultado : 3

.end
