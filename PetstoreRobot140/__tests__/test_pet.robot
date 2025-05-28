*** Settings ***
Library    RequestsLibrary

*** Variables ***
${url}    https://petstore.swagger.io/v2/pet

${id}    184409098                            # $ sinalisa uma variavel simples
${name}    Snoopy
&{category}    id=1    name=cachorro          # & = lista com campos determinados. ex.: Id e Name
@{photoUrls}                                  # @ sinaliza um alista com varios registros - seria []
&{tag}    id=1    name=vacinado
@{tags}    ${tag}                             # fez uma lista de outra lista
${status}    available

*** Test Cases ***
Post pet
    # Montar a mensagem / body
    ${body}    Create Dictionary    id=${id}    category=${category}    name=${name}    photoUrls=${photoUrls}    tags=${tags}    status=${status}
    #Executar
    ${response}    POST    url=${url}    json=${body}

    #Validar
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}                # Imprimir o retorno da API no terminal / console

    Status Should Be    200
    Should Be Equal    ${response_body}[id]                  ${{int($id)}}
    Should Be Equal    ${response_body}[name]                ${name}
    Should Be Equal    ${response_body}[tags][0][id]         ${{int(${tag}[id])}}
    Should Be Equal    ${response_body}[tags][0][name]       ${tag}[name]
    Should Be Equal    ${response_body}[status]              ${status}


*** Keywords ***

