#Include "RWMAKE.CH"
#Include "TBICONN.CH"
#Include "TOPCONN.CH"
#Include "PROTHEUS.CH"

/*/{Protheus.doc} MEDMGPEC04  - Fonte responsável pelo exclusão do DSR dos horistas. 
@return		Retorno
@author		André Longhini
@version	1.0
@since		30/10/2021
@obs	
*/
User Function MMGPEC04()

Local cPd0033	:= 0	//Recebe o código de verba que contem o ID 0035
Local nVlr0033	:= 0	//Recebe o valor da verba que contem o ID 0035																						



    // Obtem verbas
	cPd0033		:= aCodFol[0033,1]      // Verba DSR dos Horistas
						
	// Obtem valor das verbas
	nVlr0033	:= fBuscaPD(cPd0033) 	// Obetem o valor da verba DSR dos Horistas

    //Regrava pagamento do VT com valor correto
	iF nVlr0033 > 0 
		FdelPD(cPd0033)                                                     // Deleta a verba, caso seja encontrada no cálculo. 
	Endif

Return()
