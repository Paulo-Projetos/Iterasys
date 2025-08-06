*** Settings ***
Library    SeleniumLibrary

*** Variables ***                                # Nesse caso as variaveis em "Page Object" são os seletores dos elementos da pagina 
${txt_usuario}      css=[data-test="username"]
${txt_senha}        css=[data-test="password"]
${btn_login}        id=login-button

# Mapeamento da pagina de realisação do Login na API

*** Keywords ***
Preencher usuario
    [Arguments]    ${usuario}                    # Recebe o argumento campo "usuario"
    Input Text    ${txt_usuario}    ${usuario}
Preencher senha
    [Arguments]    ${senha}
    Input Password    ${txt_senha}    ${senha}                # Poderia ser tbm Input Text
Clicar botao Login
    Click Button    ${btn_login}

