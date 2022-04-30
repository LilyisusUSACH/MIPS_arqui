.data
	resultado: .asciiz "El resultado de la division es :  "
	positivo : .byte '+'
	negatvo : .byte '-'
	var : .byte ' '

.text
	# cambiar V por un numero
	la $t0, resultado
	lb $t1, positivo

	sb $t1, 33($t0)
	
	la $a0,resultado
	li $v0,4
	syscall