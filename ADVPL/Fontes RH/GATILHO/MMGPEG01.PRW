#include "parmtype.ch"
#Include "PROTHEUS.CH"

/*/{Protheus.doc} MMGPEG01  - Fonte respons�vel por gatilhar o valor do campo "RCG_XDES"
@return		Retorno
@author		Andr� Longhini
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


