# *** Variables ***            ----> resource/variables.py
# *** Settings ***             ----> resources/common.resource
# *** Test Cases ***           ----> Continuam no arquivo .robot
# *** Keywords ***             ----> resources/common.resource

# Casos de Teste

*** Settings ***
Library    RequestsLibrary
Resource    ../../resources/common.resource  # Endereço de onde esta armazenado o arquivo common.resource a ser utilizado na execução do teste.
Variables    ../../resources/variables.py
Suite Setup    Create Token    ${url}        # Define comando a ser executado automaticamente antes de cada caso de teste.

*** Test Cases ***
Create Booking            # Função para criar uma Reserva através de uma massa de dados dinamica, de um arquivo Json.
    ${headers}    Create Dictionary    Content-Type=${content_type}    # Dicionário que define cabeçalho a ser chamado na requisição.
    ${body}    Evaluate    json.loads(open('./RobotBooker140/fixtures/json/booking1.json').read())

    ${response}    POST    url=${url}/booking    json=${body}    headers=${headers}
    
    ${response_body}    Set Variable    ${response.json()}        # Variavel extrai e armazena resposta no formato Json.
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[booking][firstname]                   ${firstname}        # Estrutura (pai, filho,..) definida do body de resposta do site na função Create Booking.
    Should Be Equal    ${response_body}[booking][lastname]                    ${lastname}
    Should Be Equal    ${response_body}[booking][totalprice]                  ${totalprice}
    Should Be Equal    ${response_body}[booking][depositpaid]                 ${depositpaid}
    Should Be Equal    ${response_body}[booking][bookingdates][checkin]       ${bookingdates}[checkin]
    Should Be Equal    ${response_body}[booking][bookingdates][checkout]      ${bookingdates}[checkout]
    Should Be Equal    ${response_body}[booking][additionalneeds]             ${additionalneeds}

Get Booking            # Consulta da reserva através de um ID
    Get Booking Id    ${url}    ${firstname}    ${lastname}       # Os registros já existem no common.resource e variables.py
    
    ${response}    GET    url=${url}/booking/${booking_id}        # Consulta e armazena registro da reserva especifica na variavel response.

    ${response_body}    Set Variable    ${response.json()}        # Extrai os dados da variavel response em Json e armazena na variavel response_body.
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[firstname]                   ${firstname}
    Should Be Equal    ${response_body}[lastname]                    ${lastname}
    Should Be Equal    ${response_body}[totalprice]                  ${totalprice}
    Should Be Equal    ${response_body}[depositpaid]                 ${depositpaid}
    Should Be Equal    ${response_body}[bookingdates][checkin]       ${bookingdates}[checkin]
    Should Be Equal    ${response_body}[bookingdates][checkout]      ${bookingdates}[checkout]
    Should Be Equal    ${response_body}[additionalneeds]             ${additionalneeds}

Update Booking                        # Função (PUT) utilizado para alteração e atualização de dados em uma reserva. Fluxo: Executar o Token e fazer pesquisa do registro com ID (Bookingid), para então executar o PUT.
    Get Booking Id    ${url}    ${firstname}    ${lastname}    # Executa um GET para localizar o registro e extrai 0 ID de localização.
    ${headers}    Create Dictionary    Content-Type=${content_type}    Cookie=token=${Token}    # Conforme descrito na documentação e por segurança, é necessário o comando Cookie para fazer executar o token antes do PUT.

    ${body}    Create Dictionary    firstname=${firstname}    lastname=${lastname}    totalprice=90    depositpaid=True    bookingdates=${bookingdates}    additionalneeds=${additionalneeds}    # Introdução de damos manual.

    ${response}    PUT    url=${url}/booking/${booking_id}    json=${body}    headers=${headers}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[firstname]                   ${firstname}
    Should Be Equal    ${response_body}[lastname]                    ${lastname}
    Should Be Equal    ${response_body}[totalprice]                  ${{int(90)}}
    Should Be Equal    ${response_body}[depositpaid]                 ${{bool(True)}}
    Should Be Equal    ${response_body}[bookingdates][checkin]       ${bookingdates}[checkin]
    Should Be Equal    ${response_body}[bookingdates][checkout]      ${bookingdates}[checkout]
    Should Be Equal    ${response_body}[additionalneeds]             ${additionalneeds}

Partial Update Booking                    #Função (PATCH) utilizado para alteração ou atualização de um ou mais itens predefinidos em uma reserva.
    Get Booking Id    ${url}    ${firstname}    ${lastname}
    ${headers}    Create Dictionary    Cookie=token=${Token}    Content-Type=${content_type}

    ${body}    Create Dictionary    additionalneeds=Dinner        # Substituição do café da manha pelo jantar.

    ${response}    PATCH    url=${url}/booking/${booking_id}    headers=${headers}    json=${body}

    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[firstname]                   ${firstname}
    Should Be Equal    ${response_body}[lastname]                    ${lastname}
    Should Be Equal    ${response_body}[totalprice]                  ${{int(90)}}               # Adimitimos que essa mudança anterior sera mantida para esse exemplo
    Should Be Equal    ${response_body}[depositpaid]                 ${{bool(True)}}            # Adimitimos que essa mudança anterior sera mantida para esse exemplo
    Should Be Equal    ${response_body}[bookingdates][checkin]       ${bookingdates}[checkin]
    Should Be Equal    ${response_body}[bookingdates][checkout]      ${bookingdates}[checkout]
    Should Be Equal    ${response_body}[additionalneeds]             Dinner                     # Nova atualização pontual.   

Delete Booking
    Get Booking Id    ${url}    ${firstname}    ${lastname}
    ${headers}    Create Dictionary    Cookie=token=${Token}    Content-Type=${content_type} 

    ${response}    DELETE    url=${url}/booking/${booking_id}    headers=${headers}

    Status Should Be    201                                            # Pare esse caso, na documentação esta definido o código 201 para confirmar a exclusão do registro.

