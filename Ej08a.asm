! Sumar dos numeros pasándolos por registros utilizando macros.
! Con macros cuando se ensambla el código se pega la misma linea de código en cada sección que lo invica.
! La subrutina en cambio lo tengo fijo en un lugar de la memoria.
! Es conveniente usar una subrutina ya que con la macro obtengo código repetido y, por ende, se utiliza más memoria.

.begin
.org 2048

.macro	sumar unNum,otroNum,resultado
	addcc unNum,otroNum,resultado
.endmacro

	ld [unNum], %r1
	ld [otroNum], %r2
	
	sumar %r1,%r2,%r3

	st %r3, [resultado]

	unNum : 3
	otroNum: 4
	resultado: 0
.end
