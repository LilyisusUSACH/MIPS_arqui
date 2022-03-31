.data
	mensaje : .asciiz "\nEl valor es : "

.text
	li $t1,15
	li $t2,3
	ciclo: 
		Add $t3,$t3,$t1
		subi $t2,$t2,1
		beqz $t2,finciclo
		j ciclo
	finciclo:
		li $v0,4
		la $a0,mensaje
		syscall 
		li $v0,1
		add $a0,$t3,$zero
		syscall