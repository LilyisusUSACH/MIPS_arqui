.data
	# Guardamos los strings que seran usados
	# Posteriormente para Solicitar datos y 
	# mostrar el resultado
	m_escalar : .asciiz "\nIngrese el escalar por el cual se multiplicara el vector : "
	v_resultado : .asciiz "\nEl vector resultante es : ( "
	coma : .asciiz ", "
	cierre : .asciiz " )\n"

.text 
	# Leemos la direccion de memoria
	# Donde se pide nos desde el enunciado
	# leer los datos
	la $s0,0x10110040
	
	# OPCIONAL : DATOS PARA PRUEBA
			
	# Para la multi x escalar
	
	addi $t1,$zero,2
	sw $t1,0($s0)
	addi $t1,$zero,-3
	sw $t1,4($s0)
	addi $t1,$zero,4
	sw $t1,8($s0)
	
	# FIN datos de prueba
	
	mult_escalar:
		
		# Imprimimos un mensaje que
		# solicita al usuario ingresar
		# un valor entero como escalar
		li $v0,4
		la $a0,m_escalar
		syscall
		
		# Solicitamos por consola un valor entero
		li $v0,5
		syscall
		# Lo guardamos en $s2 (ya que no sera temporal
		# y se usara varias veces)
		add $s2,$v0,$zero
		
		# Leemos x, y ,z desde memoria
		# y lo multiplicamos por el escalar,
		# guardandolo sobre esas mismas variables
		# temporales
		lw $t1,0($s0)
		mul $t1,$t1,$s2
		lw $t2,4($s0)
		mul $t2,$t2,$s2
		lw $t3,8($s0)
		mul $t3,$t3,$s2	
		
		# Igual que antes, esto no es
		# necesario, pero por orden y modularidad
		# prefiero dejarlo asi
		j imprimir_vector
	
	# Esta funcion es la misma que en la parte11
	# Asi que no la describire mayormente
	# Ademas se utilizan los mismos $tX, pensando
	# en tener un standar.
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
	final: 
