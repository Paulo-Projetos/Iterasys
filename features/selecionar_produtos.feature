Feature: selecionar Produto

    Scenario: Selecionar produto "Sauce Labs Backpack"
        Given que acesso o site Sauce Demo
        When preencho os campos de login com usuario standard_user e senha secret_sauce
        Then sou direcionado para a pagina Home
        
     Scenario: Login com a senha invalida
        Given que acesso o site Sauce Demo
        When preencho os campos de login com usuario standard_user e senha laranja
        Then exibe a mensagem de erro no login

    Scenario: Login Negativo
        Given que acesso o site Sauce Demo
        When preencho os campos de login com usuario <usuario> e senha <senha>
        Then exibe a <mensagem> de erro no login

        Examples:
        | id | usuario          | senha         | mensagens                                                                 |
        | 01 | standard_user    | laranja       | Epic sadface: Username and password do not match any user in this service |
        | 02 | standard_user    |               | Epic Sad Face: Password Required
        | 03 |                  | secret_sauce  | Epic Sad Face: Username is required
        | 04 | juca             | secret_sauc   | Epic sadface: Username and password do not match any user in this service |
        | 05 | juca             | laranja       | Epic sadface: Username and password do not match any user in this service |
        | 06 | juca             |               | Epic Sad Face: Password Required                                          |
        | 07 |                  |               | Epic Sad Face: Username is required                                       |
        | 08 |                  | laranja       | Epic Sad Face: Username is required                                       |







