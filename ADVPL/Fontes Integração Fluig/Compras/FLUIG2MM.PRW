#include 'totvs.ch'
#include 'parmtype.ch'
#include 'topconn.ch'

#define POS_CAMPO 1
#define POS_VALOR 2


/*/{Protheus.doc} intAprovFluig

Dispara Workflow FLUIG de aprovações de Pedidos de Compra 
	
@author Cassiano Ribeiro
@since 02/06/2017
@type function

/*/

user function intAprovFluig(cPedido, cMsg)

	local aArea		:= getArea()
	local aAreaSC7	:= SC7->(getArea())
	local cOrigPc	:= ""
	local lRet		:= .F.
	
	Default cMsg := ""
	
	dbSelectArea("SC7")
	SC7->(dbSetOrder(1))
	
	if SC7->(dbSeek(xFilial("SC7")+cPedido))
		cOrigPc	:= SC7->C7_ZZORIPC			
		lRet := incluiSolicitacao(cPedido, cOrigPc, cMsg)
	else
		Conout("intAprovFluig. Nao achou pedido passado por parametro")
	endIf
	
	restArea(aAreaSC7)
	restArea(aArea)
return lRet


/*
* Função responsável pela inclusão da solicitação no FLUIG.
*/
static function fIncSolic(aCardData, cMsg)
	
	local aRet   		:= {}
	local cIdFluig  	:= ""
	local lRet   		:= .F.
	local nPos   		:= 0
	local oIntegEcm  	:= IpFluigClass():newIPFluigClass()
	local oAttachment	:= nil
	local aColleagueIds	:= nil
	local cUserFluig	:= ""
	
	oIntegEcm:getUsuario()   
	
	cUserFluig	:= oIntegEcm:getUserName()
	
	aRet := oIntegEcm:startProcess("aprovacao_pedido_compras_individual", retLoginUsuario(SC7->C7_USER), 0, "Processo iniciado pelo Protheus", aCardData,oAttachment,aColleagueIds )
	
	if !Empty(aRet)

		nPos := aScan(aRet,{ |x| x[1] == "iProcess" })

		if nPos <> 0
			cIdFluig := aRet[nPos][2]
			if cIdFluig != "false"
				lRet := .T.

				conout("----------INICIO APROVAÇÃO DE PEDIDO DE COMPRAS----------")
				conout("PROCESSO  - "+ cIdFluig)
				conout("-----------FIM APROVAÇÃO DE PEDIDO DE COMPRAS------------")
			endIf
		endIf

		if !lRet
			cMsg := "-----------ERRO NA CRIACAO DA SOLICITACAO (WEBSERVICE DO FLUIG NAO CRIOU A SOLICITAÇÃO)------------" 
			conout("-----------ERRO NA CRIACAO DA SOLICITACAO------------")
		endIf
	Else
		cMsg := "-----------ERRO NA INTEGRACAO (COMUNICAÇÃO) COM FLUIG------------" 
		conout("-----------ERRO NA INTEGRACAO (COMUNICAÇÃO) COM FLUIG------------") 
	Endif

return lRet

/*
* Função responsável pelo preenchimento dos campos do formulário
*/
static function incluiSolicitacao(cPedido, cOrigPc, cMsg)		
	local aRet		:= {}
	local cLogin	:= ""
	local aCardData	:= preencheCardData(cPedido)
	local cAprov	:= ""
	local cAliasAp	:= nil
	local lAutPag	:= .F.
	local lRet		:= .T.
		
	if !empty(aCardData)
		
		lAutPag	:= isAutorizacaoPagamento(cOrigPc)
		
		if lAutPag
			//Preenchido pelo FLUIG no evento afterTaskComplete
			aCardData	:= setValue(aCardData, "txt_aprovadorPc", "")
			f
		elseIncSolic(aCardData,cMsg)
			cAliasAp	:= consultaAprovadores(cPedido)
			
			if !(cAliasAp)->(eof())		
				cAprov		:= retLoginUsuario((cAliasAp)->CR_USER)
				aCardData	:= setValue(aCardData, "txt_aprovadorPc", cAprov)	
				aCardData	:= setValue(aCardData, "txt_registroAprovScr", cValToChar((cAliasAp)->REGSCR))												
				
				lRet := fIncSolic(aCardData,cMsg)
