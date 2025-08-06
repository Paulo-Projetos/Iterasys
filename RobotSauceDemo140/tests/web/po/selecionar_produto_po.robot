# Para teste "Page Object", sera utilizado a bliblioteca dos "Resource (do base)", logo não é necessário a biblioteca Library Selenuium;
# Sera utilizado somente o "Resource do Base" pois definimos no arquivo do bese que ele já consta de todos os outros Resouces a serem utilizados no teste.
*** Settings ***
Resource       ../../../pages/base_page.robot            # Chama o arquivo 'base_page.robot' onde estão todos os Resources

*** Test Cases ***
Selecionar Mochila
    Tirar Screenshot    1- Home
    Preencher usuario      standard_user
    Preencher senha        secret_sauce
    Tirar Screenshot    2- Login Preenchido                                     # Tira print da pagina de login
    Clicar botao Login                                                                  # login_page
    Element Text Should Be    ${titulo_secao}    Products                              # inventory_page
    Tirar Screenshot    3- Lista de Produtos
    Clicar no Produto    Sauce Labs Backpack                                            # inventory_item
    Element Text Should Be    ${inventory_item_product_name}    Sauce Labs Backpack
    Element Text Should Be    ${inventory_item_product_price}    $29.99
    Tirar Screenshot    4- Detalhes do produto
    Clicar no botao "Add to cart"
    Clicar no carrinho                                                                  #cart_page
    Element Text Should Be    ${titulo_secao}             Your Cart
    Element Text Should Be    ${cart_product_name}        Sauce Labs Backpack
    Element Text Should Be    ${cart_product_price}        $29.99
    Element Text Should Be    ${cart_product_quantity}    1
    Tirar Screenshot    5- Carrinho
    Realizar Logout
