while True:
    operation= str(input("Введите номер операции (1. арифметическая, 2. сравнение, 3. логическая, 4. побитовая, " \
"5. принадлежность, 6. тождественность, 7. выйти): "))
    if operation == '1':
        num1 = float(input("Введите первое число: "))
        num2 = float(input("Введите второе число: "))
        operant= input('введите команду (+, -, *, /, **, //, %): ')
        if operant== '+':
            result = num1 + num2
            print(f"{num1} + {num2} = {result}")
        elif operant == '-':
            result = num1 - num2
            print(f"{num1} - {num2} = {result}")
        elif operant == '*':
            result = num1 * num2
            print(f"{num1} * {num2} = {result}")
        elif operant == '/':
            try:
                result = num1 / num2
            except ZeroDivisionError:
                result = 0
            print(f"{num1} / {num2} = {result}")

        elif operant == '**':
            result = num1 ** num2
            print(f"{num1} ** {num2} = {result}")
        elif operant == '//':
            try:
                result = num1 // num2
            except ZeroDivisionError:
                result = 0
            print(f"{num1} // {num2} = {result}")
        elif operant == '%':
            try:
                result = num1 % num2
            except ZeroDivisionError:
                result = 0
            print(f"{num1} % {num2} = {result}")

    
    elif operation == '2':
        num1 = float(input("Введите первое число: "))
        num2 = float(input("Введите второе число: "))
        if num1 == num2:
            print(f"{num1}={num2}")
        elif num1 > num2:
            print(f"{num1} > {num2}")
        elif num1 < num2:
            result = num1 < num2
            print(f"{num1} < {num2}")
    
    elif operation == '4':
        operant = input('введите команду (&, |, ^, <<, >>, ~): ').lower()
        if operant == '&':
            num1 = int(input("Введите первое число: "))
            num2 = int(input("Введите второе число: "))
            result = num1 & num2
            print(f"{num1} AND {num2} = {result}")
            print(f"Двоичное представление: {bin(num1)} & {bin(num2)} = {bin(result)}")
        elif operant == '|':
            num1 = int(input("Введите первое число: "))
            num2 = int(input("Введите второе число: "))
            result= num1 | num2
            print(f"{num1} OR {num2} = {result}")
            print(f"Двоичное представление: {bin(num1)} | {bin(num2)} = {bin(result)}")
        elif operant == '^':
            num1 = int(input("Введите первое число: "))
            num2 = int(input("Введите второе число: "))
            result = num1 ^ num2
            print(f"{num1} XOR {num2} = {result}")
            print(f"Двоичное представление: {bin(num1)} ^ {bin(num2)} = {bin(result)}")
        elif operant == '<<':
            num1 = int(input("Введите число: "))
            num2 = int(input("Введите кол-во битов для сдвига: "))
            result = num1 << num2
            print(f"{num1} << {num2} = {result}")
            print(f"Двоичное представление: {bin(num1)} << {bin(num2)} = {bin(result)}")
        elif operant == '>>':
            num1 = int(input("Введите число: "))
            num2 = int(input("Введите кол-во битов для сдвига: "))
            result = num1 >> num2
            print(f"{num1} >> {num2} = {result}")
            print(f"Двоичное представление: {bin(num1)} >> {bin(num2)} = {bin(result)}")
        elif operant == '~':
            num1 = int(input("Введите число: "))
            result = ~num1
            print(f"NOT {num1} = {result}")
            print(f"Двоичное представление: ~{bin(num1)} = {bin(result)}")
    
    elif operation =='3':
        operant = input('введите команду (и/and, или/or, не/not): ').lower() 
        if operant =='и' or operant =='and':
            a = input("Введите первое значение: ").lower()
            b = input("Введите второе значение: ").lower()
            if a in ['true', 'истина', '1'] and b in ['true', 'истина', '1']:
                a = True
                b = True
                print(f"{a} AND {b} = True")
            elif a in ['false', 'ложь', '0'] and b in ['false', 'ложь', '0']:
                a = False
                b = False
                print(f"{a} and {b} = False")
            else:
                print(f"{a} AND {b} = False")
        elif operant =='или' or operant =='or':
            a = input("Введите первое значение: ").lower()
            b = input("Введите второе значение: ").lower()
            if a in ['true', 'истина', '1'] or b in ['true', 'истина', '1'] or a in ['true', 'истина', '1'] and b in ['true', 'истина', '1']:
                print(f"{a} or {b} = True")
            else:
                print(f"{a} or {b} = False")
        elif operant =='не' or operant =='not':
            a = input("Введите значение: ").lower()
            if a in ['true', 'истина', '1']:
                a = True
            else: a = False
        result=  not a
        print(f"NOT {a} = {result}")
    
    elif operation =='5' or operation == '6':
        operant = input('введите команду (in -1, is -2): ')
        if operant == '1':
            a = list(map(int, input("Введите список: ").split()))
            b = int(input("Введите искомый элемент: "))
            result = b in a
            num = a.count(b)
            print(f"Число элементов в списке: {num}")
        elif operant=='2':
            a = list(map(int, input("Введите список: ").split()))
            b = input("Введите искомый элемент: ")
            print(f"a is b: {a is b}")    
    elif operation == '7':
        break
    else: 
        print('Ошибка')
