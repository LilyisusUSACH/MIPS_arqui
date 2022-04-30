.data

.text
	main:
		li $v0,5
		syscall
		
		add $s0,$zero,$v0 #recibo y guardo
		
		add $a0,$zero,$s0 #paso como argumetno
		addi $a1,$zero,7
		
		jal raiz
		j exit
	exit:
		li $v0,10
		syscall
		
	# Creo una funcion raiz
	raiz:
		addi $sp,$sp,-8
		sw $ra, 0($sp)
		sw $s0, 4($sp)
		# Caso base
		beqz $a1,finraiz
		
		# Recursion (raiz X($t0) Y($t1) I($a1)
		add $t0,$zero,$a0
		addi $t1, $zero, 6 # el 6 se explica en el informe

		addi $a1, $a1, -1 #contador 
		
		# $t2 tiene el num
		mul $t2,$t0,$t0
		sub $t2,$t2,$t1
		# $t3 tendra el deno
		mul $t3,$t0,2
		div $t3,$t2,$t3
		sub $a0,$t0,$t3
		
		jal raiz
		
		add $v0,$zero,$a0
		
		finraiz:
			lw $ra, 0($sp)
			lw $s0, 4($sp)
			addi $sp,$sp,8
			jr $ra
