
# 1- Bibliotecas e framwork e referencias externas
import pytest
# Funções que serão testadas
from calculadora.calculadora import somar_dois_numeros, subtrair_dois_numeros, multiplicar_dois_numeros, dividir_dois_numeros
from utils.utils import ler_csv         # Função de leitura de arquivos csv

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
    
def test_dividir_por_zero():
    num1 = 9
    num2 = 0
    resultado_esperado = 'Não é possivel dividir por zero'
    resultado_obtido = dividir_dois_numeros(num1, num2)
    assert resultado_esperado == resultado_obtido
    
# Tests utilizando massa de teste = Data Driven Test (DDT)
    # Dados em uma lista
    # Dados em um arquivo - Formatos: CSV (texto separado por virgulas), Json, XML, Dat
@pytest.mark.parametrize('num1, num2, resultado_esperado',  # Comando para leitura de dadaos de uma lista
                         [                                   # array / matriz
                             (5, 7, 12),                     # tupla / registro
                             (0, 8, 8),
                             (10, -15, -5),
                             (6, 0.75, 6.75)
                         ]
                        )
def test_somar_dois_numeros_lista(num1, num2, resultado_esperado):  # Utilizando a massa de testes acima
    resultado_obtido = somar_dois_numeros(num1, num2)
    assert resultado_esperado == resultado_obtido

@pytest.mark.parametrize('num1, num2, resultado_esperado',      # Utilizando a massa de testes no arquivo fixtures
                        ler_csv('./Calculadora140/fixtures/massa_somar.csv')      # Botão direito no arquivo massa / Copy Relative Path
                        )
def test_somar_dois_numeros_csv(num1, num2, resultado_esperado):
    resultado_obtido = somar_dois_numeros(float(num1), float(num2))
    assert float(resultado_esperado) == resultado_obtido
    