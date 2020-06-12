# Guia de Referência Protheus


### Setup e Sistema de Diretórios
Você pode acessar o video da aula e mais arquivos desse link: [Aula_Protheus](https://drive.google.com/drive/u/0/folders/1qQ28BIS-p4wHPqf6MdBrkGqAwPZyPdLh)).

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
    - No VSCode, abra a pasta do código, clique com o botão direito e abra "Open Folder Settings"
    - Abra o tópico "Text Editor" e abaixo de "Code Actions on Save" clique em "Edit in Settings.json". Isso gerará uma pasta .vscode com um arquivo "settings.json"
    - ![vscode settings](https://user-images.githubusercontent.com/51421653/84521615-a83a4e80-acab-11ea-9bbd-122ea0cb7c9b.PNG)
    - Configure o "settings.json" seguindo o modelo abaixo: 

```
{
    "advpl.environments": [
        {
            "smartClientPath": "C:\\Protheus\\BIN\\Smartclient-Carajas\\",
            "environment": "TESTE",
            "includeList": "C:\\Protheus\\includes\\",
            "server": "192.168.0.1",
            "port": "5000",
            "user": "Usuario",
            "passwordCipher": "senhaDoUsuario123"
        }
    ],
    "advpl.workspaceFolders": "c:\\Users\\Protheus\\api-protheus",
    "advpl.selectedEnvironment": "TESTE"
}
```
- SmartClientPath: 
    - Caminho absoluto da pasta "smartclient" em seu computador
- Environment:
    - Nome do ambiente do cliente
- IncludeList:
    - Caminho absoluto da pasta "include" em seu computador
- Server:
    - IP do servidor
- Port:
    - Porta do servidor
- User: 
    - Usuário para acesso ao servidor
- PasswordCipher: 
    - Senha para acesso ao servidor
- Advpl.workspaceFolders:
    - Caminho absoluto da pasta onde você irá armazenar os códigos
- Advpl.selectedEnvironment:
    - Sugiro colocar o nome do ambiente do cliente novamente

Para finalizarmos a configuração do .vscode, nós temos que seguir um processo de encriptação de senha, para isso, abra o console do vscode
```
Windows: Ctrl + ' 
Linux: Ctrl + Shift + `
```
vá até a aba "OUTPUT".
Agora com o arquivo settings.json aberto utilize o comando Ctrl + P e escreva '>Advpl - Compiler Cipher' isso irá abrir uma caixa de texto, coloque a senha que foi escrita no arquivo settings.json e uma nova senha será gerada no console, cole a nova senha no arquivo settings.json no lugar na senha antiga.

Após toda a configuração do settings.json, será necessário informar o ambiente em que você está trabalhando, para isso, selecione o ambiente no canto inferior direito do VSCode e uma caixa seletora aparecerá na parte superior, selecione o ambiente (nesse caso é o "TESTE")e pronto. 

Antes:

![environment](https://user-images.githubusercontent.com/51421653/84517493-c8670f00-aca5-11ea-8b61-ab037c37cf2f.PNG)

Depois:

![environment setado](https://user-images.githubusercontent.com/51421653/84517992-6529ac80-aca6-11ea-82d2-bd1eb0fcb63a.PNG)

Pronto! agora você está pronto para desenvolver.

### Compilação