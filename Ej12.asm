! Subrutina que recibe dos numeros por pila para multiplicar
! devuelve por la pila su producto
! En el caso que no se pueda representar, devuelve -1

.begin
.org 2048
	ld [x], %r1
	ld [y], %r2
	ld [stack], %r14

	add %r14,-4,%r14
	st %r1, %r14
	add %r14, -4, %r14
	st %r2, %r14

	st %r15, %r30

	call multiplicar
	
	ld %r14, %r4
	add %r14, 4, %r14

	st %r4, [resultado]
	jmpl %r30 + 4, %r0

multiplicar: 
	ld %r14, %r20
	add %r14, 4, %r14
	ld %r14, %r21
	add %r14, 4, %r14

	add %r0, %r0, %r23
	add %r20, %r0, %r22 ! copio el valor de r20 en r22
	
for:
	addcc %r21, %r23, %r23
	bcs no_representable
	
	ba restar

	
terminar:
	add %r14,-4,%r14
	st %r23, %r14
	ba volver

no_representable:
	add %r14,-4,%r14
	ld [no_re], %r14
	ba volver

restar:
	addcc %r22, -1, %r22
	be terminar
	bpos for

volver:
	jmpl %r15+4,%r0

x : 2
y : 3
no_re : -1
resultado : 0
stack : 4000
.end

