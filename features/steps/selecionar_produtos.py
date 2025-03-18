# 1- Bibliotecas
from behave import given, when, then
from selenium import webdriver
from selenium.webdriver.common.by import By
import time


@given(u'que acesso o site Sauce Demo')
def step_impl(context):
    context.driver = webdriver.Chrome()     # Instanciar o objeto do selenium webdriver especializado para o chrome
    context.driver.maximize_window()        # maximizar a janela do navegador
    context.driver.implicitly_wait(10)      # Esperar até 10 segundos por qualquer elemento
    context.driver.get("https://www.saucedemo.com") # Abrir o navegador no indereço do site alvo
    

@when(u'preencho os campos de login com usuario {usuario} e senha {senha}')
def step_impl(context, usuario, senha):
    context.driver.find_element(By.ID, "user-name").send_keys(usuario)  # Preencha usuario
    context.driver.find_element(By.ID, "password").send_keys(senha)     # Preenche senha
    context.driver.find_element(By.ID, "login-button").click()          # Clica em login


@then(u'sou direcionado para a pagina Home')
def step_impl(context):
    time.sleep(5)
    assert context.driver.find_element(By.CSS_SELECTOR, ".title").text == "Products"
    time.sleep(5)
    
    # teardown = encerramento
    context.driver.quit()
    
    # Validar a mensagem de erro de login
@then(u'exibe a mensagem de erro no login')
def step_impl(context):
    assert context.driver.find_element(By.CSS_SELECTOR, "h3").text == "Epic sadface: Username and password do not match any user in this service"
    
    #teardown = encerramento
    context.driver.quit()
    
    
    
