# Helios Voting Docker

> Proposta para execução do helios voting em container docker

## Observações

Essa é uma proposta inicial do Helios Voting adaptado para ser executado em container docker e baseado na versão publicada no repositório do IFSC.

Para detalhes acesse: [https://github.com/ifsc/helios-server]

## Requisitos

docker e docker-compose:

    - docker version 19.03.13
    - docker-compose version 1.27.3

## Como executar

### Clone o repositório

- clone o repositório [git clone https://git.unifesp.br/votacao-unifesp/heliosdocker.git]

- acesse a pasta criada e execute:

```
docker-compose -u -d
```

- serão criados dois containers:
    - heliosapp (helios)
    - heliosbd (postgresql)


### Verifique se os container estão ativos

```
docker-compose ps
```
ou

```
docker ps
```

### Execute o script (start.sh) para executação das migrations

```
./start.sh
```

Esse script executa a migration do django e ajustes na tabela de auth_users.

### Faça os ajustes no settings.py

O settings.py já estabelece a conexão do container postgresql (heliosbd).
Entretanto, demais ajustes para envio de email, ldap, etc. devem ser realizados.


### Execução

O container será executado na porta 8080 do host mas será redirecionado para 443 (https)
Dessa forma, abra o navegador e acesse 
```
http://localhost:8080.
```

Se necessário, altere o IP no arquivo settings.py na pasta /helios-server, especificamente no parâmetro:

```
ALLOWED_HOSTS = get_from_env('ALLOWED_HOSTS', '*').split(",")
```

### Volumes

Todos os mapeamentos estão na pasta /volumes.  São eles:

    - ./volumes/helios-server:/home/eleicao
    - ./volumes/apache:/etc/apache2/sites-available
    - ./volumes/log:/var/log/apache2
    - ./volumes/certs:/etc/ssl/private-unifesp
    - ./volumes/bd:/var/lib/postgresql/data


## Ajustes futuros

1. Migração para alpine
2. Adição da camada de load balance com nginx
3. Separação do apache ou nginx
4. Aprimorar processo de inicialização do container

