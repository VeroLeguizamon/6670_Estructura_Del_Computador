! Un programa ARC declara dos variables y luego invoca una rutina que obtiene la suma de ambas.
! Escribir tres versiones del programa principal y de la rutina considerando diferentes convenciones
! para el pasaje de parámetros -> reservando memoria

.begin
.org 2048
	ld [x], %r1 ! guardo un dato de memoria a registro
	st %r1, [k] ! lo guardo en la reserva de memoria.
	ld [y], %r1 ! load y into registro
	st %r1, [k+4]
	
	addcc %r15, %r0, %r30 ! me guardo el retorno para hacer una subrutina
	call sumar ! subrutina

	st %r2, [z] ! escribo el dato del registro a z 
	jmpl %r30 + 4, %r0 ! devuelvo todo

	x: 1 ! variable 1 
	y: 2 ! variable 2
	z: 0 ! suma de ambas variables

	sumar: ! recibe los parametos por registros
		! lo devuelve en %r2
		ld [k], %r1
		ld [k+4], %r2

		addcc %r1, %r2, %r2
		
		jmpl %r15+4, %r0 

	k: .dwb 3 ! guardo espacio en la memoria.
.end