//				(cAliasAp)->(dbSkip())
			else
				Conout("intAprovFluig. Nao achou aprovadores")
			endIf
		
			(cAliasAp)->(dbCloseArea())
		endIf
		
	endIf
	
return lRet


/*
*	Função responsável por retornar o login do usuário logado.
*/
static function retLoginUsuario(cCodUser)
	local cLogin	:= ""
	PswOrder(1)
	PswSeek(cCodUser, .T.)
	
	cLogin	:= allTrim(PswRet()[1][2]) 
return cLogin


/*
*	Função responsável por retornar os pedidos que necessitam de aprovação
*/
static function consultaAprovadores(cNumPc)
	local cQuery	:= ""
	local cAlias	:= getNextAlias()
	local cAprov	:= ""
	
	cQuery	:=	"SELECT TOP 1 "										+ CRLF
	cQuery	+=	"	SCR.CR_USER,"									+ CRLF
	cQuery	+=	"	SCR.CR_FLUIG,"									+ CRLF
	cQuery	+=	"	SCR.R_E_C_N_O_ AS REGSCR"						+ CRLF
	cQuery	+=	"FROM "												+ CRLF
	cQuery	+=	"	"				+ RetSqlName("SCR")	+ " SCR "	+ CRLF
	cQuery	+=	"WHERE "											+ CRLF
	cQuery	+=	"	SCR.CR_FILIAL = '"	+ xFilial("SCR")+ "'  "		+ CRLF
	cQuery	+=	"	AND SCR.CR_TIPO = 'PC' "						+ CRLF
	cQuery	+=	"	AND SCR.CR_DATALIB = ' ' "						+ CRLF
	cQuery	+=	"	AND SCR.CR_FLUIG = ' ' "						+ CRLF
	cQuery	+=	"	AND SCR.CR_NUM = '"+cNumPc+"' "					+ CRLF	
	cQuery	+=	"	AND SCR.D_E_L_E_T_ = ' ' "						+ CRLF
	cQuery	+=	"ORDER BY "											+ CRLF
	cQuery	+=	"	CR_NIVEL, CR_NUM, CR_USER "						+ CRLF

	cQuery := ChangeQuery(cQuery)
	
	TcQuery cQuery New Alias &cAlias
	
return	cAlias


