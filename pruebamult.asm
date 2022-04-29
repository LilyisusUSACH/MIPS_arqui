main:
	addi $a0,$zero,10
	jal multi10
	add $a0, $zero, $v0
	li $v0,1
	syscall
	li $v0,10
	syscall
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
