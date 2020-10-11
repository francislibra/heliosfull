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

### Execute o script start.sh

```
./start.sh
```

Esse script executa a migration do django e ajustes na tabela auth_users.


### Execução

O container será executado na porta 8080 do host e será redirecionado para 443 (https)

Abra o navegador e acesse:
```
http://localhost:8080.
```
A porta pode ser alterada no .ENV ou diretamente no docker-compose.


### Ajustes no .ENV

Crie o arquivo .ENV no seguinte formanto:
```
#POSTGRES
POSTGRES_DB= banco
POSTGRES_USER= usuario
POSTGRES_PASSWORD= senha
POSTGRES_HOST= host
POSTGRES_PORT= 5432
PGDATA= /var/lib/postgresql/data
AUTH_METHOD= md5

#DJANGO
SITE_TITLE='SISTEMA DE VOTAÇÃO'
ADMINS_NAME='STI UNIFESP'
ADMINS_EMAIL= 'sti@unifesp.br'
SECRET_KEY=j-s8n7m2)l-jn4rpxhxg+d%go#!hbhsb-$z233oemm@8+um6hs

PORT_HOST=8080
```
Se necessário, crie novos parâmetros
.
No settings.py a nova variável também deve ser incluída, verifique se existe o parâmetro "get_from_env".
Ex: get_from_env('POSTGRES_DB')


### Volumes

Todos os mapeamentos estão na pasta /volumes.  São eles:

    - ./volumes/helios-server:/home/eleicao
    - ./volumes/apache:/etc/apache2/sites-available
    - ./volumes/log:/var/log/apache2
    - ./volumes/certs:/etc/ssl/private-unifesp
    - ./volumes/bd:/var/lib/postgresql/data

### Fixando o IPs
Exemplo de configuração do Docker-Compose
```
networks:
  heliosnetwork:
    driver: bridge
    ipam:
     config:
       - subnet: 10.8.0.0/16
         gateway: 10.8.0.1
         aux_adressess:
            heliosbd: 10.8.0.2
            heliiosapp: 10.8.0.3
```

    
## Ajustes futuros
```
Migração para alpine
Adição da camada de load balance com nginx
Separação do apache ou nginx
```
