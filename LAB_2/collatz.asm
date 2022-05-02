.data
	entrada: .asciiz "Ingrese un numero inicial : "
	textConverge : .asciiz "La Conjetura de collatz converge \n"
	textNoConverge : .asciiz "Dentro de las limitaciones, esta secuencia NO converge \n"
	
.text
main:
	jal leer_entradas
	add $a0,$zero,$v0
	jal secuencia_collatz
	j exit
	
exit: 
	li $v0,10
	syscall
	
leer_entradas:
	la $a0, entrada
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	jr $ra

secuencia_collatz:
	li $t0, 715827882 #limite de reg 2147483647
	# tiene que ser < 715.827.882
	li $t1, 0x100100A0
	# lim memoria 348 o 0x10010200
	li $t2, 0x10040000

	add $s0,$zero,$a0 # numero de secuencia, pedirlo por consola

	addi $s1,$zero,2 # para tener un dos al dividir

	mientras:
		sw $s0, 0($t1)
		addi $t1,$t1,4
	
		beq $t1, $t2, noConverge
		beq $s0, 1, converge
		
		div $s0,$s1
		mfhi $t3 # remainder
	
		beqz $t3, par # Es par
	
		impar:
			bgt $s0, $t0, noConverge
			mul $s0,$s0,3
			addi $s0, $s0,1
			j mientras
		par:
			div $s0,$s0,$s1
			j mientras
		converge:
			la $a0,textConverge
			li $v0, 4
			syscall
			j fin
		noConverge:
			la $a0,textNoConverge
			li $v0, 4
			syscall
			j fin

	fin:
		add $t0,$zero,$zero
		add $t1,$zero,$zero
		add $t2,$zero,$zero
		move $v0, $s0
		jr $ra
