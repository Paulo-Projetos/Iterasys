import csv  # biblioteca

def ler_csv(arquivo_csv):
    dados_csv = []                                      # Cria uma lista em branco
    try:                                                # tentar / tratamento de erro
        with open(arquivo_csv, newline='') as massa:    # newline - indica final de linha
            tabela = csv.reader(massa, delimiter=',') # com os dados do arquivo, menos o cabeçalho / com separador por virgula
            next(tabela)                                # Pula linha de cabeçalho (num1, num2, ...)
            for linha in tabela:                        # Para cada linha na tabela
                dados_csv.append(linha)                 # guardando os dados separados  para uso
        return dados_csv                                # Devolve os dados para uso no teste
    except FileNotFoundError:                           # Trata o erro para arquivo não encontrado
        print(f'Arquivo não encontrado: {arquivo_csv}') # Mensagem de arquivo não encontrado
    except Exception as fail:                           # Para erros não previstos
        print(f'Falha imprevista: {fail}')              # Mensagem de erro que voltara do sistema
        
