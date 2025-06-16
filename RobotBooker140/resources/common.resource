# Settings e Keywords
*** Settings ***
Library    RequestsLibrary

*** Keywords ***
Create Token                # Esse titulo poderia estar em portugues também. Ela é so um titulo.
    [Arguments]    ${url}
    
    ${body}    Create Dictionary    username=admin    password=password123
    ${response}    POST    url=${url}/auth    json=${body}

    Status Should Be    200
    ${Token}    Set Variable    ${response.json()}[token]
    Set Suite Variable    ${Token}                            # Comando permite que a variavel sigilosa, possa ser utilizada por outros scripts somente durante a execução do teste.
    Log To Console    ${Token}                                # Escreve o token no console.

    