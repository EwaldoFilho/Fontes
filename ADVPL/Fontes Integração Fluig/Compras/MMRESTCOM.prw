#include "TOPCONN.CH"
#include "TBICONN.CH"
#include "TOTVS.CH"
#include "FWBROWSE.CH"
#include "FWMVCDEF.CH"
#include "XMLXFUN.CH"
#include "RESTFUL.CH"
#include "PROTHEUS.CH"

/**************************************************************************************************
{Protheus.doc} WSRESTCOT
@description	Endpoint criado para consumir o servico Json e tratar os dados 
@type   		WSRESTFUL	
@author			André Longhini
@version   		1.00
@since     		11/10/2021
@database		11/10/2021
@country		Brasil
@language		PT-BR
@obs			11/10/2021 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
WSRESTFUL WSRESTCOT DESCRIPTION "Consumindo o servico REST/ Servico a cotação"  

    WSDATA cfornecedor     As String OPTIONAL  
    WSDATA carmazem        As String OPTIONAL 
    WSDATA cempresac       As String OPTIONAL 
    WSDATA cfilialc        As String OPTIONAL 
    WSDATA cNumCotacao     As String OPTIONAL 
    WSDATA citemcotac      As String OPTIONAL 
    WSDATA cnprod          As String OPTIONAL 
    WSDATA cqtdprod        As String OPTIONAL 
    WSDATA clojaforn       AS String OPTIONAL 
    WSDATA cCentrocusto    AS String OPTIONAL 
    WSDATA cDescCC         AS String OPTIONAL 
    WSDATA cSolicitante    AS String OPTIONAL 
    WSDATA cNumProcesso    AS String OPTIONAL 

 


    WSMETHOD POST DESCRIPTION "Servico para consumir dados do fluig e realizar movimentação da Cotação" WSSYNTAX "WSRESTCOT/{}"

END WSRESTFUL

/**************************************************************************************************
{Protheus.doc} WSRESTCOT
@description	Metodo get recebe o json e realiza os tratamentos 
@type   		WSMETHOD	
@author			Andre langhini
@version   		1.00
@since     		11/10/2021
@database		11/10/2021
@country		Brasil
@language		PT-BR
@obs			11/10/2021 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
WSMETHOD POST WSRECEIVE cfornecedor, clojafornec, cempresac, cfilialc, cNumCotacao, citemcotac, cnprod, cqtdprod, cCentrocusto, cDescCC, cSolicitante, cNumProcesso, numSc WSSERVICE WSRESTCOT

Local _cEmpC            := ""
Local _cLojaFor         := ""
Local _cFornec          := ""
Local _cCotacao         := ""
Local _cCentroC         := ""
Local _cDescCentrocusto := ""
Local _cSolicitante     := ""
Local _cNumProcesso     := ""
Local _cnumSc            := ""
Local _cItemCot         := ""
Local _cnProd           := ""
Local _cQtProd          := ""
Local _cErro            := ""
Local _cFilC            := ""
Local _lRet             := .F.
Local _aProduto         := {}
Local cJSON             := Self:GetContent()
Private oJson           := JsonObject():New()


    Self:SetContentType("application/json")

    ret := oJson:FromJson(cJSON)
    
    If ValType(ret) == "C"
        _cErro  := '{ "mensagem": "Falha ao transformar texto em objeto json!"' +','+ CRLF
        _cErro  += ' "cerro" : '+  ret	        	                            +'}'
        conout("Falha ao transformar texto em objeto json. Erro: " + ret)
        oGvrScp:Mistake(_cErro)
        return
    EndIf

    //-------------------------------------------------------------------
    // Funcao para desserializar o json 
    //-------------------------------------------------------------------
    U_DeserlJson(oJson, @_cFornec, @_cLojaFor, @_cEmpC, @_cFilC, @_cCotacao, @_cItemCot, @_cnProd, @_cQtProd, @_cCentroC, @_cDescCentrocusto, @_cSolicitante, @_cNumProcesso,  @_cNumSc, @_aProduto)
  
    _lRet := U_fGrav160(oJson, @_cFornec, @_cLojaFor, @_cEmpC, @_cFilC, @_cCotacao, @_cItemCot, @_cnProd, @_cQtProd, @_cCentroC, @_cDescCentrocusto, @_cSolicitante, @_cNumProcesso, @_cNumSc, @_aProduto)
 
    If !(_lRet)
        Return(.F.)
    EndIf

Return(.T.)

/**************************************************************************************************
{Protheus.doc} DeserlJson
@description	Funcao para desserializar o json  
@type   		Funcao	
@author			Andre langhini
@version   		1.00
@since     		11/10/2021
@database		11/10/2021
@country		Brasil
@language		PT-BR
@obs			11/10/2021 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
User function DeserlJson(jsonObj, _cFornec, _cLojaFor, _cEmpC, _cFilC, _cCotacao, _cItemCot, _cnProd, _cQtProd, _cCentroC, _cDescCentroC, _cSolicitante, _cNumProcesso, _cNumSc, _aProduto)
Local i, j
Local names
Local lenJson
Local item
Local _nJson := 0
Local aJson := {}

    lenJson := len(jsonObj)
 
    If lenJson > 0

        For i := 1 to lenJson
            U_DeserlJson(jsonObj[i])
        Next

    Else

        names := jsonObj:Getnames()

        For i := 1 to len(names)
            item := jsonObj[names[i]]

            If ValType(item) == "C"
                Aadd(aJson,{names[i], cvaltochar(jsonObj[names[i]])})              
                _cCotacao                := IIF(AllTrim(Lower(names[i]))     == "cnumcotacao"                  , AllTrim(jsonObj[names[i]]),  _cCotacao          )  
                _cEmpC                   := IIF(AllTrim(Lower(names[i]))     == "cempresac"                    , AllTrim(jsonObj[names[i]]),  _cEmpC             )
                _cFilC                   := IIF(AllTrim(Lower(names[i]))     == "cfilialc"                     , AllTrim(jsonObj[names[i]]),  _cFilC             )          
                _cCentroC                := IIF(AllTrim(Lower(names[i]))     == "ccentrocusto"                 , AllTrim(jsonObj[names[i]]),  _cCentroC          )          
                _cDescCentroC            := IIF(AllTrim(Lower(names[i]))     == "cdesccentrocusto"             , AllTrim(jsonObj[names[i]]),  _cDescCentroC      )          
                _cSolicitante            := IIF(AllTrim(Lower(names[i]))     == "csolicitante"                 , AllTrim(jsonObj[names[i]]),  _cSolicitante      )          
                _cNumProcesso            := IIF(AllTrim(Lower(names[i]))     == "cnumprocesso"                 , AllTrim(jsonObj[names[i]]),  _cNumProcesso      )   
                _cNumSc            := IIF(AllTrim(Lower(names[i]))           == "cnumsc"                       , AllTrim(jsonObj[names[i]]),  _cNumSc      )          

            ElseIf  ValType(item) == "J"
                _nJson++
                ret := oJson:GetJsonObject(names[i])
                QbraJson(ret, @_aProduto, _nJson)
            
            Else

                If ValType(item) == "A"

                    For j := 1 to len(item)
                        U_DeserlJson(item[j])
                    Next j

                Endif

            Endif

        Next i

    Endif

Return(.T.)

/**************************************************************************************************
{Protheus.doc} QuebraJson
@description	Trativas das chaves do json
@type   		Funcao	
@author			Lucas Rocha Vieira
@version   		1.00
@since     		11/10/2021
@database		11/10/2021
@country		Brasil
@language		PT-BR
@obs			11/10/2021 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
Static Function QbraJson(jsonObj, _aProduto, _nJson)
  local i, j
  local names
  local lenJson
  local item
 
  lenJson := len(jsonObj)
 
  If lenJson > 0

    For i := 1 to lenJson
      QbraJson(jsonObj[i])
    Next

  Else

    names := jsonObj:GetNames()

    For i := 1 to len(names)

      item := jsonObj[names[i]]

      If ValType(item) == "C" .or.  ValType(item) == "N"

        Aadd(_aProduto,{names[i], cvaltochar(jsonObj[names[i]]), _nJson})
    
      Else

        If ValType(item) == "A"

          conout("Vetor[")

          For j := 1 to len(item)

            conout("Indice " + cValtochar(j))

            If ValType(item[j]) == "J"
              QbraJson(item[j])
            Else
              conout(cvaltochar(item[j]))
            Endif

          Next j

          conout("]Vetor")

        Endif

      Endif

    Next i

  Endif

Return
