*** Settings ***
Library    SeleniumLibrary
Library    DateTime                    # Serve para buscar horario de regsitro do computador
Library    OperatingSystem
Resource    cart_page.robot
Resource    inventory_item_page.robot
Resource    inventory_page.robot
Resource    login_page.robot

*** Variables ***
${timeout}    10000ms
${url}        https://www.saucedemo.com/
${browser}    Edge     #Chrome
${date}                                        # Varialvel recebe os dados do ketword "Obtar Data e hora" sempre que rodar o teste.

# Mapeamento dos itens incomuns nas paginas basicas de transições da API (Nesse caso foram feitas somente duas algumas amostragens)

*** Keywords ***
Abrir navegador                                                    # 1ª Ação
    Register Keyword To Run On Failure    Tirar Screenshot                # Tira um print da falha, para mostrar que o navegador deu erro, caso isso venha a acontecer
    Open Browser    url=${url}    browser=${browser}
    Maximize Browser Window
    Set Browser Implicit Wait    10000ms                                  # Aguarda 10 segundos para carregar o navegador 
    Wait Until Element Is Visible    css=.login_logo    ${timeout}        # Espera pela apresentação da pagina principal com o logo (Swag Labs)
Fechar navegador                                                   # 2ª Ação
    Sleep    500ms                                                         # Pausa antes de fechar o browser
    Close Browser
Clicar no carrinho                                                 # Ação comum a todas as paginas
    Click Element    css=[data-test="shopping-cart-link"]
    Wait Until Element Contains    css=[data-test="title"]    Your Cart    ${timeout}    # Transição de pagina com tempo limiti de espera para apresentação do titulo "Your Card"
Realizar Logout                                                    # Ação Comum a todas as paginas (poderia-se testas todas as 6 funções no logout)
    Click Element    id=react-burger-menu-btn                              # poderia ser um "Click Button"
    Click Element    id=logout_sidebar_link                                # poderia ser um "Click Link"
    Wait Until Element Is Visible    css=.login_logo    ${timeout}
Obter Data e hora
    ${date} =    Get Current Date                                                        # Lê e armazena a data e hora calendario do computador
    ${date} =     Convert Date    ${date}    result_format=%Y.%m.%d_%H.%M.%S                # Converte em formatação de ano/mês/dia e hora/min/seg
    ${date}    Set Global Variable    ${date}                                        # Necessário para uso em dois scripts - Torna a variavel usual durante todo o tempo de teste
Tirar Screenshot                                                                  # Tira fotos de cada final de teste por transição de pagina
    [Arguments]    ${screenshot_name}
    Create Directory    C:/Iterasys/RobotSauceDemo140/screenshots                    # Foi necessário definir diretorio para que os sprints sejam salvos na pasta screenshots, pois sem esse comando eles estavam sendo salvos na pasta raiz c;Iterasys.
    Capture Page Screenshot    C:/Iterasys/RobotSauceDemo140/screenshots/${date}/${TEST_NAME}/${screenshot_name}.jpg       # Print definido pelo nome e data do teste - ${TEST-NAME} é uma variavel pronta já definida pelo Python.

#Tirar Screenshot        # Script oroginal feito pelo professor
    #Capture Page Screenshot    screenshots/${date}/${TEST_NAME}/${screenshot_name}.jpg
    