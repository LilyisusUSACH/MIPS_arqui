def newton(x,y,i):
    if i < 7:
        x = x - (((x*x)-y)/(2*x))
        i += 1 
        x = newton(x,y,i)
    return x

y = int(input("inregese el numero a calcular: "))
print(newton(1,y,0))