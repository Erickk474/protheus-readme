# Guia de Referência Protheus


### Setup e Sistema de Diretórios
Você pode acessar o video da aula e mais arquivos desse link: [Aula_Protheus](https://drive.google.com/drive/u/0/folders/1qQ28BIS-p4wHPqf6MdBrkGqAwPZyPdLh).

### Linguagem AdvPL
Nas aulas tem o básico da sintaxe da linguagem AdvPL, porém é possível acessar mais informações, como funções auxiliares, conceitos da linguagem e etc, no seguinte link: [Advpl](https://tdn.totvs.com/display/tec/AdvPL)

### Requisitos para o Início de Projeto
Como visto no treinamento (caso não tenha participado do treinamento, você pode acessá-lo através desse link: [Treinamento_Protheus](https://drive.google.com/drive/u/0/folders/1qQ28BIS-p4wHPqf6MdBrkGqAwPZyPdLh)), o sistema protheus possui algumas configurações de conexão de ambiente que precisam ser feitas antes de o ambiente ficar pronto para desenvolvimento. É necessário se atentar nos seguintes pontos:

#### Artefatos Protheus:
- Pasta smartclient com executável da versão que o cliente está usando, com informações de acesso ao server (smartclient.ini configurado pelo cliente)
- Pasta Includes
- IP e porta do server
- IP e porta REST
- Acesso VPN
- Criar usuário no protheus para o desenvolvedor
- Ambiente de homologação
- Server dedicado para compilação
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

Após toda a configuração do settings.json, será necessário informar o ambiente em que você está trabalhando, para isso, selecione o ambiente no canto inferior direito do VSCode e uma caixa seletora aparecerá na parte superior, selecione o ambiente (nesse caso é o "TESTE") e pronto. 

Antes:

![environment](https://user-images.githubusercontent.com/51421653/84517493-c8670f00-aca5-11ea-8b61-ab037c37cf2f.PNG)

Depois:

![environment setado](https://user-images.githubusercontent.com/51421653/84517992-6529ac80-aca6-11ea-82d2-bd1eb0fcb63a.PNG)

Pronto! agora você está pronto para desenvolver.

### Primeira API

Primeiro, começaremos com os imports da pasta Includes que o cliente enviar seguindo essa sintaxe;

```
#INCLUDE "TOTVS.CH"
#INCLUDE "RESTFUL.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
```

Agora, precisamos criar uma função para a compilação no RPO, a função pode ser vazia, é apenas para ser chamada no momento da compilação;

```
User Function apiProduct()

Return
```

Agora, precisamos criar uma classe para a montagem do objeto de resposta da nossa API. É possível montar o objeto de uma maneira mais grosseira, porém, esse é o melhor caminho;

Classe: 
```
Class Products

    Data filial As String
    Data codigo As String
    Data descricao As String
    Data valor As String
    Data produto As String
    Data status As String

    Method New(filial, codigo, descricao, valor, produto, status) Constructor 

End Class
```

Metodo: Utilizamos as mesmas variaveis na classe;

_o 'c' que antecede todas as variaveis abaixo é para explicar o tipo do dado, exemplo:_<br>
_c = caractere,_<br>
_n = numerico,_<br>
_o = objeto,_ <br>
_etc...)_
```
Method New(cFilial, cCodigo, cDescricao, cValor, cProduto, cStatus) Class Products

    ::filial := cFilial
    ::codigo := cCodigo
    ::descricao := cDescricao
    ::valor := cValor
    ::produto := cProduto
    ::status := cStatus

Return(Self)
```

Chegou a hora de criarmos a primeira rota da nossa API;

WSRESTFUL -> Nome semântico da rota.<br>
DESCRIPTION -> Descrição da rota.<br>
WSMETHOD -> Método da rota.<br>
WSSYNTAX -> Recurso da rota.<br>
WSDATA -> Parâmetros da rota.<br>

```
WSRESTFUL products DESCRIPTION "Product REST API"

    WSDATA offset As Integer
    WSDATA limit As Integer

    WSMETHOD GET DESCRIPTION "Get list of products" WSSYNTAX "/products"

END WSRESTFUL 
```

Neste passo, estaremos escrevendo o que a nossa rota irá fazer.<br>
WSMETHOD GET -> Rota que estamos que estamos construindo.<br>
WSRECEIVE -> Rota poderá receber na queryString.<br>
WSSERVICE -> Serviço ('products' que criamos anteriormente em 'WSRESTFUL').<br>

Em seguida, declaramos as variaveis locais que utilizaremos dentro do contexto da rota. <br>
<b>offset</b> e <b>limit</b> estão em <b>DEFAULT</b> para definir o valor padrão caso não seja informado pela querystring durante a chamada do usuário. (Utilizaremos para paginação de resultados);

E por fim, setamos o tipo do conteudo (SetContentType);

```
WSMETHOD GET WSRECEIVE offset, limit, id WSSERVICE products
    
    Local oProduct
    Local aArea := {}
    Local cQuery := ""
    
    DEFAULT ::offset := 0, ::limit := 20

    ::SetContentType("application/json")
```

Agora, faremos a chamada no banco de dados para buscar as informações solicitadas;

GetArea -> <br>
GetNextAlias -> <br> 
cQuery -> query formada para a chamada no banco de dados. <br>
<ul>
DbUseArea -> parametros informados para a execução da chamada (para suas próximas chamadas).<br>
<b>DBUseArea([ lNewArea ], [ cDriver ], < cFile >, < cAlias >, [ lShared ], [ lReadOnly ]).</b>
<li>lNewArea -> Caso verdadeiro, indica que a tabela deve ser aberta em uma nova workarea (Default=.F.)</li>
<li>cDriver -> Informa o Driver (RDD) a ser utilizada para a abertura da tabela. Caso não especificado (NIL), será usado o driver default de acesso a arquivos locais.</li>
<li>cFile -> Nome da arquivo/tabela a ser aberta. Caso o driver utilizado acesse tabelas no sistema de arquivos, deve ser informado um path no servidor de aplicação. Não é possível abrir tabelas de dados no SmartClient.</li>
<li>cAlias -> Nome dado ao ALIAS desta tabela, para ser referenciado no programa Advpl.</li>
<li>lShared -> Caso verdadeiro, indica que a tabela deve ser aberta em modo compartilhado, isto é, outros processos também poderão abrir esta tabela.</li>
<li>lReadOnly -> Caso verdadeiro, indica que este alias será usado apenas para leitura de dados. Caso contrário, estas operações serão permitidas.</li>
</ul>

```
aArea := GetArea()

cAliasZJ := GetNextAlias()

cQuery := "SELECT P1.ZJ_IDVTEX AS ZJ_IDVTEX, P1.ZJ_PRODUTO AS ZJ_PRODUTO, "
cQuery += "P1.ZJ_DESC AS ZJ_DESC, P1.ZJ_DESCSKU AS ZJ_DESCSKU, P1.ZJ_CODBAR AS ZJ_CODBAR, "
cQuery += "P1.ZJ_REFSKU AS ZJ_REFSKU, P1.ZJ_PESO AS ZJ_PESO, P1.ZJ_ALTURA AS ZJ_ALTURA, "

DbUseArea(.F., 'TOPCONN', TcGenQry(,,cQuery), (cAliasZJ), .F., .T.)
```

### Compilação
[To Do]