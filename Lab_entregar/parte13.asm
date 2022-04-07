.data
	# Guardamos los strings que seran usados
	# Posteriormente para Solicitar los componentes del
	# vector y para mostrar el resultado
	punto_x : .asciiz "\nIngrese la componente X del vector: "
	punto_y : .asciiz "\nIngrese la componente Y del vector: "
	punto_z : .asciiz "\nIngrese la componente Z del vector: "
	coma : .asciiz ", "
	cierre : .asciiz " )\n"
	resultado : .asciiz "\nEl resultado es : "
	
.text
	# Leemos la direccion de memoria
	# Donde se pide nos desde el enunciado
	# leer los datos
	la $s0,0x10110060
	
	# OPCIONAL : DATOS PARA PRUEBA
	# Para el producto escalar
	addi $t1,$zero,3
	sw $t1,0($s0)
	addi $t1,$zero,0
	sw $t1,4($s0)
	addi $t1,$zero,4
	sw $t1,8($s0)
	
	# FIN datos de prueba
	
	p_escalar:
		
		# Leemos el vector desde la memoria
		lw $t1,0($s0)
		lw $t2,4($s0)
		lw $t3,8($s0)
		
		# Solicitamos el X del segundo vector
		li $v0,4
		la $a0,punto_x
		syscall
		li $v0,5
		syscall
		# Calculamos inmediatamente con lo ingresado
		# por consola y almacenamos en $t1
		mul $t1,$t1,$v0
		
		# Solicitamos el Y del segundo vector
		# y lo dejamos en $t2
		li $v0,4
		la $a0,punto_y
		syscall
		li $v0,5
		syscall
		mul $t2,$t2,$v0
		
		# Solicitamos el Z del segundo vector
		# y lo dejamos en $t3
		li $v0,4
		la $a0,punto_z
		syscall
		li $v0,5
		syscall
		mul $t3,$t3,$v0
		
		# Calculamos la suma del
		# X, Y, Z resultantes
		add $t4,$t1,$t2
		add $t4,$t4,$t3
	
		j imprimir_escalar
		
	imprimir_escalar:
		
		# Esta vez cambia el texto
		# ya que sera un solo valor
		li $v0,4
		la $a0,resultado
		syscall
		
		li $v0,1
		add $a0,$t4,$zero
		syscall
		
		j final
	
	final: