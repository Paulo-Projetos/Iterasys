# 1- Bibliotecas - Framework
import json
import pytest
import requests

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
def test_post_pet():                                # nome usado no ptstore swagger
    pet = open('./fixtures/json/pet1.json')         # Abre o arquivo json
    data = json.loads(pet.read())                   # lê e carrega os dados do arquivo pet1.json na variavel data
# Executa
    response = requests.post(               # Executa o metodo post com as informações a seguir
        url = url,                          # Endereço post/pet no petstore swagger
        headers = headers,                  # Cabeçalho / informações extras da mensagem
        data = json.dumps(data),            # Descarrega os dados da variavel data (mensagem)
        timeout = 5                         # Tempo limite da transmissão, em segundos
    )
# Valida
    response_body = response.json()        # Cria uma variavel e carrega a resposta (eco) em formado json
    
    assert response.status_code == 200      # Resposta padrão de que a mensagem de eco ocorreu dentro dos padroes
    assert response_body['id'] == pet_id
    assert response_body['name'] == pet_name
    assert response_body['category']['name'] == pet_category_name
    assert response_body['tags'][0]['name'] == pet_tag_name

# Scipt para o Metodo GET/pet
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
    
# Script para item DELETE/pet
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
    
    
    