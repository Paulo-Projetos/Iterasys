*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${titulo_secao}    css=.title                    # Teoricamente para essa seção essa variavel não sera usada, porem cabe ser mapeado para ser utilizado no "test Case"

# Mapeamento da pagina interna de inventario (produtos) - Obs.: Nessa pagina teria 4 testes referente ao item filtros, entre outros!

*** Keywords ***
Clicar no Produto
    [Arguments]    ${product_name}
    Click Element    css=img[alt="${product_name}"]        # Clica na imagem do produto

