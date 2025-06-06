# 1- Bibliotecas - Framework
import json
import pytest
import requests                      # framework de testes API

from utils.utils import ler_csv      # import da funcionalidade do arquivo utils no (CSV)

# 2- Classe (opicional no Python, em muitos casos)

# 2.1- Atributos ou variaveis para utilização no item: POST/pet
pet_id = 184898101          # código do animal
pet_name = "Snoopy"         # nome do animal
pet_category_id = 1         # código da categoria do animal
pet_category_name = "dog"   # titulo da categoria
pet_tag_id = 1              # código do rotulo
pet_tag_name = "vacinado"   # titulo do rotulo
url = 'https://petstore.swagger.io/v2/pet'      # Endereço copiado do POST/pet (Responses), apos executar uma simulação em branco do cadatro de um novo animal.
headers = {'Content-Type': 'application/json'}  # Cabeçalho copiado do POST/pet (Responses), apos executar uma simulação em branco do cadatro de um novo animal.

# 2.2- Funções / Metodo
def test_post_pet():                                # Função realiza o teste automatizado junto ao ptstore swagger
    pet = open('./fixtures/json/pet1.json')         # Abre o arquivo json no script
    data = json.loads(pet.read())                   # lê e carrega os dados do arquivo pet1.json na variavel data
# Executa
    response = requests.post(               # Envia na requisição POST, os dados para cadastramento do pet na API
        url = url,                          # Endereço post/pet no petstore swagger
        headers = headers,                  # Cabeçalho / informações extras da mensagem
        data = json.dumps(data),            # Descarrega os dados da variavel data (mensagem)
        timeout = 5                         # Tempo limite da transmissão, em segundos
    )
# Valida
    response_body = response.json()        # Resposta de retorno da variavel (body) do Swagger, com os atributos de retorno em formado json.
    
    assert response.status_code == 200      # Resposta padrão de que a mensagem de eco ocorreu dentro dos padroes
    assert response_body['id'] == pet_id
    assert response_body['name'] == pet_name
    assert response_body['category']['name'] == pet_category_name
    assert response_body['tags'][0]['name'] == pet_tag_name

# Scipt para o Metodo GET/pet/petID - Pesquisa animal pelo ID
def test_get_pet():                                 # nome usado no ptstore swagger
# Configura: Será utilizados os dados de atributos definidos acima (Ex.: ID)
# Dados de Entrada e Saida / Resultado esperado estão na seção de atributos antes das funções

# Executa   - para o get, não existe body
    response = requests.get(
        url = f'{url}/{pet_id}',            # Endereço, mais o final do endereço get (numero pet_id)
        headers = headers,                  # Cabeçalho / informações extras da mensagem
    )                                       # Não tem corpo da mensagem body (script),
    
# Valida
    response_body = response.json()
    
    assert response.status_code == 200 
    assert response_body['name'] == pet_name
    assert response_body['category']['id'] == pet_category_id          # A escolha dos itens é a seu critério
    assert response_body['tags'][0]['id'] == pet_tag_id
    assert response_body['status'] == 'available'
    
# Script para o item PUT/pet                  # Necessário copiar/preencher novamente o scrip com as alterações desejadas
def test_put_pet():
    pet = open('./fixtures/json/pet2.json')         # Abre o arquivo json2
    data = json.loads(pet.read())
    
    response = requests.put(
        url = url,                          # Endereço iguais para post e put
        headers = headers,
        data = json.dumps(data),           
        timeout = 5
    )
    response_body = response.json()
    
    assert response.status_code == 200                              # Para esse, escolhemos todos os itens de cadastro do animal
    assert response_body['id'] == pet_id
    assert response_body['name'] == pet_name
    assert response_body['category']['id'] == pet_category_id     
    assert response_body['category']['name'] == pet_category_name
    assert response_body['tags'][0]['id'] == pet_tag_id
    assert response_body['tags'][0]['name'] == pet_tag_name
    assert response_body['status'] == 'sold'
    
# Script para item DELETE/pet/petID
def test_delete_pet():                                          # Apos deletado a mensagem de retor é: code, type, message
    
    response = requests.delete(
        url = f'{url}/{pet_id}',                                  # Endereço com o final da url do delite
        headers = headers,  
    )
    response_body = response.json()
    
    assert response.status_code == 200                              # Para esse, os itens de resposta serão (code, type, message)
    assert response_body['code'] == 200
    assert response_body['type'] == 'unknown'
    assert response_body['message'] == str(pet_id)     
    
# Efetuando teste dinamico utilizando um arquivo CSV.
@pytest.mark.parametrize('pet_id,category_id,category_name,pet_name,tags,status',
                        ler_csv('./fixtures/csv/pets.csv'))
def test_post_pet_dinamico(pet_id,category_id,category_name,pet_name,tags,status):
    
    # Configura
    pet = {}                                    # cria uma lista vazia chamada pet
    pet['id'] = int(pet_id)
    pet['category'] = {}                        # item mãe - lista principal contendo IDs e Names
    pet['category']['id'] = int(category_id)    # primeiro filho
    pet['category']['name'] = category_name     # segundo filho
    pet['name'] = pet_name
    pet['photoUrls'] = []                       # Lista contendo a possibilidades de varios fotos
    pet['photoUrls'].append('')                 # lê como campo vazio
    pet['tags'] = []                            # Lista contendo a possibilidades de varios tags
    
    tags = tags.split(';')                      # usado para ler dados conjuntos desse item separados por (;) conformr no arquivo CSV
    for tag in tags:                            # repeti a leitura de dados dentro de uma lista
        tag = tag.split('-')
        tag_formatada = {}
        tag_formatada['id'] = int(tag[0])
        tag_formatada['name'] = tag[1]
        pet['tags'].append(tag_formatada)       # local onde é armazenado os dados, cada vez que é executado um item da lista
    
    pet['status'] = status
    
    pet = json.dumps(obj=pet, indent=4)         #  carrega e adequa a estrutura de linhas e colunas do arquivo json      
    print('\n' + pet)                           # visualiza como ficou a estrutura json criado dinamicamente
    
    #Executa
    response = requests.post(
        url = url,
        headers = headers,
        data = pet,
        timeout = 5
    )
    
    # Compara
    response_body = response.json()
    
    assert response.status_code == 200
    assert response_body['id'] == int(pet_id)
    assert response_body['name']  == pet_name
    assert response_body['status']  == status
    
    
    