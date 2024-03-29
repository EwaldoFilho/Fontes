#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TOTVS.CH"

/*/{Protheus.doc} MMGT04 - Fonte respons�vel por gatilhar o status. 
@return		Retorno
@author		Andr� Longhini
@version	1.0
@since		06/05/2022
@obs	
*/

User Function MMGT04()

    Local aArea         := GetArea()
    Local cBloq         := M->ZZD_MSBLQL
    Local cStatus       := ""

            
            // Valida se Calibra��o esta baixada
            If cBloq == '1'
                cStatus := "4"
            EndIF


    RestArea(aArea)

Return cStatus
