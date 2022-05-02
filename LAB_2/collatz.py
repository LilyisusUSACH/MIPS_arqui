import numpy as np
import math
def collatz(x):
    datos = np.array([x])
    pasos = 0
    while x != 1:
        pasos += 1
        if (x % 2) == 0:
            x = x/2
        else:
            x = (3*x)+1
        datos = np.append(datos,x)
    return datos , pasos

arr = np.zeros(100000)
arrPasos = np.zeros(100000)

arr[0] = 0
for i in range(1,100000):
    arr[i] = np.amax(collatz(i)[0])
    arrPasos[i] = collatz(i)[1]

max = np.where(arr == np.amax(arr))
maxPasos = np.where(arrPasos == np.amax(arrPasos))
print(max[0],np.amax(arr))
print(maxPasos[0],np.amax(arrPasos))