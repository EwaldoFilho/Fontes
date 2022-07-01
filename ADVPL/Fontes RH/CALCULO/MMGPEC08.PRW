#Include "RWMAKE.CH"
#Include "TBICONN.CH"
#Include "TOPCONN.CH"
#Include "PROTHEUS.CH"

/*/{Protheus.doc} MMGPEC08  - Fonte responsável pelo cálculo do Benefício Social Familia
@return		Retorno
@author		André Longhini
@version	1.0
@since		20/01/2022
@obs	
*/
User Function MMGPEC08()


Local pgBenS 	:= ''     	// Recebe se deverá gerar o benefício social. 1 = Sim; 2 = Não
Local nVlrBen 	:= 0		// Recebe o valor a ser gerado por colaborador. 
Local cVbBen	:= ''		// Recebe o código da verba a ser gerado. 

	DbSelectArea("RCE")
	RCE->(dbsetorder(1))    //Cadastro de Sindicatos
	RCE->(DBSEEK(xFilial("RCE")+SRA->RA_SINDICA))

		pgBenS	:= RCE-> RCE_XPGBEN  	// Busca se deverá gerar o benefício social - 1 = Sim; 2 = Não
		nVlrBen	:= RCE-> RCE_XBENSO		// Busca o valor que deverá ser gerado referente ao benefício social. 
		cVbBen	:= RCE-> RCE_XVBBEN		// Busca a verba que deverá ser gerada referente ao benefício social. 

	DBCLOSEAREA()
	RCE->(DbCloseArea())


	If pgBenS == '1'
		//Grava verba referente ao Benefício Social
		FdelPD(cVbBen)                                      // Deleta a verba, caso seja encontrada no cálculo. 
		FGeraVerba(cVbBen,nVlrBen,,,,"V","C",,,,)		// Gera verba com valor.    														
	EndIF
	
Return()
