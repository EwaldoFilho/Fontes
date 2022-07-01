#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TOTVS.CH"

/*/{Protheus.doc} MMGT03 - Fonte responsável por gatilhar o status. 
@return		Retorno
@author		André Longhini
@version	1.0
@since		06/05/2022
@obs	
*/

User Function MMGT03()

    Local aArea         := GetArea()
    Local dDataBase     := Date()
    Local dDataProx     := M->ZZD_DTCAL2
    Local nDias         := (DateDiffDay(dDataBase,dDataProx))
    Local nDiasAlt      := GETMV("COM_CCP01")
    Local cStatus       := ""

            

            
            // Valida se a Calibração está próxima do vencimento, conforme parâmetro
            If nDias <= nDiasAlt .and. dDataBase < dDataProx
                cStatus := "2"
            EndIF
            // Valida se a Calibração está valida. 
            If nDias > nDiasAlt
                cStatus := "1"
            EndIf
            // Valida se Calibração está vencida
            If dDataBase >= dDataProx
                cStatus := "3"
            EndIF




    RestArea(aArea)

Return cStatus
