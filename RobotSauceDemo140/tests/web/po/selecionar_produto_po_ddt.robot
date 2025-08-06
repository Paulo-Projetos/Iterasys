# Para teste "Page Object", sera utilizado a bliblioteca dos "Resource (do base)", logo não é necessário a biblioteca Library Selenuium;
# Sera utilizado somente o "Resource do Base" pois definimos no arquivo do bese que ele já consta de todos os outros Resouces a serem utilizados no teste.
*** Settings ***
Resource       ../../../pages/base_page.robot            # Chama o arquivo 'base_page.robot' onde estão todos os Resources
Test Template    Selecionar Produto                        # Nova incluisão


*** Test Cases ***                                            # Inclusão do Test Case
TC001    Sauce Labs Backpack                  $29.99            # Mochila
TC002    Sauce Labs Bike Light                $9.99              # Bike
TC003    Sauce Labs Bolt T-Shirt              $15.99             # Camiseta
TC004    Sauce Labs Fleece Jacket             $49.99            # Jaqueta
TC005    Sauce Labs Onesie                    $7.99            # Macacão
TC006    Test.allTheThings() T-Shirt (Red)    $15.99            # Moleton

*** Keywords ***                                            # Substituição do "Test Case"
Selecionar Produto                                            # Substituição para aquisição de vários produtos
    [Arguments]    ${product_name}    ${product_price}
    Tirar Screenshot    1- Home
    Preencher usuario      standard_user
    Preencher senha        secret_sauce
    Tirar Screenshot    2- Login Preenchido                                     # Tira print da pagina de login
    Clicar botao Login                                                                  # login_page
    Element Text Should Be    ${titulo_secao}    Products                              # inventory_page
    Tirar Screenshot    3- Lista de Produtos
    Clicar no Produto    ${product_name}                                        
    Element Text Should Be    ${inventory_item_product_name}    ${product_name}          # Alterado
    Element Text Should Be    ${inventory_item_product_price}    ${product_price}        # Alterado
    Tirar Screenshot    4- Detalhes do produto
    Clicar no botao "Add to cart"
    Clicar no carrinho                                                                  #cart_page
    Element Text Should Be    ${titulo_secao}             Your Cart
    Element Text Should Be    ${cart_product_name}        ${product_name}                # Alterado
    Element Text Should Be    ${cart_product_price}        ${product_price}               # Alterado
    Element Text Should Be    ${cart_product_quantity}    1
    Tirar Screenshot    5- Carrinho
    Realizar Logout
