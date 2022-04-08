.data
	menos: .asciiz "-"
.text
	li $v0, 5
	syscall
	add $s0, $v0, $zero
	
	li $v0, 5
	syscall
	add $s1, $v0, $zero
	
	blez $s0,first_negativo
	blez $s1,second_negativo
	j seguir
	first_negativo:
		sub $s0,$zero,$s0
		blez $s1,seguir
		j seguir
	second_negativo:
		sub $s1,$zero,$s1
		li $v0,4
		la $a0, menos
		syscall
	seguir:
	li $t0, 0
	mientras:
		sub $s0,$s0,$s1
		addi $t0,$t0,1
		bge $s0,$s1,mientras
	fin:
	li $v0,1
	add $a0,$t0,$zero
	syscall
	# Ahora los decimales
	