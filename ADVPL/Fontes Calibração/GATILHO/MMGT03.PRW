#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TOTVS.CH"

/*/{Protheus.doc} MMGT03 - Fonte respons�vel por gatilhar o status. 
@return		Retorno
@author		Andr� Longhini
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

            

            
            // Valida se a Calibra��o est� pr�xima do vencimento, conforme par�metro
            If nDias <= nDiasAlt .and. dDataBase < dDataProx
                cStatus := "2"
            EndIF
            // Valida se a Calibra��o est� valida. 
            If nDias > nDiasAlt
                cStatus := "1"
            EndIf
            // Valida se Calibra��o est� vencida
            If dDataBase >= dDataProx
                cStatus := "3"
            EndIF




    RestArea(aArea)

Return cStatus
