#Utilización de co-procesador 1 para decimales de doble precisión

#Números de doble precisión sólo pueden ser almacenados en registros
#de la forma $f(2n) ($f0, $f2, $f4 ...)

.data
	U: .double 0.1
	D: .double 0.01

.text
	#Instrucción que carga los números definidos en .data en los
	#registros correspondientes
	l.d $f0, U
	l.d $f2, D
	
	#Instrucción para sumar dos números de doble precisión
	add.d $f4, $f0, $f2
	
	#Instrucción para restar dos números de doble precisión
	sub.d $f6, $f0, $f2
	
	#En este caso, el número resultante no es exactamente -0.9
	#Para más información acerca de este fenómeno, visitar
	#https://0.30000000000000004.com/
