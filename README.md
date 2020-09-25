# Helios Voting Docker

> Proposta para execução do helios voting em container docker

## Observações

Essa versão inicial é baseada no repositório do IFSC que provê autenticação LDAP.

Para detalhes acesse: [https://github.com/ifsc/helios-server]

## Requisitos

docker e docker-compose:

Docker version 19.03.13
docker-compose version 1.27.3

## Como executar

1. clone o repositório

2. acesse a pasta criada e execute:

```
docker-compose -u -d
```

3. verifique se os container estão ativos

```
docker-compose ps
```

heliosapp e heliosbd

4. execute o script (start.sh) para executação das migrations

```
./start.sh
```

5. faça os ajustes no settings.py
   O settings.py já estabelece a conexão do container postgresql.
   Entretanto, demais ajustes para envio de email, ldap, etc. devem ser realizados.

## Ajustes futuros

1. Migração para alpine
2. Adição da camada de load balance com nginx
3. Separação da camada httpd
4. Aprimorar processo de inicialização do container
