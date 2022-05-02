# para re pensarlo
.data
	x0: .double 6.0
	dos : .double 2.0
	
	xv1: .double 0
	yv1: .double 0
	zv1: .double 0
	
	xv2: .double 0
	yv2: .double 0
	zv2: .double 0
	
	entrada: .asciiz "Ingrese el valor X del vector 1: "
	x : .byte 'X'
	y : .byte 'Y'
	z : .byte 'Z'
	Nuno : .byte '1'
	Ndos : .byte '2'
	resultado: .asciiz "La distancia entre ambos puntos es: "	
.text
main:
	jal leer_entradas
	jal distancia_euclideana
	jal salida
	
	j exit

exit:
	li $v0,10
	syscall

leer_entradas:
	addi $sp,$sp,-4
	sw $ra, 0($sp)
	
	lb $t0, x
	lb $t1, y
	lb $t2, z
	lb $t3, Nuno
	lb $t4, Ndos
	la $a0, entrada
	
	jal imprimir_texto
	li $v0,7
	syscall
	sdc1 $f0,xv1
	
	sb $t1, 17($a0)
	jal imprimir_texto
	li $v0,7
	syscall
	sdc1 $f0,yv1
	
	sb $t2, 17($a0)
	jal imprimir_texto
	li $v0,7
	syscall
	sdc1 $f0,zv1
	
	sb $t0, 17($a0)
	sb $t4, 30($a0)
	jal imprimir_texto
	li $v0,7
	syscall
	sdc1 $f0,xv2
	
	sb $t1, 17($a0)
	jal imprimir_texto
	li $v0,7
	syscall
	sdc1 $f0,yv2
	
	sb $t2, 17($a0)
	jal imprimir_texto
	li $v0,7
	syscall
	sdc1 $f0,zv2
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	
	jr $ra
salida:
	la $a0, resultado
	li $v0, 4
	syscall
	mov.d  $f12,$f0
	li $v0,3
	syscall
	jr $ra
imprimir_texto:
	li $v0,4
	syscall
	jr $ra
	
distancia_euclideana:
	addi $sp,$sp,-4
	sw $ra, 0($sp)
	
	# f4 a f10 U $f16 $f18	
	ldc1 $f4,xv1
	ldc1 $f6,yv1
	ldc1 $f8,zv1
	ldc1 $f10,xv2
	ldc1 $f16,yv2
	ldc1 $f18,zv2
	
	# (x1 - x2)**2
	sub.d $f4,$f4,$f10
	mul.d $f4,$f4,$f4	
	
	# (y1 - y2)**2
	sub.d $f6,$f6,$f16
	mul.d $f6,$f6,$f6
	
	# (z1 - z2)**2
	sub.d $f8,$f8,$f18
	mul.d $f8,$f8,$f8
	 
	# $f4 + $f6 + $f8
	add.d $f4, $f4, $f6 
	add.d $f4, $f4, $f8
	 
	mov.d $f2, $f4
	
	# Para calcular su raiz, dejar resultado en $f2
	add $a0,$zero,$zero #contador en 0
	ldc1 $f0,x0
	ldc1 $f20,dos
	jal raiz
	
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

raiz: 	# Recibe en $f0 el x0
	# Recibe en $f2 el numero al cual aplicar raiz
	# Recibe en $a0 el acumulador (limite)
	addi $sp,$sp,-4
	sw $ra, 0($sp)
	
	# Caso base
	beq $a0,7,fin
	
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