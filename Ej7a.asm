! Un programa ARC declara dos variables y luego invoca una rutina que obtiene la suma de ambas.
! Escribir tres versiones del programa principal y de la rutina considerando diferentes convenciones
! para el pasaje de parámetros -> por registros
! Estas estan en dos módulos diferentes.


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
.end

.begin
.org 3000

	sumar: ! recibe los parametos por registros
		! lo devuelve en %r3

		add %r1, %r2, %r3
		jmpl %r15+4, %r0
    
.end
