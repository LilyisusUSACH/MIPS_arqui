def div(i, n):
    acum = 0
    while i >= n:
        i = i - n
        acum += 1
    rep = 0
    while i > 0 and rep < 4: # Hay resto
        i = i * 10
        acum = acum *10
        rep += 1
        while i >= n:
            i = i - n
            acum += 1
    return acum/pow(10,rep)

print(div(3,3))
