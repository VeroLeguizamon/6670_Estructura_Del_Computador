! Un programa ARC declara dos variables y luego invoca una rutina que obtiene la suma de ambas.
! Escribir tres versiones del programa principal y de la rutina considerando diferentes convenciones
! para el pasaje de parámetros -> por pila

.begin
.org 2048
	ld [x], %r1 ! guardo un dato de memoria a registro
	ld [y], %r2 ! load y into registro

	addcc %r14, -4, %r14 ! habilito lugar en el stack pointer
	st %r1, %r14 ! guardo el numero
	addcc %r14, -4, %r14 ! habilito lugar en el stack
	st %r2, %r14 ! almaceno el numero

	addcc %r15, %r0, %r30 ! me guardo el retorno para hacer una subrutina
	call sumar ! subrutina

	st %r3, [z] ! escribo el dato del registro a z 
	jmpl %r30 + 4, %r0 ! devuelvo todo

	x: 1 ! variable 1 
	y: 2 ! variable 2
	z: 0 ! suma de ambas variables

	sumar: ! recibe los parametos por pila
		! lo devuelve en %r3
		
		st %r14, %r1 ! escribo un dato del registro 14 -> 1
		addcc %r14,4, %r14 ! libero memoria en el stack

		st %r14, %r2 ! escribo un dato del registro 14 -> 2
		addcc %r14,4, %r14 ! libero memoria
		
		add %r1, %r2, %r3 ! sumo los registros
	
		! en el caso que quisiera mandar por stack
		! addcc %r14, -4, %r14 habilito espacio en el stack
		! st %r3, %r14 lo escribo en el stack

		! debo acordarme de liberar este espacio cuando lo leo 

		jmpl %r15+4, %r0 
.end
