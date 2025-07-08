*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${titulo_secao}    css=.title

# Mapeamento da pagina interna de inventario (produtos)

*** Keywords ***
Clicar no Produto
    [Arguments]    ${product_name}
    Click Element    css=img[alt="${product_name}"]

