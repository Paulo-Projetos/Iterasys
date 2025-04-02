Feature: Giuliana Flores Scripts
     
    Scenario: Criar usuário
        Given que acesso o site giulianaflores.com.br
        When preencho os campos de cadastro com nome Kaique Otávio Pedro Freitas cpf 832.536.678-80 email kaique-freitas88@wnetrj.com.br e senha FS2b2CoHcR
        And preencho os campos de meu endereço com cep 13050-031 numero 499 e celular 19989062569
        And eu clico em não sou robô
        Then eu clico em finalizar cadastro
    
    Scenario: Login1 Positivo
        Given que acesso o site giulianaflores.com.br
        When clico no icone perfil
        And clico em login/cadastrar
        And preencho os campos de login com email kaique-freitas88@wnetrj.com.br e senha FS2b2CoHcR
        Then eu clico em continuar
    
    Scenario: Login2 Negativo
        Given que acesso o site giulianaflores.com.br
        When clico no icone perfil
        And clico em login/cadastrar
        And preencho os campos de login com email kaique-freitas88@wnetrj.com.br e senha FS2b2CoH
        And eu clico em continuar
        Then exibe mensagem de erro
    
    Scenario: Fluxo de Compra
        Given que acesso o site giulianaflores.com.br
        When clico no icone perfil
        And clico em login/cadastrar
        And preencho os campos de login com email kaique-freitas88@wnetrj.com.br e senha FS2b2CoHcR
        And eu clico em continuar
        And eu clico em presentes
        And eu prencho cep 13050-031, clico em endereço e clico em Aplicar
        And eu preencho campo de procura com Bolos e clico na lupa
        And clico no item Bolo Parabens a Você
        And clico em Adicionar ao Carrinho
        Then clico em ok para previsão de entrega
    



