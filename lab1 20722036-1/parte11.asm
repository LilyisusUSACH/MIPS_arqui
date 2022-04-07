.data
	# Guardamos los strings que seran usados
	# Posteriormente para mostrar el resultado
	
	v_resultado : .asciiz "\nEl vector resultante es : ( "
	coma : .asciiz ", "
	cierre : .asciiz " )\n"

.text
	# Leemos la direccion de memoria
	# Donde se pide nos desde el enunciado
	# leer los datos
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
	
	# FIN datos de prueba
	
	suma:
		# Leemos x1 y x2 desde la memoria
		lw $t1,0($s0)
		lw $t2,20($s0)
		# y los sumamos, guardando el resultado
		# en el mismo registro temporal 1
		add $t1,$t1,$t2
		
		# El mismo procedimiento para y1 e y2
		lw $t2,4($s0)
		lw $t3,24($s0)
		# y lo almacenamos en t2
		add $t2,$t2,$t3
		
		# Finalmente hacemos lo mismo con z1 y z2
		lw $t3,8($s0)
		lw $t4,28($s0)
		add $t3,$t3,$t4
		
		j imprimir_vector
		
	imprimir_vector:
		
		# Primero le damos la instruccion
		# de imprimir un string
		li $v0,4
		# Le pasamos el string a imprimir
		la $a0,v_resultado
		# Y ejecutamos la orden
		syscall
		
		# Luego le damos la instruccion
		# De leer un entero que estara almacenado
		# en $a0
		li $v0,1
		# Almacenamos en $a0 el x resultante
		add $a0,$t1,$zero
		syscall
		# Ejecutamos la orden de imprimirlo
		
		# Posteriormente por temas de orden
		# Y solo por estetica, imprimimos
		# una coma (string) , que separa el x del y
		li $v0,4
		la $a0,coma
		syscall # Ya sabemos que hace...
		
		# Repetimos lo mismo de hace antes, pero
		# ahora con el y resultante, que esta almacenado
		# en $t2 y lo mostramos en consola
		li $v0,1
		add $a0,$t2,$zero
		syscall
		
		# Otra coma para dar el formato de vector
		# esta vez para separar y de z
		li $v0,4
		la $a0,coma
		syscall
		
		# Posteriormente mostramos z
		li $v0,1
		add $a0,$t3,$zero
		syscall
		
		# Y por formato cerramos el parentesis
		# y asi se ve ordenado y con formato de
		# vector.
		li $v0,4
		la $a0,cierre
		syscall
		
		# Aca pongo esto pensando en la 
		# modularidad del programa
		# en caso de ser requerido con otras funciones mas
		j final
		
	final: