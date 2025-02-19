# Exercicio construido do zero utilizando as informações do site Sauce Demo.

# 1- Bibliotecas (fremework)
import selenium
from selenium import webdriver
from selenium.webdriver.common.by import By

# 2- Classe (opcional)
class Teste_Produtos():
    
    # 2.1- Atributos
    url = "https://saucedemo.com"           # endereço do site alvo

    # 2.2- Funções e Métodos
    def setup_method(self, method):         # setup = iniciar
        self.driver = webdriver.Chrome()    # driver = selenium
        self.driver.implicitly_wait(10)      # tempo de retardo para execução dos seletores (clicks)
        
    def teardown_method(self, method):      # método de finalização dos testes
        self.driver.quit()                  # encerra / destroi o objeto do selenium webdriver da memória
        
    def test_selecionar_produto(self):      # método de teste
        self.driver.get(self.url)                   # abre o navegador
        self.driver.find_element(By.ID, "user-name").send_keys("standard_user")     # escreve no campo user name
        self.driver.find_element(By.NAME, "password").send_keys("secret_sauce")     # escreve senha
        