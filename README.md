# Guia de Referência Protheus


### Setup e Sistema de Diretórios
A explicação sobre o sistema de arquivos e setup de ambiente estão disponíveis na Aula 2 (você pode acessar através desse link: [Aula_Protheus](https://drive.google.com/drive/u/0/folders/1qQ28BIS-p4wHPqf6MdBrkGqAwPZyPdLh)).

### Linguagem AdvPL
Nas aulas tem o básico da sintaxe da linguagem AdvPL, porém é possível acessar mais informações, como funções auxiliares, conceitos da linguagem e etc, no seguinte link: [Advpl](https://tdn.totvs.com/display/tec/AdvPL)

### Requisitos para o Início de Projeto
Como visto no treinamento (caso não tenha participado do treinamento, você pode acessá-lo através desse link: [Treinamento_Protheus](https://drive.google.com/drive/u/0/folders/1qQ28BIS-p4wHPqf6MdBrkGqAwPZyPdLh)), o sistema protheus possui algumas configurações de conexão de ambiente que precisam ser feitas antes de o ambiente ficar pronto para desenvolvimento. É necessário se atentar nos seguintes pontos:

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
- Acesso total ao servidor, inclusive para alterarmos o appserver.ini, pois é necessário desabilitar o REST para compilar e habilitar para consumir a API (será explicado mais adiante)
- Ter ponto focal de Protheus no lado do cliente

## Iniciando com o projeto
Após estarmos conectados à VPN e termos todas as premissas em mãos, podemos começar com a configuração inicial do ambiente.

- Guarde as pastas 'Smartclient' e 'Includes' no seu computador
- Crie uma pasta para o código do seu projeto
- Inicie um arquivo de configuração .vscode

```
{
    "advpl.environments": [
        {
            "smartClientPath": "C:\\Protheus\\BIN\\Smartclient-Carajas\\",
            "environment": "CARAJAS_HOMOLOG",
            "includeList": "C:\\Protheus\\includes\\",
            "server": "192.168.0.13",
            "port": "1350",
            "user": "linkapi",
            "passwordCipher": "ZUdXZDI3K2IzRWFTRkdqaHYvZVdTZkJoQVFCZ01nNUN0R3p0UEd0NzFFbGRwWXRIQ2NuV1plcnRKWStFd3RxL05tTUNKaEtObHRVTjB5QTJDSkpLaFBzVTA4SGNlVjZhS2JtN2F0VGdTTmM0bFdkMWduQXJJd1pXVmk4RU5DR1U="
        }
    ],
    "advpl.workspaceFolders": "c:\\Users\\lkpadmin\\Desktop\\Protheus\\carajas\\api-protheus-carajas;",
    "advpl.selectedEnvironment": "CARAJAS_HOMOLOG"
}
```