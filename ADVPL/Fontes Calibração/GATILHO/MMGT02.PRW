#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TOTVS.CH"

/*/{Protheus.doc} MMGT02 - Fonte responsável por validar campo vázio
@return		Retorno
@author		André Longhini
@version	1.0
@since		18/04/2022
@obs	
*/

User Function MMGT02()

    Local aArea         := GetArea()
    Local cTpProd       := M->ZZD_TPPROD        // Recebe tipo do Produto
    Local cCodProd      := M->ZZD_CODPR         // Recebe dados do campo do código do produto.    
    Local cCodBem       := M->ZZD_CODATI        // Recebe dados do campo do código do Ativo.    

        If cTpProd == 'N' .and. Empty(cCodProd)
             MsgAlert("O Campo Cod do Produto encontra-se vazio!.")   
        ELSEIF cTpProd == 'S' .and. Empty(cCodBem)
            MsgAlert("O Campo Cod do Bem encontra-se vazio!.")       
        endif 
         


    RestArea(aArea)

Return 
