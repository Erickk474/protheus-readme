# Guia de Referência Protheus


### Setup e Sistema de Diretórios
A explicação sobre o sistema de arquivos e setup de ambiente estão disponíveis na Aula 2

### Linguagem AdvPL
Nas aulas tem o básico da sintaxe da linguagem AdvPL, porém é possível acessar mais informações, como funções auxiliares, conceitos da linguagem e etc, no seguinte link: [Advpl](https://tdn.totvs.com/display/tec/AdvPL)

### Requisitos para o Início de Projeto
Como visto no treinamento, o sistema protheus possui algumas configurações de conexão de ambiente que precisam ser feitas antes de o ambiente ficar pronto para desenvolvimento. É necessário se atentar nos seguintes pontos:

#### Artefatos Protheus:
- Pasta smartclient com executável da versão que o cliente está usando, com informações de acesso ao server (smartclient.ini configurado)
- Includes que o cliente usa
- Enviar IP e porta do server
- Enviar IP e porta REST
- Acesso VPN para acessarmos o server ou exposto em IP público
- Criar usuário no protheus para o dev
- Ambiente de homologação:
- Server dedicado para o dev poder compilar as APIs a qualquer momento
- Base de dados dedicada para homologação (desejável)
- Acesso total ao servidor, inclusive para alterarmos o appserver.ini, pois é necessário desabilitar o REST para compilar e habilitar para consumir a API
- Ter ponto focal de Protheus no lado do cliente


