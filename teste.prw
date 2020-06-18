#INCLUDE "TOTVS.CH"
#INCLUDE "RESTFUL.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"

User Function apiProduct()

Return

Class Products

    Data filial As String
    Data codigo As String
    Data descricao As String
    Data valor As String
    Data produto As String
    Data status As String

    Method New(filial, codigo, descricao, valor, produto, status) Constructor 

End Class

Method New(cFilial, cCodigo, cDescricao, cValor, cProduto, cStatus) Class Products

    ::filial := cFilial
    ::codigo := cCodigo
    ::descricao := cDescricao
    ::valor := cValor
    ::produto := cProduto
    ::status := cStatus

Return(Self)

WSRESTFUL products DESCRIPTION "Product REST API"

    WSDATA offset As Integer
    WSDATA limit As Integer

    WSMETHOD GET DESCRIPTION "Get list of products" WSSYNTAX "/products"

END WSRESTFUL 

WSMETHOD GET WSRECEIVE offset, limit, id WSSERVICE products
    
    Local oProduct
    Local aArea := {}
    Local cQuery := ""
    
    DEFAULT ::offset := 0, ::limit := 20

    ::SetContentType("application/json")

    aArea := GetArea()

    cAliasAY := GetNextAlias()

    cQuery := "SELECT AY5_FILIAL, AY5_CODIGO, AY5_DESCRI, AY5_VALOR, AY5_CODPRO, AY5_STATUS "
    cQuery += "FROM  " + RetSQLName("AY5")

    DbUseArea(.F., 'TOPCONN', TcGenQry(,,cQuery), (cAliasAY), .F., .T.)

    (cAliasAY)->(dbGoTop())

    If EMPTY((cAliasAY)->AY5_CODIGO)
        ::SetResponse('{"product": false, "message": "product not found"}')
        Return .T.
    EndIf

    ::SetResponse('[')

    For nReg := 1 to ::limit

        If (cAliasAY)->(EOF())  
            Exit                
        EndIf

        cFILIAL := RTRIM((cAliasAY)->AY5_FILIAL)
        cCODIGO := RTRIM((cAliasAY)->AY5_CODIGO)
        cDESC := RTRIM((cAliasAY)->AY5_DESCRI)
        cVALOR :=  RTRIM(cVALTOCHAR((cAliasAY)->AY5_VALOR))
        cCODPRO :=  RTRIM(cVALTOCHAR((cAliasAY)->AY5_CODPRO))
        cSTATUS := RTRIM(cVALTOCHAR((cAliasAY)->AY5_STATUS))

        oProducts := Products():New(cFILIAL, cCODIGO, cDESC, cVALOR, cCODPRO, cSTATUS)

        ::SetResponse(oProducts)

        (cAliasAY)->(dbSkip())

        If nReg != ::limit .And. (cAliasAY)->(!EOF())  
            ::SetResponse(',')                         
        EndIf

    Next

    ::SetResponse(']}')

    RestArea(aArea)

Return .T.