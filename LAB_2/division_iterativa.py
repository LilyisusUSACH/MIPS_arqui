def div(i, n):
    acum = 0
    while i >= n:
        i = i - n
        acum += 1
    rep = 0
    i = i * 100
    resto = 0
    while rep < 2: # Hay resto
        rep += 1
        while i >= n:
            i = i - n
            resto += 1
    return acum , resto

print(div(1,2))
