#INCLUDE "RWMAKE.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "FWMVCDEF.CH"
#INCLUDE "PROTHEUS.CH"
/*/{Protheus.doc} SIGAGPE
Ponto de entrada para adicionar itens no aRotina da tela de C�lculo de F�rias
@param		Nenhum
@return		Nenhum
@author 	Andr� Longhini
@since 		21/10/2021
@version 	1.0
@Obs		
/*/
User Function GP030MNU()


	ADD OPTION aRotina TITLE "Imprimir F�rias" ACTION 'U_MMGPER02' OPERATION 6 ACCESS 0



Return()
