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
        self.driver.find_element(By.CSS_SELECTOR, "input.submit-button.btn_action").click()   #utilisando CSS para faser o click de login
        
        # transição de página:
        assert self.driver.find_element(By.CSS_SELECTOR, ".title").text == "Products"   # assert para avaliação de texto (Produtos)
        assert self.driver.find_element(By.CSS_SELECTOR, ".inventory_item_name").text == "Sauce Labs Backpack"  # Confirma se é a mochila
        assert self.driver.find_element(By.CSS_SELECTOR, ".inventory_item_price").text == "$29.99"  #Confirma o preço da mochila $ 29,99
        self.driver.find_element(By.ID, "add-to-cart-sauce-labs-backpack").click()  # Inclui mochila no carrinho
        assert self.driver.find_element(By.CSS_SELECTOR, ".shopping_cart_badge").text == "1"    # Valida quantidade e produto no carrinho
        self.driver.find_element(By.CSS_SELECTOR, ".shopping_cart_link").click()    # acessa o carrinho
        assert self.driver.find_element(By.CSS_SELECTOR, ".title").text == "Your Cart"  # Confirma titulo Carrinho
        assert self.driver.find_element(By.CSS_SELECTOR, ".cart_quantity").text == "1"  # Confirma quantidade carrinho
        assert self.driver.find_element(By.CSS_SELECTOR, ".inventory_item_price").text == "$29.99" # confirma o preço de $ 29,99
        self.driver.find_element(By.NAME, "remove-sauce-labs-backpack").click() # remove item do carrinho
        self.driver.find_element(By.ID, "react-burger-menu-btn").click()    # Acesso o logout
        self.driver.find_element(By.ID, "logout_sidebar_link").click()  # Confirma o logout (sair)
        
        