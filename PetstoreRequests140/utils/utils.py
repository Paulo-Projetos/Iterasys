import csv  # biblioteca

def ler_csv(arquivo_csv):
    dados_csv = []                                      # Cria uma lista em branco
    try:                                                # tentar / tratamento de erro
        with open(arquivo_csv, newline='') as massa:    # tenta abrir arquivo csv e newline indica o final de linha
            tabela = csv.reader(massa, delimiter=',')   # tabela recebe e lê massa do arquivo csv, com separação por virgula
            next(tabela)                                # Pula linha de cabeçalho (num1, num2, ...)
            for linha in tabela:                        # Lê cada linha da tabela
                dados_csv.append(linha)                 # guarda os dados de cada linha para uso
        return dados_csv                                # Devolve os dados para uso no teste
    except FileNotFoundError:                           # Trata o erro para arquivo não encontrado
        print(f'Arquivo não encontrado: {arquivo_csv}') # Mensagem de arquivo não encontrado
    except Exception as fail:                           # Para erros não previstos
        print(f'Falha imprevista: {fail}')              #  mensagem de erro que voltará do sistema
    return []

