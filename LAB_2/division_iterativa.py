def div(i, n):
    acum = 0
    while i >= n:
        i = i - n
        acum += 1
    i = i * 100
    resto = 0
    while i >= n:
        i = i - n
        resto += 1
    return acum , resto

print(div(5,2))
