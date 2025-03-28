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
        self.driver.implicitly_wait(20)      # tempo de retardo para execução dos seletores (clicks)
        
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
        
        # 3- Login Positivo - Usuário autenticado com sucesso
        self.driver.find_element(By.ID, "perfil-hidden").click()    # Acessa perfil
        self.driver.find_element(By.ID, "UrlLogin").click() # Login
        self.driver.find_element(By.ID, "ContentSite_txtEmail").send_keys("pedro-peixoto79@atrix.com.br")   # e-mail
        self.driver.find_element(By.ID, "ContentSite_txtPassword").send_keys("AiZSHILtZZ1") # Senha
        self.driver.find_element(By.ID, "ContentSite_ibtContinue").click()  # Continuar
        
        # 5- Fluxo de compra a partir de um banner - Produto = Buque Luxo com 6 Girassois
        self.driver.find_element(By.CSS_SELECTOR, ".item-3").click() # Buques
        self.driver.find_element(By.ID, "inputSearchAddress").send_keys("23057-049") # Peenche CEP
        self.driver.find_element(By.CSS_SELECTOR, ".itemAddress").click()   # Confirma indereço
        self.driver.find_element(By.CSS_SELECTOR, ".apply-button").click()  # Aplica - confirma informações
        self.driver.find_element(By.CSS_SELECTOR, ".carousel-brands").click() # Buque de Girassois
        self.driver.find_element(By.NAME, "ctl00$txtDsKeyWord").send_keys("Buquê Luxo com 6 Girassóis")  # Seleciona buque pelo nome
        self.driver.find_element(By.ID, "btnSearch").click()    # Clica na lupa de procura
        self.driver.find_element(By.XPATH, "//h2[text()='Buquê Luxo com 6 Girassóis']").click() # Clica no produto escolhido - Comando indicado pelo ChatGpt
        assert self.driver.find_element(By.ID, "ContentSite_lblProductDsName").text == "BUQUÊ LUXO COM 6 GIRASSÓIS" # Confirma produto
        self.driver.find_element(By.ID, "ContentSite_txtZip").send_keys("23057-049")    # Preenche o CEP
        time.sleep(2)
        assert self.driver.find_element(By.ID, "ContentSite_txtQtdBy").get_attribute("value") == "1"    # Confirma quantidade para compra - Comando indicado pelo ChatGpt.
        self.driver.find_element(By.ID, "ContentSite_lbtBuy").click()   #   Adiciona ao carrinho
        time.sleep(2)
        self.driver.find_element(By.ID, "btConfirmShippingData").click()    # Confirma data e horario de entrega
        time.sleep(2)
        assert self.driver.find_element(By.CSS_SELECTOR, "h1.titulo-dept.title-defaut-interna").text == "MEU CARRINHO" # Confirma localização
        assert self.driver.find_element(By.CSS_SELECTOR, ".prodBasket_nome").text == "Buquê Luxo com 6 Girassóis"   # Confirma produto no carrinho
        self.driver.find_element(By.ID, "ContentSite_Basketcontrol1_rptBasket_imbFinalize_0").click()   # confirma compra
        