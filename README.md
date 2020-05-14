# README

### Executando o projeto:

Construa a imagem dos containers
```
$ docker-compose build
```

Execute o container que executa o **redis** na porta **6380**
```
$ docker-compose up -d
```

### Instruções:
Nesse desafio o programa executa utilizando o redis como banco de dados na porta 6380.

No outro desafio(accounting_challenge) já foi utilizado Rails e Mysql e como não faz sentido utilizar o rails inteiro so para fazer um script optei por utilizar o redis para me auxiliar.

Executando o programa:
```
ruby csv_importer.rb ./arquivo_de_contas.csv ./arquivo_de_transações.csv
```

Executando o programa com meu arquivo de contas
```
ruby csv_importer.rb ./accounts.csv ./transaction.csv
```

Executando testes
```
ruby test_runner.rb
```

Exemplo de saída
```
Instanciando redis..

Abrindo arquivos csv..

Fazendo o parse dos arquivos csv..

Criando contas..

Criando transações..

Resultado das transações:

Id da conta: 1
Saldo final: R$ 1600.00

Id da conta: 2
Saldo final: R$ -7.00

Id da conta: 3
Saldo final: R$ -25.80

Id da conta: 6
Saldo final: R$ 90264.20

Id da conta: 8
Saldo final: R$ 0.00

Id da conta: 9
Saldo final: R$ -3.01

Id da conta: 30
Saldo final: R$ 26.00
```

### Validações feitas:

Coluna sem inteiro

Falta de parâmetros ao executar programa

Arquivo não encontrado

Falha ao fazer o parse do csv

Conta duplicada no arquivo de contas

Transação para conta inexistente

Linha sem todas as colunas necessários

Linha vazia

### Gemas utilizadas:

**redis**: utilizar e fazer conexão com redis

**csv**: fazer leitura de arquivos csv
