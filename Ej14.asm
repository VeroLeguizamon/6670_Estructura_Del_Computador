! proponer una rutina que recibe un número entero
! devuelve su cuadrado
! Todo recibe y devuelve por pila

.begin 
.org 2048
	ld [x], %r1 ! cargo x en r1
	ld [stack], %r14 ! le asigno un valor logico al stack

	add %r14, -4, %r14 ! habilito espacio en el stack
	st %r1, %r14 ! cargo el dato en el stack

	st %r15, %r30 ! me guardo el retorno
	call cuadrado
	
	ld %r14, %r1 ! descargo el valor 
	add %r14, 4, %r14 ! libero espacio en el stack
	st %r1, [resultado] 
	jmpl %r30 +4, %r0

cuadrado:
	ld %r14, %r10 ! copio el valor del stack en r10
	add %r15, %r0, %r25! me guardo el retorno
	add %r14, -4, %r14 ! habilito espacio en el stack
	st %r10, %r14 ! cargo el valor en el stack
	
	call multiplicar

fin:
	jmpl %r25 + 4, %r0


x : 3
resultado : 0
stack : 1500
.end

.begin
.org 3000
! r20 esta el valor de x
! r21 esta el valor de y
! r22 copio el valor de x para hacer la cuenta de cuantas veces debe sumar
! r23 suma parcial

multiplicar: 
	ld %r14, %r20 ! descargo del stack
	add %r14, 4, %r14 ! libero lugar en el stack
	ld %r14, %r21 ! descargo del stack
	add %r14, 4, %r14 ! libero lugar en el stack

	add %r0, %r0, %r23 ! inicializo r23 en 0
	add %r20, %r0, %r22 ! copio el valor de r20 en r22
	
for:
	addcc %r21, %r23, %r23 ! realizo la suma del mismo numero
	bcs no_representable
	ba restar
	
terminar:
	add %r14,-4,%r14 ! habilito lugar en el stack
	st %r23, %r14 ! descargo el valor en el stack
	ba volver

no_representable:
	add %r14,-4,%r14 ! habilito lugar en el stack
	ld [no_repre], %r14 ! cargo el valor no_re en r14
	ba volver

restar:
	addcc %r22, -1, %r22 ! resto el indice
	be terminar 
	bpos for

volver:
	jmpl %r15+4,%r0

no_repre : -1
.end
