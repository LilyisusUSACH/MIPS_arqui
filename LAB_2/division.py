def division_decimales(x,n,dec_acum):
    if(x<n and x>=0):
        x = x*10
        print(x-n,x,n,dec_acum)
        return (division_decimales(x-n,n,dec_acum+1))
    elif(x>=n):
        return (division_decimales(x-n,n,dec_acum+1))
    else:
        return dec_acum


def division (x, n, acum): # x / n
    if( x>=n ):
        return division(x-n, n, (acum + 1))
    elif (x>0):
        print(division_decimales(x,n,0))
    else:
        return acum

print(division(7,3,0))