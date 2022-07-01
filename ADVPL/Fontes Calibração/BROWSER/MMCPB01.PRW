#INCLUDE "PROTHEUS.CH"
#INCLUDE "TBICONN.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "TOTVS.CH"

/*/{Protheus.doc} MMCPB01 - Fonte responsável por apresentar em Browser a rotina de calibragem de equipamentos;
@return		Retorno
@author		André Longhini
@version	1.0
@since		24/03/2022
@obs	
*/

User Function MMCPB01()

    Local aArea       := GetArea()
    Local cTabela     := "ZZD"
    Private aCores    := {}
    Private cCadastro := "Calibração de Equipamentos"
    Private aRotina   := {}
     
    //Montando o Array aRotina, com funções que serão mostradas no menu
    aAdd(aRotina,{"Pesquisar",  "AxPesqui", 0, 1})
    aAdd(aRotina,{"Visualizar", "AxVisual", 0, 2})
    aAdd(aRotina,{"Incluir",    "AxInclui", 0, 3})
    aAdd(aRotina,{"Alterar",    "AxAltera", 0, 4})
    aAdd(aRotina,{"Conhecimento", "MsDocument", 0, 4})
    aAdd(aRotina,{"Excluir",    "AxDeleta", 0, 5})
	aAdd(aRotina,{"Legenda",    "U_LEGCPB", 0, 5})

    //aAdd(aRotina,{"* Função A", "u_zFuncA", 0, 8})
    //aAdd(aRotina,{"* Função B", "u_zFuncB", 0, 8})
 
    //Montando as cores da legenda
    aAdd(aCores,{"ZZD_STATUS == '1' ", "BR_VERDE" })
    aAdd(aCores,{"ZZD_STATUS == '2' ", "BR_AMARELO" })
    aAdd(aCores,{"ZZD_STATUS == '3' ", "BR_VERMELHO" })
    aAdd(aCores,{"ZZD_STATUS == '4' ", "BR_CINZA" })
     
    //Selecionando a tabela e ordenando
    DbSelectArea(cTabela)
    (cTabela)->(DbSetOrder(1))
     
    //Montando o Browse
    mBrowse(6, 1, 22, 75, cTabela, , , , , , aCores )

    U_FTMSREL()
     
    //Encerrando a rotina
    (cTabela)->(DbCloseArea())
    RestArea(aArea)

Return

/*/{Protheus.doc} MMCPB01 - Fonte responsável por apresentar em Browser a rotina de calibragem de equipamentos;
@return		Retorno
@author		André Longhini
@version	1.0
@since		24/03/2022
@obs	
*/

User Function LEGCPB()

  Local aLegenda := ""
   
   aLegenda := {	{ "BR_VERDE",     	"VALIDO" 	},;
				   	{ "BR_AMARELO",    	"VERIFICAR"	},;
					{ "BR_VERMELHO",    "VENCIDO"	},;
                    { "BR_CINZA",        "BAIXADO"	}}
                 
   BRWLEGENDA( cCadastro, "Legenda", aLegenda )
   
Return .t.

/*/{Protheus.doc} FTMSREL - Fonte responsável por apresentar em Browser a rotina de calibragem de equipamentos;
@return		Retorno
@author		André Longhini
@version	1.0
@since		24/03/2022
@obs	
*/

User Function FTMSREL
    local aRotina := {}

    AADD(aRotina, { "ZZD", {"ZZD_NSERIE"}, {||ZZD->ZZD_NSERIE}})

Return aRotina
