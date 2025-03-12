# Exercicio construido utilizando-se de informações do site Giuliana Flores.

# 1- Bibliotecas (fremework)
import selenium
from selenium import webdriver
from selenium.webdriver.common.by import By
import time

# 2- Classe (opcional)
class Teste_Giuliana_Flores():
    
    # 2.1- Atributos
    url = "https://www.giulianaflores.com.br"        # endereço do site alvo

    # 2.2- Funções e Métodos
    def setup_method(self, method):         # setup = iniciar
        self.driver = webdriver.Chrome()    # driver = selenium
        self.driver.implicitly_wait(50)      # tempo de retardo para execução dos seletores (clicks)
        
    def teardown_method(self, method):      # método de finalização dos testes
        self.driver.quit()                  # encerra / destroi o objeto do selenium webdriver da memória
        
    def test_giuliana_flores(self):      # método de teste
        self.driver.get(self.url)        # abre o navegador
        
        # 2- Criação de usuário
        self.driver.find_element(By.ID, "perfil-hidden").click()    # Acessa perfil
        self.driver.find_element(By.ID, "UrlLogin").click()    # Acessa cadastro
        self.driver.find_element(By.ID, "ContentSite_ibtNewCustomer").click()   # Efetua cadastro
        self.driver.find_element(By.NAME, "ctl00$ContentSite$txtName").send_keys("Pedro Manoel Anthony Peixoto")    #nome
        self.driver.find_element(By.ID, "ContentSite_txtCpf").send_keys("262.710.158-75")   # CPF
        self.driver.find_element(By.ID, "ContentSite_txtEmail").send_keys("pedro-peixoto79@atrix.com.br") # e-mail
        self.driver.find_element(By.ID, "ContentSite_txtPasswordNew").send_keys("AiZSHILtZZ1")   # senha
        self.driver.find_element(By.NAME, "ctl00$ContentSite$CustomerAddress$txtZip").send_keys("23057-049")    # CEP
        self.driver.find_element(By.ID, "ContentSite_CustomerAddress_txtAddress").send_keys("Cinquenta")    # Endereço
        self.driver.find_element(By.ID, "ContentSite_CustomerAddress_txtAddressNumber").send_keys("300") # Numero
        self.driver.find_element(By.ID, "ContentSite_CustomerAddress_txtDistrict").send_keys("Inhoaiba")    # Bairro
        self.driver.find_element(By.ID, "ContentSite_CustomerAddress_txtCity").send_keys("Rio de Janeiro")  # Cidade
        #self.driver.find_element(By.ID, "ContentSite_CustomerAddress_dropState").send_keys("RIO DE JANEIRO")    # Estado - preenchmento automatico
        self.driver.find_element(By.ID, "ContentSite_CustomerAddress_txtPhoneCelularNum").send_keys("21370057671")
        self.driver.find_element(By.ID, "ContentSite_divNewsletter").click()    # Ofertas por e-mail
        #self.driver.find_element(By.ID, "recaptcha-anchor").click()  # Não sou robo não esta operacional
        self.driver.find_element(By.ID, "ContentSite_btnCreateCustomer").click() # Finalizar cadastro
        
        # 3- Login Negativo - Usuário Invalido
        self.driver.find_element(By.ID, "perfil-hidden").click()    # Acessa perfil
        self.driver.find_element(By.ID, "UrlLogin").click() # Login
        self.driver.find_element(By.ID, "ContentSite_txtEmail").send_keys("pedro-peixoto79@")   # e-mail
        self.driver.find_element(By.ID, "ContentSite_txtPassword").send_keys("AiZSHILtZZ1") # Senha
        self.driver.find_element(By.ID, "ContentSite_ibtContinue").click()  # Continuar
        time.sleep(5)
        
        