.data
	# Strings que seran necesarios despues
	solicitar_entrada: .asciiz "Por Favor ingrese un numero: "
	resultado: .asciiz "El resultado de la division es : "
	negativo: .byte '-'
	punto: .byte '.'
	newLine: .byte '\n'
.text

# Bloque principal
main:
	# Leemos dos entradas y las dejamos en las variables $s
	jal leer_entrada
	add $s0, $zero,$v0
	jal leer_entrada
	add $s1,  $zero,$v0
	
	# Las pasamos a las variables $a ya que seran argumentos de una nueva
	# llamada
	add $a0, $zero, $s0
	add $a1, $zero, $s1
	jal evaluar_signo
	
	# Esta llamada nos retorna los valores absolutos de los numeros
	# asi que, ahora esos seran nuestros valores a dividir
	# por lo que los pasamos como argumento a la division
	add $a0, $zero, $v0
	add $a1, $zero, $v1
	jal division
	
	# Para finalmente, lo que recibimos, mandarlo a imprimir en una funcion
	# destinada para ello
	add $a0, $zero, $v0
	add $a1, $zero, $v1
	jal imprimir_final
	
	# Se finaliza el programa sin errores
	j exit

exit:
	# Manera correcta de finalizar un programa
	li $v0,10
	syscall
	
evaluar_signo:
	# Añadimos al stack el ra, para poder tener
	# mas subrutinas dentro, sin perder las referencias
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	# Trabajamos con variables $t que seran temporales
	# ya que solo estan disponibles dentro de la llamada
	add $t0, $zero, $a0
	add $t1, $zero, $a1
	
	# Cargamos los string, esto, ya que cuando sea negativo,
	# modificaremos el string de salida con el signo "-"
	la $t2, resultado
	lb $t3, negativo
	
	# Verificamos si el denominador es negativo
	bltz $t0,primero_negativo

	# Si no lo es
	# Verificamos si el segundo es negativo
	bltz $t1,segundo_negativo
	
	# En caso de que ambos sean positivos
	# simplemente limpiamos las variables
	# y enviamos como salida, en los registros $v
	# los valores, ademas, recuperamos el valor de $ra
	# y limpiamos el stack
	terminar:
		# tambien llegamos aca cuando ya no hay mas numeros
		# negativos, retornando asi, los valores absolutos
		# de aquellos numeros.
		add $v0,$zero,$t0
		add $v1,$zero,$t1
		li $t0, 0
		li $t1, 0
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
	
	# En caso de que el primero sea negativo
	# Se calcula su valor absoluto, y se verifica si el
	# Segundo tambien es negativo, si lo es, se envia a invertir
	primero_negativo:
		sub $t0,$zero,$t0
		bltz $t1,invertir
		# Si solo el primero es negativo
		# Se modifica el string con el signo "-" al final
		sb $t3, 32($t2)
		j terminar

	segundo_negativo:
		# en caso de ser solo el segundo negativo, se calcula
		# su valor absoluto
		sub $t1,$zero,$t1
		# Se modifica el string con el signo "-" al final
		sb $t3, 32($t2)
		j terminar
		
	# En caso de ser ambos negativos, simplemente se calculan sus
	# valores absolutos y se devuelve 
	invertir:
		sub $t1,$zero,$t1
		j terminar
		
