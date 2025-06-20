# Settings e Keywords utilizadas nesse arquivo para definir uma função (Create Token).
*** Settings ***
Library    RequestsLibrary

*** Keywords ***
Create Token                # Esse titulo poderia estar em portugues (Criar Token). Lembrando que neste caso é necessário 1º criar o tokem a ser utilizado no site.
    [Arguments]    ${url}    # Permite passar a URL da API quando a palavra-chave 'Create Token' for chamada.
    
    ${body}    Create Dictionary    username=admin    password=password123    # Monta os dados em formato Json que serão emviados na requisição.
    ${response}    POST    url=${url}/auth    json=${body}    # Envia requisição POST p/ a API que retorna com o token de autenticação.

    Status Should Be    200
    ${Token}    Set Variable    ${response.json()}[token]    # Extrai o token do Json de resposta e armazena na variavel Token.
    Set Suite Variable    ${Token}                           # Torna a variavel Token visivel a todas as suítes de testes, permitindo ser usuado nos testes enquando o teste estiver sendo executado.
    Log To Console    ${Token}                               # Escreve o token no console.

Get Booking Id                                                # Serve para extrair o ID existente, a partir do nome e sobrenome da reserva, a serem utilizados na execução do teste.
    [Arguments]    ${url}    ${firstname}    ${lastname}      # Poderia incluir também ${checkin} e ${checkout} para melhorar o filtro de busca.
    
    ${response}    GET    url=${url}/booking?firstname=${firstname}&lastname=${lastname}    # Efetua uma requisição GET para a API /booking, com os filtros por nome e sobrenome.

    ${response_body}    Set Variable    ${response.json()}    # Converte a resposta da APi de Json para um objeto interno (lista), e salva na variavel response_body.
    Log To Console    ${response_body}

    Status Should Be    200

    ${booking_id}    Set Variable    ${response_body}[0][bookingid]    # Extrai o primeiro bookingid da lista de resultados e armazena na variavel booking_id.
    Set Suite Variable    ${booking_id}                                # Torna o booking_id acessivel em toda a suíte de testes.
