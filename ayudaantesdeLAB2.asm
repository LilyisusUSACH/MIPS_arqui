main:
	# acum
	add $s0, $zero,$zero
	jal funcion
	
	li $v0,10
	syscall
	
funcion:
	addi $sp,$sp,-8
	sw $ra, 0($sp)
	sw $s1, 4($sp)
	
	beq $s0,10,fin
	
	addi $s0,$s0,1
	jal funcion
	
	add $a0,$zero,$s0
	li $v0,1
	syscall
	
	fin:
		lw $ra, 0($sp)
		lw $s1, 4($sp)
		addi $sp,$sp,8
		jr $ra