#Include "RWMAKE.CH"
#Include "TBICONN.CH"
#Include "TOPCONN.CH"
#Include "PROTHEUS.CH"

/*/{Protheus.doc} MMGPEC08  - Fonte respons�vel pelo c�lculo do Benef�cio Social Familia
@return		Retorno
@author		Andr� Longhini
@version	1.0
@since		20/01/2022
@obs	
*/
User Function MMGPEC08()


Local pgBenS 	:= ''     	// Recebe se dever� gerar o benef�cio social. 1 = Sim; 2 = N�o
Local nVlrBen 	:= 0		// Recebe o valor a ser gerado por colaborador. 
Local cVbBen	:= ''		// Recebe o c�digo da verba a ser gerado. 

	DbSelectArea("RCE")
	RCE->(dbsetorder(1))    //Cadastro de Sindicatos
	RCE->(DBSEEK(xFilial("RCE")+SRA->RA_SINDICA))

		pgBenS	:= RCE-> RCE_XPGBEN  	// Busca se dever� gerar o benef�cio social - 1 = Sim; 2 = N�o
		nVlrBen	:= RCE-> RCE_XBENSO		// Busca o valor que dever� ser gerado referente ao benef�cio social. 
		cVbBen	:= RCE-> RCE_XVBBEN		// Busca a verba que dever� ser gerada referente ao benef�cio social. 

	DBCLOSEAREA()
	RCE->(DbCloseArea())


	If pgBenS == '1'
		//Grava verba referente ao Benef�cio Social
		FdelPD(cVbBen)                                      // Deleta a verba, caso seja encontrada no c�lculo. 
		FGeraVerba(cVbBen,nVlrBen,,,,"V","C",,,,)		// Gera verba com valor.    														
	EndIF
	
Return()
