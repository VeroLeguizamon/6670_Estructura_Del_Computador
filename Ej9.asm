! subrutina que recibe por stack un numero entero en complemeto a 2
! y devuelve su valor absoluto.

.begin
.org 2048

	ld [stack], %r14 ! inicializo el stack
	ld [x], %r1 ! guardo x en r1

	add %r14, - 4, %r14 ! habilito un espacio en el stack
	st %r1, %r14 ! guardo el dato
	add %r15, %r0, %r30 !guardo el retorno

	call absoluto
	
	ld %r14, %r1 ! cargo el resultado en r3
	add %r14, 4, %r14 ! libero espacio en el stack
	
	st %r1, [valor] ! lo escribo en la variable valor

	jmpl %r30 + 4, %r0 

absoluto:
	ld %r14, %r2 ! cargo lo del stack en r2
	add %r14, 4, %r14 ! libero espacio en el stack

	addcc %r2, %r0, %r0 ! verifico los flags

	bneg negativo

positivo:
	add %r14, -4, %r14 ! habilito espacio en el stack
	st %r2, %r14 ! cargo nuevamente en r14
	jmpl %r15 + 4, %r0

negativo:
	subcc %r0, %r2, %r2 ! complemento
	ba positivo
	
x : -1
valor: 0
stack: 6000
.end
