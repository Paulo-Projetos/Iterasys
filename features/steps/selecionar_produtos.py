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
    
# Preencher com usuário e senha
@when(u'preencho os campos de login com usuario {usuario} e senha {senha}')
def step_impl(context, usuario, senha):
    context.driver.find_element(By.ID, "user-name").send_keys(usuario)  # Preencha usuario
    context.driver.find_element(By.ID, "password").send_keys(senha)     # Preenche senha
    context.driver.find_element(By.ID, "login-button").click()          # Clica em login

# 1ª variação: Preencher com usuário em branco e senha
@when(u'preencho os campos de login com usuario  e senha {senha}')  # deixair 2 espaços apos usuario " "
def step_impl(context, senha):
    # não preenche o usuário
    context.driver.find_element(By.ID, "password").send_keys(senha)     # Preenche senha
    context.driver.find_element(By.ID, "login-button").click()          # Clica em login

# 2ª Variação: Preencher com usuário, mas deixar senha em branco
@when(u'preencho os campos de login com usuario {usuario} e senha ') # deixar espaço no lugar da {senha}
def step_impl(context, usuario):
    context.driver.find_element(By.ID, "user-name").send_keys(usuario)  # Preencha usuario
    # Não preencho a senha
    context.driver.find_element(By.ID, "login-button").click()          # Clica em login
    
# 3ª Clica no botão de login sem ter preenchido o usuário e a senha
@when(u'preencho os campos de login com usuario  e senha ') # deixar 2 espaço apos usuário e um espaço apos senha
def step_impl(context):
    # Não preencho o usuário
    # Não preencho a senha
    context.driver.find_element(By.ID, "login-button").click()          # Clica em login

# Preencher com usuário e senha através da decisão (IF)
@when(u'digito os campos de login com usuario {usuario} e senha {senha} com IF')
def step_impl(context, usuario, senha):
    if usuario != '<branco>':
        context.driver.find_element(By.ID, "user-name").send_keys(usuario)  # Preencha usuario
        # se o usuário estiver em <branco> não há ação de preenchimento
    if senha != '<branco>':
        context.driver.find_element(By.ID, "password").send_keys(senha)     # Preenche senha
        # se a senha estiver em branco, não há ação de preenchimento
    context.driver.find_element(By.ID, "login-button").click()          # Clica em login
    
    
# Bloco scenario adicionar e remover produto do carrinho
@when(u'sou direcionado para a pagina Home')
def step_impl(context):
    context.driver.find_element(By.CSS_SELECTOR, ".title").text == "Products"
@when(u'adiciono o produto Sauce Labs Backpack ao carrinho')
def step_impl(context):
    context.driver.find_element(By.ID, "add-to-cart-sauce-labs-backpack").click()
@when(u'eu clico no ícone do carrinho')
def step_impl(context):
    context.driver.find_element(By.CSS_SELECTOR, ".shopping_cart_link").click()
@when(u'eu confirmo o produto Sauce Labs Backpack, a quantidade 1 e o preço $ 29.99')
def step_impl(context):
    context.driver.find_element(By.CSS_SELECTOR, ".inventory_item_name").text == "Sauce Labs Backpack"
    context.driver.find_element(By.CSS_SELECTOR, ".cart_quantity").text == "1"
    context.driver.find_element(By.CSS_SELECTOR, ".inventory_item_price").text == "$ 29.99"
@when(u'eu clico em remover o produto do carrinho')
def step_impl(context):
    context.driver.find_element(By.ID, "remove-sauce-labs-backpack").click()   



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

# Encerra bloco do scenario adicionar e remover produto do carrinho
@then(u'efetuo o logout')
def step_impl(context):
    context.driver.find_element(By.ID, "react-burger-menu-btn").click()
    context.driver.find_element(By.ID, "logout_sidebar_link").click()

    #teardown = encerramento
    context.driver.quit()
    
    # Verefica a mensagem para o Scenário Outline
@then(u'exibe a {mensagem} de erro no login')
def step_impl(context, mensagem):
    assert context.driver.find_element(By.CSS_SELECTOR, "h3").text == mensagem
    
    #teardown = encerramento
    context.driver.quit()
    
