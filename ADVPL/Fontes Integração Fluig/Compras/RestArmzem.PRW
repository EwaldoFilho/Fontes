#include "TOPCONN.CH"
#include "TBICONN.CH"
#include "TOTVS.CH"
#include "FWBROWSE.CH"
#include "FWMVCDEF.CH"
#include "XMLXFUN.CH"
#include "RESTFUL.CH"
#include "PROTHEUS.CH"

/**************************************************************************************************
{Protheus.doc} WSARMAZEM
@description	Endpoint criado para consumir o servico Json e tratar os dados 
@type   		WSRESTFUL	
@author			Lucas Rocha Vieira
@version   		1.00
@since     		22/09/2021
@database		22/09/2021
@country		Brasil
@language		PT-BR
@obs			22/09/2021 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
WSRESTFUL WSARMAZEM DESCRIPTION "Consumindo o servico REST/ Servico ao armazem"  

    WSDATA cidProduto   As String OPTIONAL  
    WSDATA cquantidade  As String OPTIONAL 
    WSDATA cobs         As String OPTIONAL 
    WSDATA cuser        As String OPTIONAL 
    WSDATA ccusto       As String OPTIONAL 
    WSDATA cempresa     As String OPTIONAL 
    WSDATA cfilial      As String OPTIONAL 
    WSDATA carmazem     As String OPTIONAL 
    WSDATA csolicitacao AS String OPTIONAL

    WSMETHOD POST DESCRIPTION "Servico para consumir dados do fluig e armazena-los ao armazem" WSSYNTAX "WSARMAZEM/{}"

END WSRESTFUL

/**************************************************************************************************
{Protheus.doc} WSARMAZEM
@description	Metodo get recebe o json e realiza os tratamentos 
@type   		WSMETHOD	
@author			Lucas Rocha Vieira
@version   		1.00
@since     		22/09/2021
@database		22/09/2021
@country		Brasil
@language		PT-BR
@obs			22/09/2021 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
WSMETHOD POST WSRECEIVE cidProduto, cquantidade, cobs, cuser, ccusto, cempresa, cfilial, carmazem, csolicitacao  WSSERVICE WSARMAZEM

Local _cIdProd      := ""
Local _cQuanProd    := ""
Local _cObs         := ""
Local _cUser        := ""
Local _cCusto       := ""   
Local _cEmp         := ""
Local _cArmazem     := ""
Local _cSolicit     := ""
Local _cErro        := ""
Local _cOk          := ""
Local _cFil         := ""
Local  aProduto     := {}
Local oGvrScp       := ArmzScp():New()
Local _cAlias       := GetNextAlias()
Local cJSON         := Self:GetContent()
Private oJson       := JsonObject():New()


    Self:SetContentType("application/json")

    ret := oJson:FromJson(cJSON)
    
    If ValType(ret) == "C"
        _cErro  := '{ "mensagem": "Falha ao transformar texto em objeto json!"' +','+ CRLF
        _cErro  += ' "cerro" : '+  ret	        	                            +'}'
        conout("Falha ao transformar texto em objeto json. Erro: " + ret)
        return
    EndIf

    //-------------------------------------------------------------------
    // Funcao para desserializar o json 
    //-------------------------------------------------------------------
    U_ToBreakJson(oJson, @_cIdProd, @_cQuanProd, @_cObs, @_cUser, @_cCusto, @_cEmp, @_cArmazem, @_cFil, @_cSolicit, @aProduto)

    //-------------------------------------------------------------------
    // Chamando o metodo para a validacao
    //-------------------------------------------------------------------
    //oGvrScp:Validation(_cUser, _cCusto, _cFil, _cIdProd, @_cErro, @_cAlias)

    If !Empty(_cErro)
        Return(.F.)
    Else 
        //-------------------------------------------------------------------
        // Chamando o metodo para gravar na tabela
        //-------------------------------------------------------------------
        oGvrScp:Storage(_cEmp, _cFil, @_cOk, @_cErro, @_cAlias, _cSolicit, @aProduto, _cUser) 

        If !Empty(_cErro)
            Return(.F.)
        Else 
            Return(.T.)
            //::SetResponse(_cOk)
        EndIf 

    EndIf 

Return(.T.)

/**************************************************************************************************
{Protheus.doc} ToBreakJson
@description	Funcao para desserializar o json  
@type   		Funcao	
@author			Lucas Rocha Vieira
@version   		1.00
@since     		22/09/2021
@database		22/09/2021
@country		Brasil
@language		PT-BR
@obs			22/09/2021 - Controle de documentacao
@param			
@return						
*****************************************************************************************************/
User function ToBreakJson(jsonObj, _cIdProd, _cQuanProd, _cObs, _cUser, _cCusto, _cEmp, _cArmazem, _cFil, _cSolicit, aProduto)
Local i, j, k
Local names
Local nG    := 1
Local lenJson
Local item
Local aJson     := {}


    lenJson := len(jsonObj)
 
    If lenJson > 0

        For i := 1 to lenJson
            U_ToBreakJson(jsonObj[i])
        Next

    Else

        names := jsonObj:Getnames()

        For i := 1 to len(names)
            item := jsonObj[names[i]]

            If ValType(item) == "C"
                Aadd(aJson,{names[i], cvaltochar(jsonObj[names[i]])})

                _cUser        := IIF(AllTrim(Lower(names[i])) == "cuser"            , AllTrim(jsonObj[names[i]]), _cUser      )
                _cEmp         := IIF(AllTrim(Lower(names[i])) == "cempresa"         , AllTrim(jsonObj[names[i]]), _cEmp       )
                _cFil         := IIF(AllTrim(Lower(names[i])) == "cfilial"          , AllTrim(jsonObj[names[i]]), _cFil       )
                _cSolicit     := IIF(AllTrim(Lower(names[i])) == "csolicitacao"     , AllTrim(jsonObj[names[i]]), _cSolicit   )    

            ElseIf  ValType(item) == "J"
                ret := oJson:GetJsonObject(names[i])
                u_PrintJson(ret, @aProduto)
            Else

                If ValType(item) == "A"

                    For j := 1 to len(item)
                        U_ToBreakJson(item[j])
                    Next j

                Endif

            Endif

        Next i

    Endif

Return(.T.)


user function PrintJson(jsonObj, aProduto)
  local i, j
  local names
  local lenJson
  local item
 
  lenJson := len(jsonObj)
 
  if lenJson > 0

    for i := 1 to lenJson
      u_PrintJson(jsonObj[i])
    next

  else

    names := jsonObj:GetNames()

    for i := 1 to len(names)

      item := jsonObj[names[i]]

      if ValType(item) == "C" .or.  ValType(item) == "N"

        Aadd(aProduto,{names[i], cvaltochar(jsonObj[names[i]])})
    
      else

        if ValType(item) == "A"

          conout("Vetor[")

          for j := 1 to len(item)

            conout("Indice " + cValtochar(j))

            if ValType(item[j]) == "J"
              u_PrintJson(item[j])
            else
              conout(cvaltochar(item[j]))
            endif

          next j

          conout("]Vetor")

        endif

      endif

    next i

  endif

return

