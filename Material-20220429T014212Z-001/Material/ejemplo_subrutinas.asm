# $vx => retornos subrutinas, códigos syscall
# $ax => argumentos subrutinas/syscall
# $tx => variables locales
# $sx => variables globales

# Bloque principal

main:
	# Definición de valores
	li $s0, 10
	li $s1, 15
	li $s2, 20

	# $s0 + $s1
	add $a0, $zero, $s0
	add $a1, $zero, $s1
	jal sum
	
	# ($s0 + $s1) + $s2
	add $a0, $zero, $v0
	add $a1, $zero, $s2
	jal sum
	
	# Mostrar por consola resultado
	add $a0, $zero, $v0
	jal print
	
	# Salida de programa
	jal exit

# Definición de subrutinas

sum:
	# Uso de variables locales
	add $t0, $zero, $a0
	add $t1, $zero, $a1
	
	# Suma de argumentos
	add $v0, $t0, $t1
	
	# Limpieza de variables locales
	li $t0, 0
	li $t1, 0
	
	jr $ra
	
print:
	li $v0, 1
	syscall
	
	jr $ra
	
exit:
	li $v0, 10
	syscall