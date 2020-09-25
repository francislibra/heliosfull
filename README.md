# Helios Voting Docker

> Proposta para execução do helios voting em container docker

## Observações

Essa é uma versão inicial para docker baseada no repositório do IFSC que provê autenticação LDAP.

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

Esse script executa apenas a migration do django e ajustes na tabela de auth_users.

### Faça os ajustes no settings.py

O settings.py já estabelece a conexão do container postgresql (heliosbd).
Entretanto, demais ajustes para envio de email, ldap, etc. devem ser realizados.


## Ajustes futuros

1. Migração para alpine
2. Adição da camada de load balance com nginx
3. Separação da camada httpd
4. Aprimorar processo de inicialização do container

