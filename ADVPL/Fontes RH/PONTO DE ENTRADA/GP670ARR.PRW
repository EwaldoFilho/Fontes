#Include "RWMAKE.CH"
#Include "TBICONN.CH"
#Include "TOPCONN.CH"
#Include "PROTHEUS.CH"

/*/{Protheus.doc} GP670ARR  - Ponto de entrada que realiza a inclus�o de campos que n�o s�o integrados ao financeiro quando realizado a integra��o de t�tulos.
@return		Retorno
@author		Andr� Longhini
@version	1.0
@since		27/10/2021
@obs	
*/
User Function GP670ARR()

Local aRet := {}

aadd(aRet,{"E2_HIST",RC1->RC1_DESCRI,NIL})
aadd(aRet,{"E2_CCUSTO",RC1->RC1_CC,NIL})


Return aRet


