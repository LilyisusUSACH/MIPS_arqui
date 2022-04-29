#Utilización del stack para direcciones de retorno

#El programa utiliza una subrutina de 3 argumentos, la cual a la vez utiliza una
#subrutina de 2 argumentos para sumar 3 números almacenados en el registro, con
#el objetivo de demostrar cómo manejar las direcciones de retorno en el stack

main:
	#Se busca $s0 + $s1 + $s2
	li $s0, 2
	li $s1, 4
	li $s2, 5
	
	#Se cargan los valores en registros $a
	add $a0, $zero, $s0
	add $a1, $zero, $s1
	add $a2, $zero, $s2
	
	#Se llama a subrutina add3
	jal add3
	
	#Se carga el resultado de la suma en $a0, para mostrar el resultado por consola
	add $a0, $v0, $zero
	
	#Se imprime el resultado por consola
	jal print
	
	#Se finaliza la operación
	j exit

#Suma 3 valores (dados en $a0, $a1 y $a2)
add3:	
	#Se asigna espacio al stack
	addi $sp, $sp, -4
	
	#Se almacena actual dirección de retorno en stack
	sw $ra, 0($sp)
	
	#Se llama a subrutina add2
	jal add2
	
	#Se cargan argumentos para segundo llamado add2
	add $a0, $v0, $zero #$a0 ahora es $a0+$a1
	add $a1, $a2, $zero #$a1 ahora es $a2

	#Se llama a subrutina add2
	jal add2
	
	#ahora en $v0 esta nuestro resultado final
	
	#Se carga la dirección de retorno guardada en stack
	lw $ra, 0($sp)
	
	#Se libera espacio de stack
	add $sp, $sp, 4
	
	#Se utiliza la dirección de retorno para volver a main
	jr $ra

#Suma 2 valores (dados en $a0 y $a1)
add2:
	add $v0, $a0, $a1
	jr $ra

#Imprime $a0 por consola
print:
	li $v0, 1
	syscall
	jr $ra

#Finaliza el programa
exit:
	li $v0, 10
	syscall