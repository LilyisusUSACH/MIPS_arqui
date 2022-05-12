.data
	# Creamos float dobles, los cuales
	# Seran constantes
	x0: .double 6.0
	dos : .double 2.0
	
	# Creamos espacios en memoria para
	# recibir los valores en float double
	xv1: .double 0
	yv1: .double 0
	zv1: .double 0
	
	xv2: .double 0
	yv2: .double 0
	zv2: .double 0
	# Esto pricipalmente ya que son muchas
	# entradas, y no convendria tenerlas todas
	# en los registros solamente
	
	# Creamos strings y bytes, que serviran
	# para solicitar entradas y para mostrar la salida
	entrada: .asciiz "Ingrese el valor X del vector 1: "
	x : .byte 'X'
	y : .byte 'Y'
	z : .byte 'Z'
	Nuno : .byte '1'
	Ndos : .byte '2'
	resultado: .asciiz "La distancia entre ambos puntos es: "	

.text
main:
	# El main solo se encarga de llamar a las demaas funciones
	jal leer_entradas
	jal distancia_euclideana
	jal salida
	
	j exit

exit:
	# Finalizamos de manera correacta el programa
	li $v0,10
	syscall

# Funcion que se encarga de leer las entradas de tipo double
# Y almacenarlas en la memoria
leer_entradas:
	addi $sp,$sp,-4
	sw $ra, 0($sp)
	
	# Ademas, para solicitar las entradas, se ocupa un strin "entrada"
	# pero este se va modificando segun lo que se solicite
	
	# Para lograr aquello, tenemos que leer algunos bytes que contendran
	# las letras y numeros a modificar en codigo .ascii
	lb $t0, x
	lb $t1, y
	lb $t2, z
	lb $t3, Nuno
	lb $t4, Ndos
	la $a0, entrada
	
	# Para cada una de las entradas se imprime un texto
	# que indica cual componente es y de que vector
	# y luego se almacena en la memoria
	
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
	
	# Finalmente se devuelve el $ra
	# se vacia el stack y se vuelve a donde fue llamada
	lw $ra,0($sp)
	addi $sp,$sp,4
	
	jr $ra
	
# Funcion que calcula la distancia euclideana, para lograrlo
# primero realiza algunos calculos con los componentes de los vectores
# lo que entrega como resultado un numero, al cual debemos sacarle la raiz
# y ese es nuestro resultado
distancia_euclideana:
	addi $sp,$sp,-4
	sw $ra, 0($sp)
	
	# Leemos desde la memoria los valores flotantes
	# Se intento seguir con algunas nomenclaturas de flotantes
	# pero luego se uso cualquiera nomas
	
	# f4 a f10 U $f16 $f18	(temporales)
	ldc1 $f4,xv1
	ldc1 $f6,yv1
	ldc1 $f8,zv1
	ldc1 $f10,xv2
	ldc1 $f16,yv2
	ldc1 $f18,zv2
	
	# Los procedimientos matematicos a realizar
	# estan descritos arriba de donde se realizan
	
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
	
	# Se crean los argumentos para llamar a la funcion
	# que calcula la raiz

	add $a0,$zero,$zero #contador en 0
	ldc1 $f0,x0
	ldc1 $f20,dos
	jal raiz
	
	# Luego teniendo el resultado, simplemente se vuelve a donde
	# la funcion fue llamada
	lw $ra,0($sp)
	addi $sp,$sp,4
	jr $ra

# Esta funcion es la que se encarga de calcular la raiz,
# Funciona de manera recursiva, por lo que se va instanciando
# a si misma, hasta llegar a un caso base.
# Ademas, para realizar el calculo se utiliza el metodo
# de newton-rapshon

raiz: 	# Recibe en $f0 el x0
	# Recibe en $f2 el numero al cual aplicar raiz
	# Recibe en $f20 un 2
	# Recibe en $a0 el acumulador (limite)
	
	addi $sp,$sp,-4
	sw $ra, 0($sp)
	
	# Caso base, para tener 10 repeticiones
	beq $a0,10,fin
	
	# No caso base
	
	# Tenemos
	# X ($f0), Y ($f2), I ($a0)
	# Donde X ira cambiando en cada llamada recursiva
	# el Y, sera constante (el numero a calcular), y el iterador
	# solo servira para ver el caso base
	
	# la funcion a realizar es:
	# $f0 = X - ( (X^2 - Y)/(2*X) )
	
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
	
	# Finalmente en $f0 tenemos el resultado
	# que tambien sera entrada de la siguiente llamada
	
	# añadimos 1 al contador y volvemos a llamar a la funcion
	addi $a0,$a0,1
	jal raiz
	
	# En caso de llegar al caso base, se limpia el stack
	# y comienza a devolverse en las llamadas, que iban
	# quedando guardadas en el stack, hasta llegar al lugar
	# desde donde fue llamada la primera vez
	fin:
		lw $ra,0($sp)
		addi $sp,$sp,4
		jr $ra

# Funcion que imprime el resultado con un texto antes
salida:
	la $a0, resultado
	li $v0, 4
	syscall
	mov.d  $f12,$f0
	li $v0,3
	syscall
	jr $ra

# Funcion que imprime un texto
imprimir_texto:
	li $v0,4
	syscall
	jr $ra