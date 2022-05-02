.data
	newline : .byte '\n'
.text

li $t0, 715827882 #limite de reg 2147483647
# tiene que ser < 715.827.882
li $t1, 0x100100A0
# lim memoria 348 o 0x10010200
li $t2, 0x10040000

addi $s0,$zero, 77031 # numero de secuencia, pedirlo por consola

addi $s1,$zero,2 # para tener un dos al dividir

mientras:
	sw $s0, 0($t1)
	addi $t1,$t1,4
	
	beq $t1, $t2, fin
	beq $s0, 1, converge
	
	div $s0,$s1
	mfhi $t3 # remainder
	
	beqz $t3, par # Es par
	
	impar:
		bgt $s0, $t0, fin
		mul $s0,$s0,3
		addi $s0, $s0,1
		j mientras
	par:
		div $s0,$s0,$s1
		j mientras
	converge:
		add $a0, $zero, $s0
		li $v0, 1
		syscall
		j fin

fin:
	#salida
	#beq $s0,1, 
	
	li $v0,10
	syscall