/*
*	Função responsável por retornar os itens do pedido.
*/
static function retornaItensPc(cPedido)
	local cQuery	:= ""
	local cAlias	:= getNextAlias()
	
	cQuery	:=	"SELECT " + CRLF
	cQuery	+=	"	C7_FILIAL," + CRLF 
	cQuery	+=	"	C7_NUM," + CRLF 
	cQuery	+=	"	C7_FORNECE," + CRLF 
	cQuery	+=	"	C7_LOJA," + CRLF 
	cQuery	+=	"	C7_COND," + CRLF
	cQuery	+=	"	A2_NOME," + CRLF 
	cQuery	+=	"	E4_DESCRI," + CRLF 
	cQuery	+=	"	CTT_DESC01," + CRLF 
	cQuery	+=	"	C7_VALFRE," + CRLF 
	cQuery	+=	"	C7_PRECO," + CRLF 
	cQuery	+=	"	C7_VLDESC," + CRLF
	cQuery	+=	"	C7_TOTAL," + CRLF 
	cQuery	+=	"	C7_TPFRETE," + CRLF
	cQuery	+=	"	C7_DESPESA," + CRLF 
	cQuery	+=	"	C7_OBS," + CRLF
	cQuery	+=	"	C7_PRODUTO," + CRLF 
	cQuery	+=	"	C7_DESCRI," + CRLF 
	cQuery	+=	"	C7_UM," + CRLF 
	cQuery	+=	"	C7_QUANT," + CRLF
	cQuery	+=	"	C7_CC," + CRLF
	cQuery	+=	"	C7_ZZORIPC," + CRLF
	cQuery	+=	"	Y1_NOME," + CRLF
	cQuery	+=	"	Y1_EMAIL," + CRLF
	cQuery	+=	"	B1_UPRC" + CRLF  	
	cQuery	+=	"FROM " + retSqlTab("SC7") + CRLF
	cQuery	+=	"LEFT JOIN " + retSqlTab("SE4") + CRLF 
	cQuery	+=	"	 ON SE4.E4_FILIAL = '"+xFilial("SE4")+"' " + CRLF
	cQuery	+=	"	 AND SE4.E4_CODIGO = C7_COND " + CRLF
	cQuery	+=	"	 AND SE4.D_E_L_E_T_ = '' " + CRLF  
	cQuery	+=	"LEFT JOIN " + retSqlTab("SY1") + CRLF 
	cQuery	+=	"	 ON SY1.Y1_FILIAL = '"+xFilial("SY1")+"' " + CRLF
	cQuery	+=	"	 AND SY1.Y1_USER = C7_USER " + CRLF
	cQuery	+=	"	 AND SY1.D_E_L_E_T_ = '' " + CRLF  
	cQuery	+=	"INNER JOIN " + retSqlTab("SA2") + CRLF
	cQuery	+=	"	 ON SA2.A2_FILIAL = '"+xFilial("SA2")+"' " + CRLF
	cQuery	+=	"	 AND SA2.A2_COD = C7_FORNECE " + CRLF
	cQuery	+=	"	 AND SA2.A2_LOJA = C7_LOJA " + CRLF
	cQuery	+=	"	 AND SA2.D_E_L_E_T_ = '' " + CRLF		 
	cQuery	+=	"LEFT JOIN " + retSqlTab("CTT") + CRLF
	cQuery	+=	"	 ON CTT.CTT_FILIAL = '"+xFilial("CTT")+"' " + CRLF 
	cQuery	+=	"	 AND CTT.CTT_CUSTO = C7_CC " + CRLF
	cQuery	+=	"	 AND CTT.D_E_L_E_T_ = '' " + CRLF	
	cQuery	+=	"INNER JOIN " + retSqlTab("SB1") + CRLF
	cQuery	+=	"	 ON SB1.B1_FILIAL = '"+xFilial("SB1")+"' " + CRLF
	cQuery	+=	"	 AND SB1.B1_COD = C7_PRODUTO " + CRLF
	cQuery	+=	"	 AND SB1.D_E_L_E_T_ = '' " + CRLF	
	cQuery	+=	"WHERE " + CRLF	
	cQuery	+=	"	 SC7.C7_FILIAL = '"+xFilial("SC7")+"' " + CRLF
	cQuery	+=	"	 AND SC7.C7_NUM = '"+cPedido+"' " + CRLF
	cQuery	+=	"	 AND SC7.D_E_L_E_T_ = ' ' " + CRLF	
	
	cQuery := ChangeQuery(cQuery)
	
	TcQuery cQuery New Alias &cAlias
	
return cAlias


