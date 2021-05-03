def add(x, y):
    print(x + y)


add(5, 8)
result = add(5, 8)
print(result)  


# Returning values


def add(x, y):
    return x + y


add(1, 2)  
result = add(2, 3)
print(result)  

# Returning terminates the function


def add(x, y):
    return
    print(x + y)
    return x + y


result = add(5, 8)  
print(result)  

# Returning with conditionals


def divide(dividend, divisor):
    if divisor != 0:
        return dividend / divisor
    else:
        return "You fool!"


result = divide(15, 3)
print(result)  

another = divide(15, 0)
print(another)  