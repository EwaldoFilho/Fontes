#Include "TOTVS.CH"
#Include "TOPCONN.CH"
#Include "RESTFUL.CH"

#define OPC_INCLUSAO 3

/*/{Protheus.doc} 
Webservice utilizado para movimenta��o de estoque

@type WSRESTFUL
@author Diego de Angelo
@since 28/09/2020
/*/
WSRESTFUL APImovimentacaoEstoque DESCRIPTION "Webservice utilizado para movimenta��o de estoque"

    WSDATA company AS STRING OPTIONAL
    WSDATA branch AS STRING OPTIONAL

    WSMETHOD POST add DESCRIPTION "M�todo para incluir uma movimenta��o de estoque" PATH "/add"

END WSRESTFUL

/*
M�todo para incluir uma movimenta��o de estoque

Exemplo:
Endpoint: APImovimentacaoEstoque/add
Request (Body):
{
    "company": "99",
    "branch": "01",
    "header": {
        "D3_TM": "VENDEDOR",
        "D3_EMISSAO": "28/09/2020"
    },
    "items": [{
                    "D3_COD": "1",
                    "D3_UM": "UN",
                    "D3_LOCAL": "01",
                    "D3_QUANT": "1",
                    "D3_LOTECTL": "22968/C"
                }
	    
}
*/
WSMETHOD POST add WSSERVICE APImovimentacaoEstoque
    Local cBody         := ::GetContent()
    local cError        := ""
    local oJson		    :=  JSonObject():New()
    local cCompany      := ""
    local cBranch       := ""
    local oHeader       := Nil
    local oItems        := nil
    local cMessage      := ""
    local lStatus       := .F.
    local aHeader       := {}
    local aItems        := {}
    local oResponse     := apiResponse():new()

    Private lMsHelpAuto	   := .T.
    Private lMsErroAuto	   := .F.
    Private lAutoErrNoFile := .T.

    ::SetContentType("application/json")

    cError := oJSon:fromJson(cBody)

    if ValType(cError) == "U"
        begin Sequence
            cCompany := oJson:GetJSonObject("company")
            cBranch  := oJson:GetJSonObject("branch")
            
            if !configureCompany(cCompany, cBranch)
                cMessage := "Empresa / filial n�o foram informados."
                break
            endIf

            oHeader         := oJson:GetJSonObject("header")
            oItems          := oJson:GetJSonObject("items")

            if isUndefined(oHeader)
                cMessage    := "Cabe�alho informado � inv�lido"
                break
            else
                aHeader := getArrayHeader(oHeader)
            endIf

            if isUndefined(oItems)
                break
                cMessage    := "Array de itens informado � inv�lido"
            else
                aItems := getArrayItems(oItems)
            endIf

            aHeader         := FWVetByDic(aHeader,"SD3")
            aItems          := FWVetByDic(aItems,"SD3",.T.)

            msExecAuto({|x,y,z| MATA241(x,y,z)},aHeader, aItems, OPC_INCLUSAO)

            if !lMsErroAuto
                cMessage    := "Movimenta��o de Estoque inclu�da com sucesso."
                lStatus := .T.
            else
                cMessage    := getErroAuto()
            endIf
        end Sequence
    else
        cMessage    := "Falha ao realizar a convers�o do json:  " + cBody
    endIf

    oResponse:setStatus(lStatus)
    oResponse:setMessage(cMessage)

    ::SetResponse(EncodeUTF8(FWJsonSerialize(oResponse,.F.,.F.)))

Return(.T.)



/*
*   Fun��o respons�vel por preparar o ambiente.
*/
static function configureCompany(cCompany,cBranch)
    Local lMudaEmp	:= .F.
    local lRet := .F.

    if !isUndefined(cCompany) .AND. !isUndefined(cBranch)
        lRet := !Empty(cCompany) .AND. !Empty(cBranch)
        If lRet
            If cEmpAnt <> cCompany .AND. !(Empty(cCompany))
                lMudaEmp := .T.
            Endif

            If cFilAnt <> cBranch .AND. !(Empty(cBranch))
                cFilAnt := cBranch
            Endif

            If lMudaEmp
                RpcClearEnv()
                RpcSetType(3)
                RpcSetEnv(cCompany,cFilAnt)
            Endif
        endIf
    endIf
return lRet


/*
*   Fun��o respons�vel por tratar os valores de acordo com o SX3
*/
static function prepareValue(cField, xValue)
    local cType := GetSx3Cache(cField,"X3_TIPO")
    local nSize := 0

    if cType == "D"
        xValue   := CTOD(xValue)
    elseIf cType == "N" .AND. valType(xValue) != "N"
        xValue := val(xValue)
    elseIf cType == "C"
        nSize       := tamSX3(cField)[1]
        xValue      := alltrim(xValue)
        if !isUndefined(nSize)
            xValue  := padR(xValue,nSize)
        endIf
    endIf
return xValue


/*
*   Fun��o respons�vel por vefificar se uma variavel � undefined
*/
static function isUndefined(xValue)
return valType(xValue) == "U"


/*
*   Fun��o respons�vel por tratar o json e retornar o array de cabe�alho da rotina automatica.
*/
static function getArrayHeader(oHeader)
    local nI            := 1
    local aHeaderFields := oHeader:GetNames()
    local cField        := ""
    local xValue        := nil
    local aHeader       := {}

    for nI := 1 to len(aHeaderFields)
        cField  := aHeaderFields[nI]
        xValue  := prepareValue(cField, oHeader:GetJSonObject(cField))

        aADD(aHeader, {cField, xValue, nil})
    next nI
return aHeader


/*
*   Fun��o respons�vel por tratar o json e retornar o array de itens da rotina automatica.
*/
static function getArrayItems(oItems)
    local nI    := 1
    local nJ    := 1
    local oItem := nil
    local aItems := {}
    local aItem  := {}
    local aItemsFields  := {}
    local cField    := ""
    local xValue    := nil

    for nI := 1 to len(oItems)
        aItem           := {}
        oItem           := oItems[nI]
        aItemsFields    := oItem:GetNames()

        for nJ := 1 to len(aItemsFields)
            cField  := aItemsFields[nJ]
            xValue  := prepareValue(cField, oItem:GetJSonObject(cField))

            aADD(aItem, {cField, xValue, nil})
        next nJ
        aADD(aItems, aItem)
    next nI
return aItems


/*
*   Fun��o respons�vel por retornar a mensagem da rotina automatica.
*/
static function getErroAuto()
    local aErro := getAutoGRLog()
    local nI    := 1
    local cMsg  := ""

    for nI := 1 to len(aErro)
        cMsg += aErro[nI]+ " <br>"
    next nI
return cMsg
