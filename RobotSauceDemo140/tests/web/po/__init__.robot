*** Settings ***                    # Serve como arquivo de inicialização para o test DDT (massa)
Resource    ../../../pages/base_page.robot
Suite Setup    Obter Data e hora            # Importante para separar de outros testes. Obtem data e hora antes de abrir o navegador. 
Test Setup    base_page.Abrir navegador                # Aponta para a base.page e busca a função de abrir o navegador.
Test Teardown    base_page.Fechar navegador

