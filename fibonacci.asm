.data
	entrada : .asciiz "\nIngrese un numero : "
	salida : .asciiz "\nEl Fibonacci es : "

.text
	solicitar_entrada:
		li $v0,4
		la $a0,entrada
		syscall 
		li $v0,5
		syscall
		add $t1,$v0,$zero

	li $t2,1
	li $t3,0
	li $t4,0
	
	ciclo: 
		beqz $t1,finciclo
		
		add $t3,$t2,$t4
		add $t4,$t2,$zero
		add $t2,$t3,$zero
		
		subi $t1,$t1,1

		j ciclo
		
	finciclo:
		li $v0,4
		la $a0,salida
		syscall 
		li $v0,1
		add $a0,$t4,$zero
		syscall