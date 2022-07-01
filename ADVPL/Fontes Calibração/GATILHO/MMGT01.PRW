#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TOTVS.CH"

/*/{Protheus.doc} MMGT01 - Fonte responsável por gatilhar a data da próxima calibragem de equipamento.
@return		Retorno
@author		André Longhini
@version	1.0
@since		24/03/2022
@obs	
*/

User Function MMGT01()

    Local aArea := GetArea()
    Local dDataCal := M->ZZD_DTCAL  // Recebe data da última calibragem.
    Local cTpVal   := M->ZZD_VALIDA // 1 = ANUAL; 2 = SEMESTRAL; 3 = TRISMESTRAL; 4 = BIMESTRAL; 5 = MENSAL.
    Local dDataProx := 0          // Recebe data da próxima calibragem.
    Local nMonth    := 0           // Recebe a quantidade de meses para cálculo.

        If cTpVal == '1'    // Calculo Anual
                nMonth := 12
                dDataProx := MonthSum( dDataCal , nMonth )
        elseif cTpVal == '2'    // Calculo Semestral
                nMonth := 6
                dDataProx := MonthSum( dDataCal , nMonth )
        elseif cTpVal == '3'    // Calculo Trismetral
                nMonth := 3
                dDataProx := MonthSum( dDataCal , nMonth )
        elseif cTpVal == '4'    // Calculo Bimestral
                nMonth := 2
                dDataProx := MonthSum( dDataCal , nMonth )
        elseif cTpVal == '5'    // Calculo Mensal
                nMonth := 1
                dDataProx := MonthSum( dDataCal , nMonth )
        endif 
         


    RestArea(aArea)

Return dDataProx
