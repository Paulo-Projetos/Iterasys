# Teste de Unidade
def somar_dois_numeros(num1, num2):
    return num1 + num2

def subtrair_dois_numeros(num1, num2):
    return num1 - num2

def multiplicar_dois_numeros(num1, num2):
    return num1 * num2

def dividir_dois_numeros(num1, num2):
    try:
        return num1 / num2
    except(ZeroDivisionError):      # Condições para informar que a divisão não pode ser feita por zero.
        return 'Não é possivel dividir por zero'
    

