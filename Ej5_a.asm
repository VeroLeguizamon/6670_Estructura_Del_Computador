! Escriba un programa en código ARC
! que declare dos variables de 32 bits en memoria RAM y q' 
! intercambie el contenido entre ellas. Utilizar el minimo num de
! registros que le sea posible.

.begin
.org 2048
	ld [x], %r1
	ld [y], %r2
	addcc %r15, %r0, %r30
	call sumar
	st %r3, [z]
	jmpl %r30 4, %r0

	x: 1 ! variable 1 
	y: 2 ! variable 2
	z: 0 ! suma de ambas variables

	sumar: ! recibe los parametos por registros
		! lo devuelve en %r3

		add %r1, %r2, %r3
		jmpl %r15+4, %r0
.end