division:
	# Se pasan las entradas a variables temporales
	add $t0, $zero, $a0
	add $t1, $zero, $a1
	
	# Se añade espacio al stack
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	li $t2, 0 # Se crea un contador
	
	# En caso de que el numerador
	# sea menor que el denominador, se pasa inmediatamente
	# a calcular el resto (remainder)
	blt $t0,$t1,resto
	
	# ciclo que itera mientras el numerador sea mayor que
	# el denominador, restando el denominador al denominador
	# en cada paso, y a su vez, aumentando un contador
	mientras:
		sub $t0,$t0,$t1
		addi $t2,$t2,1
		bge $t0,$t1,mientras
	# En $t2 tengo el entero, que representara la parte entera
	# del resultado
	resto:
	# Multiplico lo que queda (el resto) por 100,
	# Para asi, calcular la parte decimal
	
	# Para multiplicar por 100, llamo dos veces a una subrutina que
	# multiplica por 10
		add $a0, $zero, $t0
		jal multi10
		add $a0, $zero, $v0
		jal multi10
		add $t0, $zero, $v0
		
		add $t1, $zero, $a1 # vuelvo a leer el a1 denominador

		add $t3, $zero, $zero # inicio un contador
		blt $t0,$t1,fin # veo si es necesario calcular el resto
		
		# Realizo el mismo procedimiento de la division de antes
		mientrasresto:
			sub $t0,$t0,$t1
			addi $t3,$t3,1
			bge $t0,$t1,mientrasresto
		
	fin: 	# Aca se llega cuando ya esta el resultado
	# tenemos la parte entera en t2 y la parte decimal en t3,
	# los pasamos a $v0 y $v1 respectivamente como salidass
	add $v0, $zero, $t2
	add $v1, $zero, $t3
	# limpiamos los registros
	li $t0, 0
	li $t1, 0
	li $t2, 0
	li $t3, 0
	# Devolvemos la return adress desde el stack
	# y limpiamos el stack
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	# volvemos a donde se llamo
	jr $ra

multi10:
	# Recibimos un valor en a0 y lo pasamos a $t0
	add $t0, $zero, $a0
	# creamos un contador que comienza en 1
	# ya que sumaremos 10 veces el numero
	# y la primera vez ya esta contada
	addi $t1, $zero,1
	add $t3, $zero, $t0
	# iremos sumando en un $t3, para no perder
	# el valor inicial que estara en $t0
	nofinmult:
		add $t3,$t0,$t3
		addi $t1,$t1,1
		beq $t1,10,finmult
		# sumamos hasta que el contador sea 10
		j nofinmult
		# si no es 10, volvemos a sumar
	finmult:
		# cuando ya esta el resultado se entrega en $v0
		add $v0, $zero, $t3
		# se limpian los registros temporales y se vuelve
		# a donde se llamo la funcion
		add $t0, $zero, $zero
		add $t1, $zero, $zero
		add $t3, $zero, $zero
		jr $ra

# subrutina/funcion que solicita una entrada numerica
# por consola, y la retorna en $v0
leer_entrada:
	la $a0, solicitar_entrada
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	jr $ra

# Funcion creada para mantener el orden
# solamente imprime un texto
imprimir_texto:
	li $v0,4
	syscall
	jr $ra

# Funcion creada por orden, imprime
# un numero
imprimir_numero:
	li $v0,1
	syscall
	jr $ra

# Funcion que imprime un caracter
imprimir_char:
	li $v0,11
	syscall
	jr $ra

# Funcion que imprime el resultado final
# con un formato correspondiente
imprimir_final:
	# creamos espacio en el stack y dejamos el $ra
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	# pasamos las entradas a variables temporales
	add $t0,$zero,$a0
	add $t1,$zero,$a1
	
	# imprimimos un texto para decir que este sera el resultado
	# tambien tiene el signo correspondiente si es negativo
	la $a0, resultado
	jal imprimir_texto
	
	# Imprimimos la parte entera del resultado
	add $a0,$zero,$t0
	jal imprimir_numero
	
	# Imprimimos un punto, que separa la parte decimal de la entera
	lb $a0, punto
	jal imprimir_char
	
	# Si $t2 es mayor o igual a 10, simplemente imprimo $t2,
	# pero, si es menor a 10, imprimo antes un 0 antes de $t2 tambien,
	# esto ya que cuando hay numeros menores a 10, como 1, 2, 3 ... estos
	# siguen representando a la centesima, osea deben ir en 0.0X.
	bge $t1,10,NoZero
	
	add $a0,$zero,$zero
	jal imprimir_numero
	NoZero:
		# si es mayor a 10, simplemente imprimo el numero, ya que siempre
		# tendra 2 digitos
		add $a0,$zero,$t1
		jal imprimir_numero
	
	# limpio los temporales, el stack, y vuelvo
	add $t0,$zero,$zero
	add $t1,$zero,$zero
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	jr $ra
	
		
