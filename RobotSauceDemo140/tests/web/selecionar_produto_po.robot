# Para teste "Page Object", sera utilizado a bliblioteca dos "Resource", logo não é necessário a biblioteca Library Selenuium;
# Sera utilizado somente o "Resource do Base" pois definimos no arquivo do bese que ele já consta de todos os outros Resouces a serem utilizados no teste.
*** Settings ***
Resource       ../../pages/base_page.robot            # Chama o arquivo 'base_page.robot'
Test Setup        base_page.Abrir navegador
Test Teardown     base_page.Fechar navegador

*** Test Cases ***
Selecionar Mochila
    Preencher usuario      standard_user
    Preencher senha        secret_sauce
    Clicar botao Login
    Element Text Should Be    ${titulo_secao}    Productos
    Clicar no Produto    Sauce Labs Backpack
    Element Text Should Be    ${inventory_item_product_name}    Sauce Labs Backpack
    Element Text Should Be    ${inventory_item_product_price}    $29.99
    Clicar no botao "Add do Cart"
    Clicar no carrinho
    Element Text Should Be    ${titulo_secao}             Your Cart
    Element Text Should Be    ${cart_product_name}        Sauce Labs Backpack
    Element Text Should Be    ${cart_roduct_price}        $29.99
    Element Text Should Be    ${cart_product_quantity}    1
    Realizar Logout
