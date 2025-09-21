# a= int(input("Введите первое число: "))
# b= int(input("Введите первое число: "))
# if a == 1:
#     print('dfghj')



#     if operant == 'and':
#         num1 = int(input("Введите первое число: "))
#         num2 = int(input("Введите второе число: "))
#         result = num1 and num2
#         print(result)
#     elif operant == 'or':
#         result = num1 or num2
#         print(result)
#     elif operant == 'not':
#         result = num1 is not num2
#         print(result)

# a = list(map(int, input("Введите список: ").split()))
# b = int(input("Введите искомый элемент: "))
# result = b in a
# if result== True:
#     num = a.count(b)
#     print(f"Число элементов в списке: {num}")
# else:
#     print(result)
# a = list(map(int, input("Введите список: ").split()))
# b = input("Введите искомый элемент: ")
# print(a is b)

# a = input("Введите список: ")
# b = input("Введите искомый элемент: ")
# print(f"a is b: {a is b}")
while True:
    operation= str(input("Введите номер операции (арифметическая -1, сравнение -2, логическая -3, побитовая -4, " \
"принадлежность -5, тождественность -6, выйти -7): "))
    if operation == '1':
        num1 = float(input("Введите первое число: "))
        num2 = float(input("Введите второе число: "))
        operant= input('введите команду (+, -, *, /, **, //, %): ')
        if operant== '+':
            result = num1 + num2
            print(f"{num1} + {num2} = {result}")
    elif operation == '7':
        break
    
    else:
        print('bbb')
