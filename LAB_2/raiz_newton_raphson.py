import math
import numpy as np
def newton(x,y,i):
    if i < 7:
        x = x - (((x*x)-y)/(2*x))
        i += 1 
        x = newton(x,y,i)
    return x

#f = open("analizar.txt",'w')
diferencia = np.zeros(100)
eficacia = np.zeros(100)

eficacia[0] = 0
diferencia[0] = math.inf
resultado = ""
for i in range(1,100): # no se toma en cuenta el 0
                    # ya que es un problema de distancia
                    # y seria ilogico calcular la distancia 
                    # entre 2 vectore iguales
    for j in range(1,100):
        sqrt = math.sqrt(i)
        new = newton(j,i,0)
        efi = abs(sqrt/new)
        dif = abs(sqrt - new)
        eficacia[j] = eficacia[j] + efi
        diferencia[j] = diferencia[j] + dif
"""
for each in eficacia:
    print(each)
"""
result = np.where(eficacia == np.amax(eficacia))
print(result[0],np.amax(eficacia))

result = np.where(diferencia == np.amin(diferencia))
print(result[0],np.amin(diferencia))

'''
        stri = str(i)
        strj = str(j)
        strdif = str(dif)
        strsq = str(sqrt)
        strnew = str(new)
        resultado += stri+" "+strj+"|"+strdif+"|"+strsq+"|"+strnew+"|"+"\n-----------------------------------------------------------------\n"
     
f.write(resultado)
'''