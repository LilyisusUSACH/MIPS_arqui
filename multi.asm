.data
	mensaje : .asciiz "\nEl valor es : "

.text 
	li $t1,100
	li $t2,4
	mult $t1,$t2
	mflo $t3
	li $v0,4
	la $a0,mensaje
	syscall 
	li $v0,1
	add $a0,$t3,$zero
	syscall 