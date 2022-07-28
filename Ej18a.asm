.begin
.org 2048
	
	ld [x],%r1
	add %r14,200,%r14 ! inicializo el stack

	add %r14, -4, %r14 ! habilito espacio en el stack
	st %r1, %r14 ! cargo el dato al stack.
	
	st %r15, %r30 ! guardo el retorno
	call contador
	
	jmpl %r30+4,%r0
	
x: F124FAC1h ! 1111 0001 0010 0100 1111 1010 1100 0001 = 16 1's

! r12 -> contador
! r11 -> auxiliar
! r10 -> numero

contador: 
	ld %r14,%r10 ! bajo el dato del stack a un registro

	add %r0,1,%r11 ! pongo en uno el auxiliar
	add %r0,%r0,%r12 ! pongo en cero el contador

while:
	addcc %r11,%r0,%r0 ! si el auxiliar = 0, ya revisó los 32 bits entonces termina.
	be fin

	andcc %r10, %r11, %r0
	be no_suma
	ba suma

suma:
	add %r12,1,%r12

no_suma:
	sll %r11,1,%r11
	ba while

fin: 
	ld %r12,%r14
	jmpl %r15+4,%r0

.end