/*
*	Função responsável por preencher o array cardData da solicitação.
*/
static function preencheCardData(cPedido)
	local aCardData		:= {}
	local nCnt			:= 0
	local cId			:= ""
	local cLogin		:= ""
	local cNomeFilial	:= ""
	local nTotal		:= 0
	local lCabec		:= .F.
	local cAliasPc		:= retornaItensPc(cPedido)
	
	if (cAliasPc)->(!eof())	
		while (cAliasPc)->(!eof())
			nCnt++					
			cId := cValToChar(nCnt)
			
			if !lCabec
				cNomeFilial	:= FWFilialName(cEmpAnt,(cAliasPc)->C7_FILIAL,2)
				
				aADD(aCardData,{"txt_origemSolicitacao"     ,alltrim((cAliasPc)->C7_ZZORIPC)})
				
				aADD(aCardData,{"txt_filialAprovadorPc"     ,(cAliasPc)->C7_FILIAL			})
				aADD(aCardData,{"txt_empresaAprovadorPc"    ,cEmpAnt						})
				
				aADD(aCardData,{"dt_dataSolicitacao"    	,DTOC(dDataBase)				})
				aADD(aCardData,{"txt_horaSolicitacao"    	,time()							})
				aADD(aCardData,{"txt_descFilial"    	 	,cNomeFilial					})
				
				aADD(aCardData,{"txt_aprovadorPc"      		,""								})
				aADD(aCardData,{"txt_registroAprovScr"      ,"" 	 						})
					
				aADD(aCardData,{"txt_codFilial"   			,(cAliasPc)->C7_FILIAL				})
				aADD(aCardData,{"txt_nomeFornecedor"    	,alltrim((cAliasPc)->C7_FORNECE)	})
				aADD(aCardData,{"txt_codFornecedor"    		,alltrim((cAliasPc)->A2_NOME)		})				
				aADD(aCardData,{"txt_lojaFornecedor"    	,alltrim((cAliasPc)->C7_LOJA)		})
				aADD(aCardData,{"txt_codCondicaoPagamento"  ,alltrim((cAliasPc)->C7_COND)		})
				aADD(aCardData,{"txt_descCondPagamento"     ,alltrim((cAliasPc)->E4_DESCRI)		})
				aADD(aCardData,{"vl_valorFrete"    			,alltrim(cValToChar((cAliasPc)->C7_VALFRE))})
				aADD(aCardData,{"txt_tipoFrete"    			,alltrim((cAliasPc)->C7_TPFRETE)	})
				aADD(aCardData,{"vl_valorDespesas"    		,alltrim(cValToChar((cAliasPc)->C7_DESPESA))})
				aADD(aCardData,{"txt_numPedidoCompras"      ,alltrim((cAliasPc)->C7_NUM)		})
				aADD(aCardData,{"txt_nomeComprador"      	,alltrim((cAliasPc)->Y1_NOME)		})
				aADD(aCardData,{"txt_emailComprador"      	,alltrim((cAliasPc)->Y1_EMAIL)		})
				lCabec	:= .T.				
			endIf
						
					
			aADD(aCardData,{"txt_codProduto___" 		+ cId, alltrim((cAliasPc)->C7_PRODUTO)				})
			aADD(aCardData,{"txt_descProduto___" 		+ cId, alltrim((cAliasPc)->C7_DESCRI)  				})
			aADD(aCardData,{"txt_unidadeMedida___" 		+ cId, (cAliasPc)->C7_UM  							})
			aADD(aCardData,{"vl_quantidadeProduto___" 	+ cId, alltrim(cValToChar((cAliasPc)->C7_QUANT))  	})
			aADD(aCardData,{"vl_precoUnitario___" 		+ cId, alltrim(cValToChar((cAliasPc)->C7_PRECO))  	})
			aADD(aCardData,{"vl_ultimoPrecoCompra___"	+ cId, alltrim(cValToChar((cAliasPc)->B1_UPRC))  	})
			aADD(aCardData,{"vl_desconto___" 			+ cId, alltrim(cValToChar((cAliasPc)->C7_VLDESC))  	})
			aADD(aCardData,{"vl_valorTotal___" 			+ cId, alltrim(cValToChar((cAliasPc)->C7_TOTAL))  	})
			aADD(aCardData,{"txt_observacao___" 		+ cId, alltrim((cAliasPc)->C7_OBS)					})
			aADD(aCardData,{"txt_codCentroCusto___" 	+ cId, alltrim((cAliasPc)->C7_CC) 					})
			aADD(aCardData,{"txt_descCentroCusto___" 	+ cId, alltrim((cAliasPc)->CTT_DESC01)				})
			
			nTotal += (cAliasPc)->C7_TOTAL
					
			(cAliasPc)->(dbSkip())
		endDo
		
		aADD(aCardData,{"vl_totalPedido" ,alltrim(cValToChar(nTotal))})		
		
		nTotal	:= 0
	endIf
	
	(cAliasPc)->(dbCloseArea())
return aCardData


/*
*	Função responsável por alterar o valor e um campo do array aCardData
*/
static function setValue(aCardData, cCampo, xValor)
	local nPos	:= aScan( aCardData, { |x| AllTrim( x[POS_CAMPO]) == alltrim(cCampo) } )
	aCardData[nPos][POS_VALOR]	:= xValor
return aCardData


/*
*	Função responsável por verificar se a solicitação foi gerada pelo processo de autorização de pagamento.
*/
static function isAutorizacaoPagamento(cOrigPc)
	local lRet	:= .F.
	
	if alltrim(cOrigPc) == "AUTPAG"
		lRet	:= .T.
	endIf

return lRet
