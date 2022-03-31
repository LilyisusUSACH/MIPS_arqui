.data
	bienvenida : .asciiz "\nBienvenidos, seleccione la operacion que desea realizar"
	opciones : .asciiz "\n1)suma\n2)Multiplicacion por escalar\n3)producto escalar\n4)producto cruz\n"
	

.text
	menu:
		li $v0,4
		la $a0,bienvenida
		syscall
		li $v0,4
		la $a0,opciones
		syscall
		li $v0,5
		syscall
		add $s0,$v0,$zero
	manejo_menu:
		beq $s0,1,suma
		beq $s0,2,mult_escalar
		beq $s0,3,p_escalar
		beq $s0,4,cruz
	
	suma:
		j final
	
	mult_escalar:
		j final
		
	p_escalar:
		j final
		
	cruz:
		j final
		
	final: