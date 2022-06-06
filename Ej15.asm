! recibe a través de r10 un numero en punto flotante
! devuelve su valor absoluto también en punto flotante

.begin 
.org 2048

	ld [num], %r10
	ld [comparador], %r2

	and %r2, %r10, %r3
	st %r3, [resultado]

num : A563CB01h ! 1010 0101 0110 0011 1100 1011 0000 0001
resultado : 0
! con una and cambia el valor del primer dígito que tiene el signo. 
comparador : 7FFFFFFFh ! 0111 1111 1111 1111 1111 1111 1111 1111
! tiene que quedar 0010 0101 ... -> 25...
.end
