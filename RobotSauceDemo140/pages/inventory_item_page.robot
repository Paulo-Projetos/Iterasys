*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${inventory_item_product_name}        css=div.inventory_details_name.large_size                # Seletor nome do produto (Sauce Labs Backpack)
${inventory_item_product_price}       css=div.inventory_details_price                          # Seletor preço do produto
${btn_add_to_cart}                    css=button.btn.btn_primary.btn_small.btn_inventory       # Seletor adiciona produto ao carrinho

# Mateamento da pagina especifica do produto (inventory item = Sauce Labs Backpack) - existem 5 itens a serem mapeados, aqui foi feito somente 1 amostras. 

*** Keywords ***
Clicar no botao "Add to cart"
    Click Button    ${btn_add_to_cart}

