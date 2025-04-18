
# 1- Bibliotecas e framwork e referencias externas
import pytest
# Funções que serão testadas
from calculadora.calculadora import somar_dois_numeros, subtrair_dois_numeros, multiplicar_dois_numeros, dividir_dois_numeros

# 2- Testes
def test_somar_dois_numeros():
    # Padrão / Standard AAA (se diz Tiple A / 3A) = Arrange, Act, Assert
    
    # Arrange / Prepara / Configura
    num1 = 5
    num2 = 7
    resultado_esperado = 12
    # Act / Executa
    resultado_obtido = somar_dois_numeros(num1, num2)
    # Assert / Valida
    assert resultado_esperado == resultado_obtido

def test_subtrair_dois_numeros():
    num1 = 5
    num2 = 7
    resultado_esperado = -2
    resultado_obtido = subtrair_dois_numeros(num1, num2)
    assert resultado_esperado == resultado_obtido

def test_multiplicar_dois_numeros():
    num1 = 5
    num2 = 7
    resultado_esperado = 35
    resultado_obtido = multiplicar_dois_numeros(num1, num2)
    assert resultado_esperado == resultado_obtido

def test_dividir_dois_numeros():
    num1 = 9
    num2 = 3
    resultado_esperado = 3
    resultado_obtido = dividir_dois_numeros(num1, num2)
    assert resultado_esperado == resultado_obtido
    