.data
	message: .asciiz "\nLa multiplicacion es : "
.text
	li $t1,9
	li $t2,7
	
	li $v0,4
	la $a0,message
	syscall
	
	mult $t1,$t2
	mflo $t3
	
	li $v0,1
	add $a0,$t3,$zero
	syscall
	