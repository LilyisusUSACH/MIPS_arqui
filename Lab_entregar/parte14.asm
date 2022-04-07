.data
	first_vector : .asciiz "\nPara el primer vector : "
	sec_vector : .asciiz "\nPara el segundo vector : "
	punto_x : .asciiz "\n	Ingrese la componente X del vector: "
	punto_y : .asciiz "\n	Ingrese la componente Y del vector: "
	punto_z : .asciiz "\n	Ingrese la componente Z del vector: "
	v_resultado : .asciiz "\nEl vector resultante es : ( "
	coma : .asciiz ", "
	cierre : .asciiz " )\n"

.text
	# No leemos nada de la memoria, todo
	# se usa desde la consola a los
	# registros
	cruz:
		# Solicitamos los datos del primer vector
		li $v0,4
		la $a0,first_vector
		syscall
		
		# Leemos el x
		li $v0,4
		la $a0,punto_x
		syscall
		li $v0,5
		syscall
		add $t0,$v0,$zero
		
		# Leemos el y
		li $v0,4
		la $a0,punto_y
		syscall
		li $v0,5
		syscall
		add $t1,$v0,$zero
		
		# Leemos el z
		li $v0,4
		la $a0,punto_z
		syscall
		li $v0,5
		syscall
		add $t2,$v0,$zero
		
		# Ahora pasamos al segundo
		# vector
		li $v0,4
		la $a0,sec_vector
		syscall
		
		li $v0,4
		la $a0,punto_x # x
		syscall
		li $v0,5
		syscall
		add $t3,$v0,$zero
		
		li $v0,4
		la $a0,punto_y # y
		syscall
		li $v0,5
		syscall
		add $t4,$v0,$zero
		
		li $v0,4
		la $a0,punto_z # z
		syscall
		li $v0,5
		syscall
		add $t5,$v0,$zero
		
		# Segun las operaciones que deben hacerse
		# para un producto cruz se hacen
		
		# Aca uso las $sX porque se necesitan
		# demasiadas variables y seria
		# mas uso de tiempo - recursos si las guardo
		# en memoria para despues leerlas
		
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

		# Los guardamos en $t1,$t2,$t3 
		# para mantener el standar
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
	final: