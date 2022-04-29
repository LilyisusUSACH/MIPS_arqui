.data
	fl_1: .float 0.1
	fl_2: .float 0.2

.text
	#carga de numeros flotantes en registros $f
	#NOTA: Si se desea trabajar con numeros de doble precision,
	#entonces se deben utilizar los registros pares ($f0, $f2, $f4, etc)
	l.s $f0, fl_1 #(l.s = load single precision)
	l.s $f1, fl_2

	#suma de numeros flotantes
	add.s $f2, $f0, $f1
	
	#resta de numeros flotantes
	sub.s $f3, $f0, $f1
	
	#guardar numero flotante en stack
	addi $sp, $sp, -4
	swc1  $f1, 0($sp)
	
	#cargar numero flotante desde stack
	lwc1 $f4, 0($sp)
	swc1  $f31, 0($sp)
	addi $sp, $sp, 4