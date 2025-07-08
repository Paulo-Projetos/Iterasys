*** Settings ***
Library    SeleniumLibrary
Library    DateTime                    # Serve para buscar horario de regsitro do computador
Resource    cart_page.robot
Resource    inventory_item_page.robot
Resource    inventory_page.robot
Resource    login_page.robot

*** Variables ***
${timeout}    10000ms
${url}        https://www.saucedemo.com/
${browser}    Chrome 
${date}

# Mapeamento dos itens comuns nas paginas basicas nas transições da API

*** Keywords ***
Abrir navegador
    Register Keyword To Run On Failure    Tirar Screenshot            # Tira um print da falha, para mostrar que o navegador deu erro, caso isso venha a acontecer
    Open Browser    url=${url}    browser=${browser}
    Set Browser Implicit Wait    10000ms                              # Aguarda 10 segundos para carregar o navegador 
    Wait Until Element Is Visible    css=.login_logo    ${timeout}    # Espera pela apresentação da pagina principal com o logo (Swag Labs)
Fechar navegador
    Sleep    500ms                                                    # Pausa antes de fechar o browser
    Close Browser
Clicar no carrinho
    Click Element    css=[data-test="shopping-cart-link"]
    Wait Until Element Contains    css=[data-test="title"]    Your cart    ${timeout}
Realizar Logout
    Click Element    id=react-burger-menu-btn
    Click Element    id=logout_sidebar_link
    Wait Until Element Is Enabled    css=.login_logo    ${timeout}
Obter Data e hora
    ${date} =    Get Current Date                                                        # Lê e armazena a data e hora calendario do computador
    ${date} =     Convert Date    {date}    result_format=%Y.%m.%d_%H.%M.%S                # Converte em formatação de ano/mês/dia e hora/min/seg
    Capture Page Screenshot    screenshots/${TEST_NAME}/${date}.jpg  
Tirar Screenshot
    ${date} =    Get Current Date                                                        # Lê e armazena a data e hora calendario do computador
    ${date} =     Convert Date    {date}    result_format=%Y.%m.%d_%H.%M.%S                # Converte em formatação de ano/mês/dia e hora/min/seg
    Capture Page Screenshot    screenshots/${TEST_NAME}/${date}.jpg                        # Print definido pelo nome e data do teste.                                                          # Criar caminho / nomear arquivo


    # 1- screenshots / <system_name> / <test_name> / <date>.jpg
    # 2- screenshots / <system_name> / <date> / <test_name>.jpg