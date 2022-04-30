.data
	solicitar_entrada: .asciiz "Por Favor ingrese un numero: "
	resultado: .asciiz "El resultado de la division es : "
	negativo: .byte '-'
	punto: .byte '.'
	newLine: .byte '\n'
.text

# Bloque principal
main:
	jal leer_entrada
	add $s0, $zero,$v0
	jal leer_entrada
	add $s1,  $zero,$v0
	
	add $a0, $zero, $s0
	add $a1, $zero, $s1
	jal evaluar_signo
	
	add $a0, $zero, $v0
	add $a1, $zero, $v1
	jal division
	
	add $a0, $zero, $v0
	add $a1, $zero, $v1
	jal imprimir_final
	j exit

exit:
	li $v0,10
	syscall
	
evaluar_signo:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	add $t0, $zero, $a0
	add $t1, $zero, $a1
	
	la $t2, resultado
	lb $t3, negativo
	
	blez $t0,primero_negativo
	blez $t1,segundo_negativo
	terminar:
		add $v0,$zero,$t0
		add $v1,$zero,$t1
		li $t0, 0
		li $t1, 0
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra

	primero_negativo:
		sub $t0,$zero,$t0
		blez $t1,invertir
		sb $t3, 32($t2)
		j terminar

	segundo_negativo:
		sub $t1,$zero,$t1
		sb $t3, 32($t2)
		j terminar

	invertir:
		sub $t1,$zero,$t1
		j terminar
		
division:
	add $t0, $zero, $a0
	add $t1, $zero, $a1
	
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $t2, 0 # contador
	blt $t0,$t1,resto
	mientras:
		sub $t0,$t0,$t1
		addi $t2,$t2,1
		bge $t0,$t1,mientras
	resto:
	# en t2 tengo el entero
	# multiplico por 100
		add $a0, $zero, $t0
		jal multi10
		add $a0, $zero, $v0
		jal multi10
		add $t0, $zero, $v0
		
		add $t1, $zero, $a1 # vuelvo a leer el a1 (divisor)
		add $a0, $zero, $t1

		li $t3, 00 # contador
		blt $t0,$t1,fin
		mientrasresto:
			sub $t0,$t0,$t1
			addi $t3,$t3,1
			bge $t0,$t1,mientrasresto
		
	fin: 	# Aca lo termina
	add $v0, $zero, $t2
	add $v1, $zero, $t3
	li $t0, 0
	li $t1, 0
	li $t2, 0
	li $t3, 0
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra

multi10:
	add $t0, $zero, $a0
	addi $t1, $zero,1
	add $t3, $zero, $t0
	nofinmult:
		add $t3,$t0,$t3
		addi $t1,$t1,1
		beq $t1,10,finmult
		j nofinmult
	finmult:
		add $v0, $zero, $t3
		jr $ra

leer_entrada:
	la $a0, solicitar_entrada
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	jr $ra

imprimir_texto:
	li $v0,4
	syscall
	jr $ra

imprimir_numero:
	li $v0,1
	syscall
	jr $ra

imprimir_char:
	li $v0,11
	syscall
	jr $ra

imprimir_final:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	add $t0,$zero,$a0
	add $t1,$zero,$a1
	
	la $a0, resultado
	jal imprimir_texto
	
	add $a0,$zero,$t0
	jal imprimir_numero
	
	lb $a0, punto
	jal imprimir_char
	
	bgt $t1,10,NoZero
	
	add $a0,$zero,$zero
	jal imprimir_numero
	NoZero:
		add $a0,$zero,$t1
		jal imprimir_numero
	
	add $t0,$zero,$zero
	add $t1,$zero,$zero
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
		
