main:
	# acum
	add $s0, $zero,$zero
	jal funcion
	
	li $v0,1
	syscall
	
	li $v0,10
	syscall
	
funcion:
	addi $sp,$sp,-4
	sw $ra, 0($sp)
	
	beq $s0,10,fin

	addi $s0,$s0,1
	add $a0,$zero,$s0
	li $v0,1
	syscall
	jal funcion
	
	fin:
		lw $ra, 0($sp)
		addi $sp,$sp,4
		jr $ra
