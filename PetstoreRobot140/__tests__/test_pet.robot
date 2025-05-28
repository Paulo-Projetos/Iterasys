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

Get pet
    ${response}    GET    ${{$url + '/' + $Id}}
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]                  ${{int($id)}}
    Should Be Equal    ${response_body}[name]                ${name}
    Should Be Equal    ${response_body}[category][id]        ${{int(${category}[id])}}
    Should Be Equal    ${response_body}[category][name]      ${category}[name]

Put pet        # nesse item utilizamos como dados um arquivo pet2.json
    ${body}    Evaluate    json.loads(open('./PetstoreRobot140/fixtures/json/pet2.json').read())
    ${response}    PUT    url=${url}    json=${body}
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[id]                  ${{int($id)}}
    Should Be Equal    ${response_body}[category][id]        ${{int(${category}[id])}}
    Should Be Equal    ${response_body}[category][name]      ${category}[name]
    Should Be Equal    ${response_body}[name]                ${name}
    Should Be Equal    ${response_body}[tags][0][id]         ${{int(${tag}[id])}}
    Should Be Equal    ${response_body}[tags][0][name]       ${tag}[name]
    Should Be Equal    ${response_body}[status]              sold

Delete pet
    ${response}    DELETE    ${{$url + '/' + $id}}
    ${response_body}    Set Variable    ${response.json()}
    Log To Console    ${response_body}

    Status Should Be    200
    Should Be Equal    ${response_body}[code]    ${{int(200)}}
    Should Be Equal    ${response_body}[type]    unknown
    Should Be Equal    ${response_body}[message]    ${id}


*** Keywords ***
