! Escriba un programa en código ARC
! que declare dos variables de 32 bits en memoria RAM y q' 
! intercambie el contenido entre ellas. Utilizar el minimo num de
! registros que le sea posible.

.begin
.org 2048
	ld [x], %r1
	st %r1, [z]
	ld [y], %r1
	st %r1, [x]
	ld [z], %r1
	st %r1, [y]

	x: 1
	y: 2
	z: 0
.end
