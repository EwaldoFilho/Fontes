#include "TOPCONN.CH"
#include "TBICONN.CH"
#include "TOTVS.CH"
#include "FWBROWSE.CH"
#include "FWMVCDEF.CH"
#include "XMLXFUN.CH"
#include "RESTFUL.CH"
#include "PROTHEUS.CH"
#include 'restful.ch'

/**************************************************************************************************
{Protheus.doc} WSRESTCOT
@description	API para inclusão de solicitação de serviços
@type   		WSRESTFUL	
@author			Marcus Vinicius
@version   		1.00
@since     		06/12/2021
@database		11/12/2021
@country		Brasil
@language		PT-BR
@obs			06/12/2021 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
WSRESTFUL WSSERVICO DESCRIPTION "REST para solicitação de serviços"  
    WSMETHOD POST IncluirSolicitacaoServico DESCRIPTION "Incluir pedido de serviço" WSSYNTAX "WSSERVICO/{}" PRODUCES APPLICATION_JSON
END WSRESTFUL

WSMETHOD POST IncluirSolicitacaoServico WSRECEIVE WSRESTFUL WSSERVICO
    Local lRet  := .T.
    
    Local nSaveSx8 := 0
    Local _nBl := 0
    Local aArea := GetArea()
   
    Local aCabec := {}
    Local aItens := {}
    Local aLinha := {}

    Local oObjBack
    Local oItens

    Local  cJson := Self:GetContent()
    Local cError
    Local cJsonRet

    Local _cEmpC := ""
    Local _cFilC := ""
    
    Local nX

    Local cNumero := ""

    Private lMsErroAuto     := .F.

    /**********************************estrutura do oObjBack****************************************
      {
      "cuser":"marcus.silva",
      "csolicitacao":"12312",
      "cfilialc":"0101",
      "cempresac":"01",                
      "itens": [{
        "cidProduto":"100000000000810", 
        "cquantidade":"5",
        "ccusto": "10.10.01",
        "carmazem":"01MZ01",
        "cobs":"sdakfaksdf asd fasd fas df asd f as d fad fasd  adsfkdsjkw qwen qweq ocxoi sdsof"
      },{
        "cidProduto":"100000000000654",
        "cquantidade":"22",
        "ccusto": "10.10.01",
        "carmazem":"01MZ01",
        "cobs":"qqwe rqwerqwme nq cq we fqnwe nmqwe cq ocdjvlmxc."
      }]
    }  
    ***********************************************************************************************/

    //Converte meu json e confere se a estrutura possui algum erro
    Self:SetContentType("application/json")
    oObjBack   := JsonObject():New()

    _cEmpC := AllTrim(oObjBack:GetJsonObject('cempresac'))
    _cFilC := AllTrim(oObjBack:GetJsonObject('cfilialc'))

    cError  := oObjBack:FromJson(cJson)

    //Verifica se existe erro no meu objeto
    IF .NOT. Empty(cError)
        SetRestFault(500,'Parser Json Error')
        lRet    := .F.
    Else
      PREPARE ENVIRONMENT EMPRESA "01" FILIAL "0101" MODULO "COM"
        nSaveSx8    := GetSx8Len()
        cNumero     := GetSx8Num('SC1', 'C1_NUM')

        //Define a area de trabalho
        DbSelectArea('SC1')
        SC1->(DbSetOrder( 1 )) 

        While SC1->( DbSeek( xFilial( 'SC1' ) + cNumero ) )
          ConfirmSx8()
          cNumero := GetSx8Num('SC1', 'C1_NUM')
        EndDo

        //Monta cabecalho 
        aadd(aCabec,{"C1_NUM" ,cNumero})
        aadd(aCabec,{"C1_SOLICIT",oObjBack:GetJsonText('cuser')})
        aadd(aCabec,{"C1_EMISSAO",dDataBase})

        //Busca os itens no JSON, percorre eles e adiciona no array da SC6
        oItens  := oObjBack:GetJsonObject('itens')

        For nX := 1 To Len (oItens)
            aLinha := {}

            _nBl += 1

          aadd(aLinha,{"C1_ITEM" ,StrZero(nX,len(SC1->C1_ITEM)),Nil})
          aadd(aLinha,{"C1_PRODUTO", oItens[nX]:GetJsonText('cidProduto'),Nil})
          aadd(aLinha,{"C1_QUANT" ,VAL(oItens[nX]:GetJsonText('cquantidade')) ,Nil})
          aadd(aLinha,{"C1_OBS", oItens[nX]:GetJsonText('cobs'),Nil})
          aadd(aLinha,{"C1_LOCAL", oItens[nX]:GetJsonText('carmazem') ,Nil})
          aadd(aLinha,{"C1_CC", oItens[nX]:GetJsonText('ccusto'),Nil})
          aadd(aLinha,{"C1_USER", "000000",  Nil})
          aadd(aLinha,{"C1_ZSOLIC", oObjBack:GetJsonText('csolicitacao') ,Nil})
            
            aadd(aItens,aLinha)
        Next nX
      
        //Chama a inclusão automatica de solicitação de compra
        MSExecAuto({|w,x,y,z| MATA110(w,x,y,,,z)},aCabec,aItens,3)
        
        //Verifica se há erro na execução da rotina
        IF lMsErroAuto
            If !__lSX8
              RollBackSx8()
            EndIf
          ConOut(OemToAnsi("Erro na inclusao!")+cNumero)
          SetRestFault(500, 'Erro ao realizar solicitacao de compra!')

          cJsonRet    := '{"Erro ao realizar solicitacao de compra! Identificador: "'+cNumero+'"}'
          
          Self:SetResponse(cJsonRet)

          lRet := .F.
        ELSE
          While (GetSx8Len() > nSaveSx8)
            ConfirmSx8()
          End
          ConOut(OemToAnsi("Incluido com sucesso! ")+cNumero)
          SetRestFault(200, 'Solicitacao de compra gerada com sucesso!')
          
          cJsonRet    := '{"Solicitacao de compra gerada com sucesso! Identificador:"'+cNumero+'"}'
          
          Self:SetResponse(cJsonRet)
          
          lRet    := .T.
        ENDIF
      RESET ENVIRONMENT
    EndIf
    
    RestArea(aArea)
    FreeObj(oObjBack)


Return(lRet)
