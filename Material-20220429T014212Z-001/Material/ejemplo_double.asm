#Utilizaci�n de co-procesador 1 para decimales de doble precisi�n

#N�meros de doble precisi�n s�lo pueden ser almacenados en registros
#de la forma $f(2n) ($f0, $f2, $f4 ...)

.data
	U: .double 0.1
	D: .double 0.01

.text
	#Instrucci�n que carga los n�meros definidos en .data en los
	#registros correspondientes
	l.d $f0, U
	l.d $f2, D
	
	#Instrucci�n para sumar dos n�meros de doble precisi�n
	add.d $f4, $f0, $f2
	
	#Instrucci�n para restar dos n�meros de doble precisi�n
	sub.d $f6, $f0, $f2
	
	#En este caso, el n�mero resultante no es exactamente -0.9
	#Para m�s informaci�n acerca de este fen�meno, visitar
	#https://0.30000000000000004.com/
