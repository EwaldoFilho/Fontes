#include 'protheus.ch'
#include 'parmtype.ch'

/*/{Protheus.doc} MT120FIM

Dispara Workflow FLUIG de aprovações de Pedidos de Compra 

@author Cassiano Gonçalves Ribeiro
@since 02/06/2017
/*/

user function MT120FIM
	
	local nOpcao := PARAMIXB[1]   // Opção Escolhida pelo usuario
	local cNumPC := PARAMIXB[2]   // Numero do Pedido de Compras
	local nOpcA  := PARAMIXB[3]   // Indica se a ação foi Cancelada = 0  ou Confirmada = 1.
	
	if (SM0->M0_CODIGO == "01")
		if nOpcA == 1
			//u_WFPC(NIL,NIL)
			u_intAprovFluig(cNumPC)
		endIf
	endIf
	
return
