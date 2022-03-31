.data
	bienvenida : .asciiz "\nBienvenidos, seleccione la operacion que desea realizar"
	opciones : .asciiz "\n1)suma\n2)Multiplicacion por escalar\n3)producto escalar\n4)producto cruz\n"
	m_escalar : .asciiz "\nIngrese el escalar por el cual se multiplicara el vector : "
	punto_x : .asciiz "\nIngrese la componente X del vector: "
	punto_y : .asciiz "\nIngrese la componente Y del vector: "
	punto_z : .asciiz "\nIngrese la componente Z del vector: "
	firs_vector : .asciiz "\nPara el primer vector : "
	sec_vector : .asciiz "\nPara el segundo vector : "
	v_resultado : .asciiz "\nEl vector resultante es : ( "
	coma : .asciiz ", "
	cierre : .asciiz " )\n"
	resultado : .asciiz "\nEl resultado es : "

.text
	la $s0,0x10110000
	
	# OPCIONAL : DATOS PARA PRUEBA
	
	# Para la suma
	# vector (x1,y1,z1)
	addi $t1,$zero,2
	sw $t1,0($s0)
	addi $t1,$zero,-3
	sw $t1,4($s0)
	addi $t1,$zero,4
	sw $t1,8($s0)
	# vector (x2,y2,z2)
	addi $t1,$zero,3
	sw $t1,20($s0)
	addi $t1,$zero,4
	sw $t1,24($s0)
	addi $t1,$zero,-2
	sw $t1,28($s0)
	
	# Para la multi x escalar
	addi $t1,$zero,2
	sw $t1,40($s0)
	addi $t1,$zero,-3
	sw $t1,44($s0)
	addi $t1,$zero,4
	sw $t1,48($s0)
	
	# Para el producto escalar
	addi $t1,$zero,3
	sw $t1,60($s0)
	addi $t1,$zero,0
	sw $t1,64($s0)
	addi $t1,$zero,4
	sw $t1,68($s0)
	
	# FIN DATOS PRUEBA
	
	menu:
		li $v0,4
		la $a0,bienvenida
		syscall
		li $v0,4
		la $a0,opciones
		syscall
		li $v0,5
		syscall
		add $s1,$v0,$zero
		
	manejo_menu:
		beq $s1,1,suma
		beq $s1,2,mult_escalar
		beq $s1,3,p_escalar
		beq $s1,4,cruz
		j final
		
	suma:
		lw $t1,0($s0)
		lw $t2,20($s0)
		add $t1,$t1,$t2
		
		lw $t2,4($s0)
		lw $t3,24($s0)
		add $t2,$t2,$t3
		
		lw $t3,8($s0)
		lw $t4,28($s0)
		add $t3,$t3,$t4
		
		j imprimir_vector
	
	mult_escalar:
	
		li $v0,4
		la $a0,m_escalar
		syscall
		li $v0,5
		syscall
		add $s2,$v0,$zero
		
		lw $t1,40($s0)
		mul $t1,$t1,$s2
		lw $t2,44($s0)
		mul $t2,$t2,$s2
		lw $t3,48($s0)
		mul $t3,$t3,$s2	
		
		j imprimir_vector
		
	p_escalar:
		lw $t1,60($s0)
		lw $t2,64($s0)
		lw $t3,68($s0)
		
		li $v0,4
		la $a0,punto_x
		syscall
		li $v0,5
		syscall
		mul $t1,$t1,$v0
		
		li $v0,4
		la $a0,punto_y
		syscall
		li $v0,5
		syscall
		mul $t2,$t2,$v0
		
		li $v0,4
		la $a0,punto_z
		syscall
		li $v0,5
		syscall
		mul $t3,$t3,$v0
		
		add $t4,$t1,$t2
		add $t4,$t4,$t3
	
		j imprimir_escalar
		
	cruz:
		li $v0,4
		la $a0,firs_vector
		syscall
		
		li $v0,4
		la $a0,punto_x
		syscall
		li $v0,5
		syscall
		add $t0,$v0,$zero
		
		li $v0,4
		la $a0,punto_y
		syscall
		li $v0,5
		syscall
		add $t1,$v0,$zero
		
		li $v0,4
		la $a0,punto_z
		syscall
		li $v0,5
		syscall
		add $t2,$v0,$zero
		
		li $v0,4
		la $a0,sec_vector
		syscall
		
		li $v0,4
		la $a0,punto_x
		syscall
		li $v0,5
		syscall
		add $t3,$v0,$zero
		
		li $v0,4
		la $a0,punto_y
		syscall
		li $v0,5
		syscall
		add $t4,$v0,$zero
		
		li $v0,4
		la $a0,punto_z
		syscall
		li $v0,5
		syscall
		add $t5,$v0,$zero
		
		# Calculo del x resultante
		mul $s2,$t1,$t5
		mul $s3,$t2,$t4
		sub $s2,$s2,$s3
		
		
		# Calculo del y resultante
		mul $s3,$t0,$t5
		mul $s4,$t2,$t3
		sub $s3,$s3,$s4
		sub $s3,$zero,$s3

		
		# Calculo del z resultante
		mul $s4,$t0,$t4
		mul $s5,$t1,$t3
		sub $s4,$s4,$s5

		
		add $t1,$zero,$s2
		add $t2,$zero,$s3
		add $t3,$zero,$s4
		
		j imprimir_vector
		
	imprimir_vector:
		
		li $v0,4
		la $a0,v_resultado
		syscall
		
		li $v0,1
		add $a0,$t1,$zero
		syscall
		
		li $v0,4
		la $a0,coma
		syscall
		
		li $v0,1
		add $a0,$t2,$zero
		syscall
		
		li $v0,4
		la $a0,coma
		syscall
		
		li $v0,1
		add $a0,$t3,$zero
		syscall
		
		li $v0,4
		la $a0,cierre
		syscall
		
		j final
		
	imprimir_escalar:
	
		li $v0,4
		la $a0,resultado
		syscall
		
		li $v0,1
		add $a0,$t4,$zero
		syscall
		
		j final
	
	final: