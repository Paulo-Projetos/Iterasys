*** Settings ***                    # Trabalhando o script com massa de testes (DataDriver)
Library    RequestsLibrary
Library    DataDriver    ../../fixtures/csv/bookings.csv    dialect=excel        # Biblioteca exclusiva para leitura de arquivos CSV (Excel).
Library    OperatingSystem                    # Foi criado automaticamente pelo sistema.
Resource    ../../resources/common.resource
Variables    ../../resources/variables.py
Test Setup    Create Token    ${url}            # Define comando a ser executado automaticamente antes de cada caso de teste.
Test Template    Create Booking DDT             # Define que os testes desse arquivo vão usar o formato de teste baseado em dados (Data-Driven Test)

*** Test Cases ***                
TC001    ${firstname}    ${lastname}    ${totalprice}    ${depositpaid}    ${checkin}    ${checkout}    ${additionalneeds}    # Teste Case 01 (TC01)

*** Keywords ***
Create Booking DDT                # Criação de reserva a partir de uma massa de dados (data-Drive), de um arquivo CSV (Excel).
    [Arguments]    ${firstname}    ${lastname}    ${totalprice}    ${depositpaid}    ${checkin}    ${checkout}    ${additionalneeds}
    ${headers}    Create Dictionary    Content-Type=${content_type}
    ${totalprice}    Convert To Integer    ${totalprice}            # Converte para inteiro unidades a serem utilizadas no teste.
    ${depositpaid}    Convert To Boolean    ${depositpaid}          # Converte intem boleano (true / false) em unidades a serem utilizadas no teste.
    &{bookingdates}    Create Dictionary    checkin=${checkin}    checkout=${checkout}    # recebe lista de dados
    
    ${body}    Create Dictionary    firstname=${firstname}    lastname=${lastname}    totalprice=${totalprice}    depositpaid=${depositpaid}    bookingdates=${bookingdates}    additionalneeds=${additionalneeds}
    
    ${response}    POST    url=${url}/booking    headers=${headers}    json=${body}
    
    ${response_body}    Set variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[booking][firstname]                    ${firstname}
    Should Be Equal    ${response_body}[booking][lastname]                     ${lastname}
    Should Be Equal    ${response_body}[booking][totalprice]                   ${totalprice}
    Should Be Equal    ${response_body}[booking][depositpaid]                  ${depositpaid}
    Should Be Equal    ${response_body}[booking][bookingdates][checkin]        ${checkin}
    Should Be Equal    ${response_body}[booking][bookingdates][checkout]       ${checkout}
    Should Be Equal    ${response_body}[booking][additionalneeds]              ${additionalneeds}
