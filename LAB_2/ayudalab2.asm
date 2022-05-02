# para re pensarlo
.data
	x0: .double 6.0
	dos : .double 2.0
	n: .double 0
.text
main:
	add $a0,$zero,$zero #contador en 0
	ldc1 $f0,x0
	ldc1 $f2,n
	ldc1 $f20,dos
	jal raiz
	
	mov.d  $f12,$f0
	li $v0,3
	syscall
	
	li $v0,10
	syscall
	
raiz: 	# Recibe en $f0 el x0
	# Recibe en $f2 el numero al cual aplicar raiz
	# Recibe en $a0 el acumulador (limite)
	addi $sp,$sp,-4
	sw $ra, 0($sp)
	
	# Caso base
	beq $a0,20,fin
	
	# No caso base
	
	# X ($f0), Y ($f2), I ($a0)
	
	# (x*x)
	mul.d $f4, $f0,$f0
	
	#($f4-y)
	sub.d $f4, $f4, $f2
	
	# Abajo (2*X)
	mul.d $f6,$f0,$f20
	
	# $F4/F6
	div.d $f4,$f4,$f6
	
	# X - $f4
	sub.d $f0,$f0,$f4
	
	addi $a0,$a0,1
	jal raiz
	
	fin:
		lw $ra,0($sp)
		addi $sp,$sp,4
		jr $ra
	