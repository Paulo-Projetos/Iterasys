*** Settings ***
Library    SeleniumLibrary                # Utilização da biblioteca Selenium
Test Teardown    Close Browser            # No final, fecha o navegador

*** Variables ***
${ur}    https://www.saucedemo.com/
${browser}    Chrome                    # navegador a ser usado
${timeout}    5000ms                    # Variavel que aplica tempo de espera automaticamente nas mudanças de paginas e ouros.

*** Test Cases ***
Selecionar Sauce Labs Backpack            # 1 forma de Seleciona produto mochila no site SauceDemo Usando CLICK LOGIN.
    Dado que acesso o site SauceDemo
    Quando preencho o campo usuario    standard_user
    E preencho o campo senha           secret_sauce
    E clico no botao Login
    Entao sou direcionado para a pagina de produtos
    Quando clico no produto    Sauce Labs Backpack    $29.99
    Então sou direcionado para a pagina do produto
    Quando clico em adicionar no carrinho
    Entao visualizo o numero de itens no carrinho    1
    Quando clico no icone do carrinho
    Entao sou direcionado para a pagina do carrinho
    Quando clico no menu burguer
    E clico em logout
    Entao sou direcionado para a pagina de login

Selecionar Sauce Labs Backpack Login com Enter    # 2 forma de acesso ao site SauceDemo usando ENTER
    Dado que acesso o site SauceDemo
    Quando preencho o campo usuario    standar_user
    E preencho o campo senha           laranja        # Para que esse teste fique só como exemplo e não prossiga, incluiremos a senha invalida (laranja).
    E pressiono a tecla Enter

*** Keywords ***
Dado que acesso o site SauceDemo
    Open Browser    url=${ur}    browser=${browser}
    Maximize Browser Window                                    # Maximiza a pagina inicial (janela)
    Set Browser Implicit Wait    10000ms                       # Tempo de 10 segundos para executar o acesso a pagina (sincronismo)
    Wait Until Element Is Visible    css=.login_logo    ${timeout}    # Espera até o elemento estar visivel, nesse caso a pagina principal (Swag Labs), através do endereço CSS da localisação do titulo no site SauceDemo.
Quando preencho o campo usuario
    [Arguments]    ${username}
    Input Text    css=[data-test="username"]    ${username}
E preencho o campo senha
    [Arguments]    ${password}
    Input Password    css=[data-test="password"]    ${password}    # Daria para usar também o comando "Input Text"
E clico no botao Login
    Click Button    id=login-button                                # Apos preenchido senha e usuário, clica no botão login
E pressiono a tecla Enter                                          # 2 forma de dar enter após preenchimento do usuario e senha.
    Press Key    css=[data-test="password"]    Enter
Entao sou direcionado para a pagina de produtos
    Wait Until Element Is Visible    css=.title    ${timeout}
    Element Text Should Be    css=.title    Products      # Verifica se esta na pagina "Products". Tbm seria possivel usar o localizador "css=.title"
Quando clico no produto                                                 # Palavra-chave
    [Arguments]    ${product_name}    ${product_price}                  # Define que a palavra-chave espera pelos argumentos "preço" e "produto"
    Set Test Variable    ${test_product_name}    ${product_name}        # Cria variavel de teste global (publica), que recebe o valor da variavel local, dessa forma permite que os dados possam ser utilisados em outros momentos dos testes.
    Set Test Variable    ${test_product_price}    ${product_price}
    Click Element    css=img[alt="${test_product_name}"]                # Comando que simula o click em um elemento (imagem), localisado por um seletro CSS. Poderiamos utilizar o CSS como esta na linha de programação, más utilizando uma variavel global, podemos depois somente mudar o nome do produto que desejamos testar que automaticamente o teste buscara os dados de preço, nome, etc. 
Então sou direcionado para a pagina do produto                            # Esse bloco serve para verificar se estou na pagina especifica do produt (Mochila)
    Wait Until Element Is Visible    name=back-to-products    ${timeout}    
    Element Text Should Be   name=back-to-products    Back to products                            # Pagina do produto
    Element Text Should Be   css=div.inventory_details_name.large_size   ${test_product_name}     # Confiema nome
    Element Text Should Be   css=div.inventory_details_price             ${test_product_price}    # Confirma preço 
Quando clico em adicionar no carrinho
    Click Element    css=button.btn.btn_primary.btn_small.btn_inventory
Entao visualizo o numero de itens no carrinho
    [Arguments]    ${cart_items}
    Set Test Variable    ${test_cart_items}    ${cart_items}
    Wait Until Element Is Visible    css=span.shopping_cart_badge                # Tempo para tornar visivel o item
    Element Text Should Be    css=span.shopping_cart_badge    ${test_cart_items}
Quando clico no icone do carrinho
    Click Link    ${test_cart_items}
Entao sou direcionado para a pagina do carrinho
    Wait Until Element Contains    css=.title    Your Cart                        # Tempo de espera até que o determinado elemento da pagina contenha o texto especifico "Your Cart" 
    Element Text Should Be    css=div.inventory_item_name     ${test_product_name}
    Element Text Should Be    css=div.inventory_item_price    ${test_product_price}
    Element Text Should Be    css=div.cart_quantity           ${test_cart_items}
Quando clico no menu burguer
    Click Element    id=react-burger-menu-btn
E clico em logout
    Click Element    link=Logout                                    # Onde tem a palavra 'logout' no script, entende-se que a sua localização ocorre atraves do seu 'link'
Entao sou direcionado para a pagina de login
    Wait Until Element Is Visible    css=input.submit-button.btn_action    5000ms


