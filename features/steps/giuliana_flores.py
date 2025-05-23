# 1- Bibliotecas
from behave import given, when, then
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import time

# Bloco Cadastro Usuario
@given(u'que acesso o site giulianaflores.com.br')
def step_impl(context):
    context.driver = webdriver.Chrome() 
    context.driver.maximize_window() 
    context.driver.implicitly_wait(10)
    context.driver.get("https://www.giulianaflores.com.br/customer.aspx?flow=2")
    
@when(u'preencho os campos de cadastro com nome {nome} cpf {cpf} email {email} e senha {senha}')
def step_impl(context, nome, cpf, email, senha):
    context.driver.find_element(By.ID, "ContentSite_txtName").send_keys(nome)
    context.driver.find_element(By.ID, "ContentSite_txtCpf").send_keys(cpf)
    context.driver.find_element(By.ID, "ContentSite_txtEmail").send_keys(email)
    context.driver.find_element(By.ID, "ContentSite_txtPasswordNew").send_keys(senha)
    
@when(u'preencho os campos de meu endereço com cep {cep} numero {numero} e celular {celular}')
def step_impl(context, cep, numero, celular):
    context.driver.find_element(By.ID, "ContentSite_CustomerAddress_txtZip").send_keys(cep)
    context.driver.find_element(By.ID, "ContentSite_CustomerAddress_txtAddressNumber").send_keys(numero)
    context.driver.find_element(By.ID, "ContentSite_CustomerAddress_txtPhoneCelularNum").send_keys(celular)

@when(u'eu clico em não sou robô')
def step_impl(context):
    time.sleep(2)
    # Bloco de solução para o item "Não sou Roobo", indicado pelo chatgpt
    # Trocar para o iframe do reCAPTCHA
    WebDriverWait(context.driver, 10).until(
        EC.frame_to_be_available_and_switch_to_it((By.XPATH, "//iframe[contains(@title, 'reCAPTCHA')]")))
    # Clicar na caixa de seleção do reCAPTCHA
    WebDriverWait(context.driver, 10).until(
        EC.element_to_be_clickable((By.CLASS_NAME, "recaptcha-checkbox"))).click()
    # Voltar ao contexto principal da página
    context.driver.switch_to.default_content()
    time.sleep(2)
    
@then(u'eu clico em finalizar cadastro')
def step_impl(context):
    context.driver.find_element(By.ID, "ContentSite_btnCreateCustomer").click()
    #teardown = encerramento
    context.driver.quit()

# Bloco Login1 Positivo
@when(u'clico no icone perfil')
def step_impl(context):
    context.driver.find_element(By.ID, "perfil-hidden").click()
@when(u'clico em login/cadastrar')
def step_impl(context):
    context.driver.find_element(By.ID, "UrlLogin").click()
@when(u'preencho os campos de login com email {email} e senha {senha}')
def step_impl(context, email, senha):
    context.driver.find_element(By.ID, "ContentSite_txtEmail").send_keys(email)
    context.driver.find_element(By.ID, "ContentSite_txtPassword").send_keys(senha)
@then(u'eu clico em continuar')
def step_impl(context):
    context.driver.find_element(By.ID, "ContentSite_ibtContinue").click()
    #teardown = encerramento
    context.driver.quit()

# Bloco Login2 Negativo
@when(u'eu clico em continuar')
def step_impl(context):
    context.driver.find_element(By.ID, "ContentSite_ibtContinue").click()
@then(u'exibe mensagem de erro')
def step_impl(context):
    context.driver.find_element(By.ID, "ContentSite_divMessages").text == "e-mail ou senha inválidos!"
    #teardown = encerramento
    context.driver.quit()
    

# Bloco Fluxo de Compra
@when(u'eu clico em presentes')
def step_impl(context):
    context.driver.find_element(By.CSS_SELECTOR, ".item-1").click()
@when(u'eu prencho cep {cep}, clico em endereço e clico em Aplicar')
def step_impl(context, cep):
    context.driver.find_element(By.ID, "inputSearchAddress").send_keys(cep)
    context.driver.find_element(By.CSS_SELECTOR, ".divAdresses").click()
    context.driver.find_element(By.CSS_SELECTOR, ".apply-button").click()
@when(u'eu preencho campo de procura com Bolo e clico na lupa')
def step_impl(context):
    context.driver.find_element(By.ID, "txtDsKeyWord").send_keys("Bolo")
    context.driver.find_element(By.ID, "btnSearch").click()
@when(u'clico no item Bolo Parabens a Você')
def step_impl(context):
    context.driver.find_element(By.CSS_SELECTOR, "h2.title-item").click()
@when(u'clico em Adicionar ao Carrinho')
def step_impl(context):    
    context.driver.find_element(By.ID, "ContentSite_lbtBuy").click()
@then(u'clico em ok para previsão de entrega')
def step_impl(context):   
    context.driver.find_element(By.ID, "btConfirmShippingData").click()
    
    #teardown = encerramento
    context.driver.quit()
    










