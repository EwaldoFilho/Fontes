#Include "RWMAKE.CH"
#Include "TBICONN.CH"
#Include "TOPCONN.CH"
#Include "PROTHEUS.CH"

/*/{Protheus.doc} GP670ARR  - Ponto de entrada que realiza a inclusão de campos que não são integrados ao financeiro quando realizado a integração de títulos.
@return		Retorno
@author		André Longhini
@version	1.0
@since		27/10/2021
@obs	
*/
User Function GP670ARR()

Local aRet := {}

aadd(aRet,{"E2_HIST",RC1->RC1_DESCRI,NIL})
aadd(aRet,{"E2_CCUSTO",RC1->RC1_CC,NIL})


Return aRet


