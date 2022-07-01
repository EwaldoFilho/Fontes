#include "parmtype.ch"
#Include "PROTHEUS.CH"

/*/{Protheus.doc} MMGPEG01  - Fonte responsável por gatilhar o valor do campo "RCG_XDES"
@return		Retorno
@author		André Longhini
@version	1.0
@since		07/02/2022
@obs	
*/
User Function MMGPEG01()

   Local cDesc := ""
   Local cData := ""

   cData := M->RCG_DIAMES     
   cDesc := cDow(cData)


Return cDesc


