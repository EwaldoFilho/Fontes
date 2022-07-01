#INCLUDE "PROTHEUS.CH"
#INCLUDE "APWIZARD.CH"
#INCLUDE "TBICONN.CH"


/*/{Protheus.doc} MMGPE21A
Geração do arquivo de integração ALELO
/*/
User Function MMGPE21A()

Local cCadastro 	:= "Exportação ALELO"
Local bProcesso 	:= {|oSelf| MDM002(oSelf)}
Local cDescricao 	:= "Este programa exporta os arquivos para a ALELO"
Private cPerg		    := "MMGPE21"
//Criacao das perguntas
MDM001()

//Chamada das perguntas
Pergunte(cPerg,.F.)

tNewProcess():New( "MMGPE21" , cCadastro , bProcesso , cDescricao , cPerg, , , , ,.T.,.T.  )

Return()

/*/{Protheus.doc} MDM002
Geração do arquivo de integração ALELO
/*/
Static Function MDM002(oSelf)

Local nCountReg 	:= 0
Local cTipo			:= ""
Private p_aLstCusto := {}

Private cAliasAT	:= GetNextAlias()

nCountReg := MDM003()

If nCountReg > 0 //Verificação dos dados

	If MV_PAR01 == 1 //Vale Alimentacao
		cTipo := "VALE ALIMENTACAO"
	ElseIf MV_PAR01 == 2 //Vale Refeicao
		cTipo := "VALE REFEICAO"
	ElseIf MV_PAR01 == 3 //Vale Natal
		cTipo := "VALE NATAL"
	EndIf

	oSelf:SetRegua1(nCountReg)

	oSelf:SaveLog( "Exportação da ALELO"+" - "+ cTipo + " - "+"Inicio do processamento")

	MDM004(oSelf) //Processamento da rotina

	oSelf:SaveLog( "Exportação da ALELO"+" - "+ cTipo + " - "+"Final do processamento")

Else
	MsgInfo("Não há dados para o processamentos")
EndIf

If Select(cAliasAT) > 0
	(cAliasAT)->(DbCloseArea())
EndIf

Return()


/*/{Protheus.doc} MDM003
Geração do arquivo de integração ALELO
/*/
Static Function MDM003()

Local cAliasTMP 	:= GetNextAlias()
Local nRet			:= 0
Local cDemitido 	:= "%(SRA.RA_SITFOLH = 'D' AND SRA.RA_DEMISSA = '')%"


BeginSql alias cAliasTMP
	SELECT COUNT(*) as NROREG
	FROM %table:SRA% SRA
	WHERE  LEFT(RA_FILIAL,2) = LEFT(%exp:xFilial("SRA")%,2)
	AND SRA.RA_MAT BETWEEN %exp:MV_PAR02% AND %exp:MV_PAR03%
	AND SRA.RA_CC BETWEEN %exp:MV_PAR10% AND %exp:MV_PAR11%
	AND (SRA.RA_SITFOLH <> 'D' OR %exp:cDemitido%) AND SRA.RA_CATFUNC <> 'A'
	AND SRA.%notDel%
EndSql

While (cAliasTMP)->( !Eof() )
	nRet += (cAliasTMP)->(NROREG)
	(cAliasTMP)->(Dbskip())
Enddo

(cAliasTMP)->(DbCloseArea())

Return(nRet)

/*/{Protheus.doc} MDM004
Geração do arquivo de integração ALELO
/*/
Static Function MDM004(oSelf)

Local cTipo			:= ""
Local cPath 		:= ""
Local cArq			:= ""
Local cQbraCc		:= ""

Private cAliasSRA 	:= GetNextAlias()
Private nCntReg		:= 2
Private nCntReg5	:= 0
Private nValreg5	:= 0
Private aInfoE		:= {}
Private dDataRef		:= MV_PAR04
Private nHdl


//Local do arquivo
cPath 	:= AllTrim(MV_PAR05)
cPath	:= Iif(Right(cPath,1)=="\",cPath,cPath+"\")
// Nome do arquivo
cArq	:= Alltrim(MV_PAR06)

// Cria o arquivo
nHdl 	:= FCreate( cPath + cArq )

//Verifica se o arquivo foi criado
If nHdl == -1
	MsgAlert('O arquivo '+AllTrim(cPath + cArq)+' nAo pOde ser criado! Verifique os parametros.','Atencao!')
	oSelf:SaveLog( "Exportação da ALELO"+" - "+"Erro na criacao do arquivo")
	Return()
Endif

//Adiciona dados da empresa
Aadd(aInfoE,SM0->M0_NOME)
Aadd(aInfoE,SM0->M0_NOMECOM)
Aadd(aInfoE,SM0->M0_CGC)
Aadd(aInfoE,SM0->M0_ENDENT)
Aadd(aInfoE,SM0->M0_COMPENT)
Aadd(aInfoE,SM0->M0_BAIRENT)
Aadd(aInfoE,SM0->M0_CIDENT)
Aadd(aInfoE,SM0->M0_ESTENT)
Aadd(aInfoE,SM0->M0_CEPENT)
Aadd(aInfoE,SM0->M0_TEL)
Aadd(aInfoE,SM0->M0_CODFIL)
Aadd(aInfoE,SM0->M0_FILIAL)
Aadd(aInfoE,SM0->M0_CODFIL)

//0=Vale Transporte;1=Vale Refeicao;2=Vale Alimentacao
If MV_PAR01 == 1 //Vale Alimentacao
	cTipo := "2"
ElseIf MV_PAR01 == 2 //Vale Refeicao
	cTipo := "1"
ElseIf MV_PAR01 == 3 //Vale Natal
	cTipo := "4"
EndIf


//Header do Arquivo
REGI_0()

//Registro Filial
REGI_1()


	IF MV_PAR01 == 3
	
		BeginSql alias cAliasSRA
		
			select	 RA_FILIAL
					,RA_MAT
					,RA_CC
					,CTT_DESC01
					,RA_CIC
					,RA_NOME
					,RA_NASC
			FROM
				%table:SRA% SRA
				LEFT JOIN %table:SR8% SR8 ON SRA.RA_MAT = SR8.R8_MAT AND SRA.RA_FILIAL = SR8.R8_FILIAL AND R8_DATAFIM = '' AND SR8.D_E_L_E_T_ = ''
				INNER JOIN %table:CTT% CTT ON( CTT_FILIAL = %exp:xFilial("CTT")% AND CTT_CUSTO = RA_CC AND CTT.D_E_L_E_T_ = '' )
			WHERE 
				LEFT(RA_FILIAL,2) = LEFT(%exp:xFilial("SRA")%,2)
				AND RA_MAT BETWEEN %exp:MV_PAR02% AND %exp:MV_PAR03%		
				AND SRA.D_E_L_E_T_ = ''
				AND SRA.RA_DEMISSA = ''
				AND SRA.RA_CC BETWEEN %exp:MV_PAR10% AND %exp:MV_PAR11%
				AND SRA.RA_SITFOLH <> 'D'
				AND SRA.RA_CATFUNC <> 'A'
				AND SRA.RA_PROCES = '00001'
				AND COALESCE(R8_DATAINI,'') = ''
	
		EndSql
		
	ELSE
	
		BeginSql alias cAliasSRA
		
			SELECT
				RA_FILIAL
				,RA_MAT
				,RA_CC
				,CTT_DESC01
				,RA_CIC
				,RA_NOME
				,RA_NASC
				,R0_TPVALE
				,SUM(R0_VALCAL) AS R0_VALCAL
			FROM
				%table:SRA% SRA
				INNER JOIN %table:SR0% SR0
					ON(
						R0_FILIAL = RA_FILIAL AND R0_MAT = RA_MAT
						AND SR0.D_E_L_E_T_ = ''
						AND R0_QDIACAL > 0
						AND R0_TPVALE = %exp:cTipo%
					  )
				INNER JOIN %table:CTT% CTT
					ON(
						CTT_FILIAL = %exp:xFilial("CTT")%
						AND CTT_CUSTO = RA_CC AND CTT.D_E_L_E_T_ = ''
					  )
			WHERE
				LEFT(RA_FILIAL,2) = LEFT(%exp:xFilial("SRA")%,2)
				//RA_FILIAL BETWEEN %exp:MV_PAR03% AND %exp:MV_PAR04%
				AND RA_MAT BETWEEN %exp:MV_PAR02% AND %exp:MV_PAR03%
				AND RA_CC BETWEEN  %exp:MV_PAR10% AND %exp:MV_PAR11%
				AND (RA_SITFOLH <> 'D' OR (RA_SITFOLH = 'D' AND RA_DEMISSA = '') )
				AND RA_CATFUNC <> 'A'
				AND SRA.%notDel%
			GROUP BY
				RA_FILIAL
				,RA_MAT
				,RA_CC
				,CTT_DESC01
				,RA_CIC
				,RA_NOME
				,RA_NASC
				,R0_TPVALE

			ORDER BY
				RA_CC
				,RA_FILIAL
				,RA_MAT

		EndSql
		
	ENDIF


While (cAliasSRA)->( !Eof() )


	//Aborta o Processamento
	If oSelf:lEnd
		oSelf:SaveLog( "Exportação da ALELO"+" - "+"Abortado pelo usuario")
		Break
	EndIf

	oSelf:IncRegua1("Exportando o funcionário: "+(cAliasSRA)->RA_FILIAL+" - "+(cAliasSRA)->RA_MAT+" - "+(cAliasSRA)->RA_NOME)

	If cQbraCc <> (cAliasSRA)->RA_CC
		//Registro area funcional
		REGI_2()
		cQbraCc := (cAliasSRA)->RA_CC

	EndIf

	//REGISTRO DE USUÁRIOS (FUNCIONÁRIOS)

//	If MV_PAR01 == 3	//Vale Natal
//		REGI_4()
//	Else
		REGI_5()
//	Endif

	(cAliasSRA)->(Dbskip())

Enddo
(cAliasSRA)->(DbCloseArea())

//REGISTRO TRAILLER
REGI_9()

// Fecha arquivo
fClose(nHdl)

Return()

/*/{Protheus.doc} REGI_0
Geração do Header do Arquivo Alelo
/*/
Static Function REGI_0()

Local cTexto := ""
Local cTipo := ""

	If MV_PAR01 == 1 //Vale Alimentacao
		cTipo := "1"
	ElseIf MV_PAR01 == 2 //Vale Refeicao
		cTipo := "2"
	ElseIf MV_PAR01 == 3 //Vale Natal
		cTipo := "4"	
	EndIf

										// INI - TAM
	cTexto := "0"                      		// 001 - 001 -> Tipo de registro. Fixo 0 = HEADER
	cTexto += GravaData(dDataBase,.F.,5 )  	// 002 - 008 -> Data do pedido (DDMMAAAA)
	cTexto += "A001"          				// 010 - 004 -> Canal de Entrada (A001)
	cTexto += Left(aInfoE[2],35)          	// 014 - 035 -> Nome da Razão Social da Empresa
	cTexto += Left(aInfoE[3],14)			// 049 - 014 -> CNPJ
	cTexto += fGerZero(11,"0")				// 063 - 011 -> CPF do Cliente Autônomo
	cTexto += PadL(Alltrim(MV_PAR08),11,"") // 074 - 011 -> Número do Contrato.
	cTexto += fGerZero(6,"0")				// 085 - 006 -> Número do Pedido do Cliente
	cTexto += GravaData(mv_par07,.F.,5)     // 091 - 008 -> Data de Efetivação do Benefício (DDMMAAAA)
	cTexto += cTipo                    		// 099 - 001 -> 1 = AVV 2= RVV 3= CVV 4= NVV 5= FVV
	cTexto += "1"                      		// 100 - 001 -> 1 = Pedido Normal / 2 = Pedido Complementar
	cTexto += Right(GravaData(dDataRef,.F.,5 ),6)  	// 102 - 006 -> Mês de Competência do Benefício (MMAAAA)
	cTexto += Space(18)                    	// 107 - 018 ->Reservado para uso livre dos Clientes
	cTexto += "007"          				// 125 - 003 -> Versão do layout. Fixo: 7 para este layout
	cTexto += Space(267)                    // 128 - 267 -> Brancos
	cTexto += "000001"                    	// 395 - 006 -> Número seqüencial do registro
	cTexto += CRLF

	fGravaReg(AllTrim(cTexto))

Return()



/*/{Protheus.doc} REGI_1
REGISTRO FILIAL OU POSTO DE PESSOA JURÍDICA
@author André Longhini

/*/
Static Function REGI_1()

Local cTexto := ""

														// INI - TAM
	cTexto := "1"                                       // 001 - 001 -> Tipo de Registro
	cTexto += fGerStr(14,aInfoE[3])						// 002 - 014 -> CNPJ
	cTexto += fGerZero(10,"0")				            // 016 - 010 -> Código de Pessoa Jurídica ALELO da Filial
	cTexto += fGerStr(35,aInfoE[12])          			// 026 - 035 -> Nome da filial
	cTexto += fGerZero(4,"0")				            // 061 - 004 -> DDD dos Interlocutores de Entrega

	cTexto += fGerStr(35,'JESSICA MIRIAM')		// 065 - 035 -> Nome do Primeiro Interlocutor de Entrega
	cTexto += fGerStr(40,'')		          			// 100 - 040 -> Endereço de Localização Interna do Primeiro Interlocutor
	cTexto += fGerZero(12,"0")				            // 140 - 012 -> Telefone do Primeiro Interlocutor de Entrega
	cTexto += fGerZero(6,"0")				            // 152 - 006 -> Ramal do Primeiro Interlocutor de Entrega

	cTexto += fGerStr(35,'')		          			// 158 - 035 -> Nome do Segundo Interlocutor de Entrega
	cTexto += fGerStr(40,'')		          			// 193 - 040 -> Endereço de Localização Interna do segundo Interlocutor
	cTexto += fGerZero(12,"0")				            // 233 - 012 -> Telefone do segundo Interlocutor de Entrega
	cTexto += fGerZero(6,"0")				            // 245 - 006 -> Ramal do segundo Interlocutor de Entrega

	cTexto += fGerStr(35,'')		          			// 251 - 035 -> Nome do Primeiro Interlocutor de Entrega
	cTexto += fGerStr(40,'')		          			// 286 - 040 -> Endereço de Localização Interna do Primeiro Interlocutor
	cTexto += fGerZero(12,"0")				            // 326 - 012 -> Telefone do Primeiro Interlocutor de Entrega
	cTexto += fGerZero(6,"0")				            // 338 - 006 -> Ramal do Primeiro Interlocutor de Entrega
	cTexto += fGerStr(20,''/*aInfoE[13]*/)                    // 344 - 020 -> Código da Filial
	cTexto += fGerStr(31,'')		                    // 364 - 031 -> Espeços em brancos
	cTexto += "000002"                    				// 395 - 006 -> Número seqüencial do registro
	cTexto += CRLF

	fGravaReg(AllTrim(cTexto))

Return()

/*/{Protheus.doc} REGI_2
REGISTRO DE ÁREA FUNCIONAL/Centro de custo
/*/

Static Function REGI_2()

Local cTexto := ""

	nCntReg ++
													// INI - TAM
	cTexto := "2"                     				// 001 - 001 -> Tipo de registro. Fixo 2 = Área Funcional
	cTexto += Space(20)               				// 002 - 020 -> Nome da Diretoria
	cTexto += fGerStr(20,'')						// 022 - 020 -> Nome do Departamento
	cTexto += fGerStr(20,(cAliasSRA)->RA_CC)		// 042 - 020 -> Código da Área Funcional - CENTRO CUSTO
	cTexto += fGerStr(20,(cAliasSRA)->CTT_DESC01)	// 062 - 020 -> Nome da Área Funcional - CENTRRO DE CUSTO
	cTexto += fGerStr(40,'')						// 082 - 040 -> Localização Interna da Área Funcional
	cTexto += fGerZero(4,"0")				        // 122 - 004 -> DDD dos Interlocutores de Entrega
	cTexto += fGerStr(35,'JESSICA MIRIAM')	// 126 - 035 -> Nome do Primeiro Interlocutor de Entrega
	cTexto += fGerZero(12,"0")				        // 161 - 012 -> Telefone do Primeiro Interlocutor de Entrega
	cTexto += fGerZero(6,"0")				        // 173 - 006 -> Ramal do Primeiro Interlocutor de Entrega
	cTexto += fGerStr(35,'')						// 179 - 035 -> Nome do Primeiro Interlocutor de Entrega
	cTexto += fGerZero(12,"0")				        // 214 - 012 -> Telefone do Primeiro Interlocutor de Entrega
	cTexto += fGerZero(6,"0")				        // 226 - 006 -> Ramal do Primeiro Interlocutor de Entrega
	cTexto += fGerStr(163,'')		                // 232 - 163 -> Espeços em brancos
	cTexto += fGerZero(6,Str(nCntReg))              // 395 - 006 -> Número seqüencial do registro
	cTexto += CRLF

	fGravaReg(AllTrim(cTexto))

Return()


/*/{Protheus.doc} REGI_4
REGISTRO DE USUÁRIOS (FUNCIONÁRIOS)
/*/

Static Function REGI_4()

Local cTexto := ""
Local cValBene :=  StrZero(Round(MV_PAR09*100,2),11)
Local dDatBene := Stod((cAliasSRA)->RA_NASC)

	nCntReg++
	nCntReg5 ++
	nValreg5 += MV_PAR09
												// INI - TAM
	cTexto := "5"               				// 001 - 001 -> Tipo do Produto
	cTexto += cValBene							// 002 - 011 -> Valor mensal do benefício (inclui 2 casas decimais), sem pontos ou virgulas
	cTexto += " "								// 013 - 001 -> Espaço Reservado
	cTexto += fGerStr(13,(cAliasSRA)->RA_MAT)	// 014 - 001 -> Matrícula do Funcionário
	cTexto += fGerStr(54,"")					// 027 - 054 -> Espaço Reservado
	cTexto += GravaData(dDatBene,.F.,5)     	// 081 - 008 -> Data de Nascimento (DDMMAAAA)
	cTexto += fGerZero(11,(cAliasSRA)->RA_CIC)  // 089 - 011 -> Número do CPF
	cTexto += fGerStr(1,"")						// 100 - 001 -> Tipo do Doc. ID
	cTexto += fGerStr(13,"")					// 101 - 013 -> Número do Doc. ID
	cTexto += fGerStr(20,"")					// 114 - 020 -> Órgão Emissor do Doc. ID
	cTexto += fGerStr(6,"")						// 134 - 006 -> Sigla do Estado Emissor do Doc.ID
	cTexto += fGerZero(15,"")					// 140 - 015 -> Número do PIS
	cTexto += " "								// 155 - 001 -> Cód. Sexo
	cTexto += "0"								// 156 - 001 -> Cód. Estado Civil
	cTexto += fGerStr(35,"")					// 157 - 035 -> Tipo e Nome do Logradouro da Residência
	cTexto += fGerStr(10,"")					// 192 - 010 -> Complemento do Endereço da Residência
	cTexto += fGerZero(05,"")					// 202 - 005 -> Número do Logradouro da Residência
	cTexto += fGerZero(08,"")					// 207 - 008 -> CEP Residencial
	cTexto += fGerStr(28,"")					// 215 - 028 -> Município da Residência
	cTexto += fGerStr(30,"")					// 243 - 030 -> Bairro da Residência
	cTexto += fGerStr(02,"")					// 273 - 002 -> Sigla do Estado da Residência
	cTexto += fGerStr(35,"")					// 275 - 035 -> Nome da Mãe
	cTexto += fGerStr(01,"")					// 310 - 001 -> Cód. Opção Ender. Correspondência:  R = Residencial   C = Comercial
	cTexto += fGerZero(04,"")					// 311 - 004 -> Cód. DDD Comercial (obrigatório, se o número de telefone presente)
	cTexto += fGerZero(08,"")					// 315 - 008 -> Num. Telefone Comercial
	cTexto += fGerZero(04,"")					// 323 - 004 -> Num . Ramal Comercial
	cTexto += fGerZero(04,"")					// 327 - 004 -> Cód. DDD Residencial (obrigatório, se o número de telefone presente)
	cTexto += fGerZero(08,"")					// 331 - 008 -> Num. Telefone Residencial
	cTexto += fGerStr(01,"")					// 339 - 001 -> Cód. Escolaridade
	cTexto += fGerZero(08,"")					// 340 - 008 -> Data de Admissão (DDMMAAAA)
	cTexto += " "								// 348 - 001 -> Espaço Reservado
	cTexto += fGerStr(40,(cAliasSRA)->RA_NOME)	// 349 - 040 -> Nome do Usuário
	cTexto += "      "							// 389 - 006 -> Espaço Reservado
	cTexto += fGerZero(6,Str(nCntReg))          // 395 - 006 -> Número seqüencial do registro
	cTexto += CRLF

	fGravaReg(AllTrim(cTexto))

Return()



/*/{Protheus.doc} REGI_5
REGISTRO DE USUÁRIOS (FUNCIONÁRIOS)
/*/

Static Function REGI_5()
Local nValbenef := if(MV_PAR01==3,MV_PAR09,(cAliasSRA)->R0_VALCAL)
Local cTexto := ""
Local cValBene :=  StrZero(Round(nValbenef*100,2),11)
Local dDatBene := Stod((cAliasSRA)->RA_NASC)
//usada histórico
Local cFilHist := PadR((cAliasSRA)->RA_FILIAL,TamSx3("RG2_FILIAL")[1]) 
Local cMatHist := PadR((cAliasSRA)->RA_MAT,TamSx3("RG2_MAT")[1]) 
Local cPerHist := Left(Dtos(MV_PAR04),4)+"12"
Local lIncHist := .T.

	nCntReg++
	nCntReg5 ++
	nValreg5 += nValbenef
												// INI - TAM
	cTexto := "5"               				// 001 - 001 -> Tipo do Produto
	cTexto += cValBene							// 002 - 011 -> Valor mensal do benefício (inclui 2 casas decimais), sem pontos ou virgulas
	cTexto += " "								// 013 - 001 -> Espaço Reservado
	cTexto += fGerStr(13,(cAliasSRA)->RA_MAT)	// 014 - 001 -> Matrícula do Funcionário
	cTexto += fGerStr(54,"")					// 027 - 054 -> Espaço Reservado
	cTexto += GravaData(dDatBene,.F.,5)     	// 081 - 008 -> Data de Nascimento (DDMMAAAA)
	cTexto += fGerZero(11,(cAliasSRA)->RA_CIC)  // 089 - 011 -> Número do CPF
	cTexto += fGerStr(1,"")						// 100 - 001 -> Tipo do Doc. ID
	cTexto += fGerStr(13,"")					// 101 - 013 -> Número do Doc. ID
	cTexto += fGerStr(20,"")					// 114 - 020 -> Órgão Emissor do Doc. ID
	cTexto += fGerStr(6,"")						// 134 - 006 -> Sigla do Estado Emissor do Doc.ID
	cTexto += fGerZero(15,"")					// 140 - 015 -> Número do PIS
	cTexto += " "								// 155 - 001 -> Cód. Sexo
	cTexto += "0"								// 156 - 001 -> Cód. Estado Civil
	cTexto += fGerStr(35,"")					// 157 - 035 -> Tipo e Nome do Logradouro da Residência
	cTexto += fGerStr(10,"")					// 192 - 010 -> Complemento do Endereço da Residência
	cTexto += fGerZero(05,"")					// 202 - 005 -> Número do Logradouro da Residência
	cTexto += fGerZero(08,"")					// 207 - 008 -> CEP Residencial
	cTexto += fGerStr(28,"")					// 215 - 028 -> Município da Residência
	cTexto += fGerStr(30,"")					// 243 - 030 -> Bairro da Residência
	cTexto += fGerStr(02,"")					// 273 - 002 -> Sigla do Estado da Residência
	cTexto += fGerStr(35,"")					// 275 - 035 -> Nome da Mãe
	cTexto += fGerStr(01,"")					// 310 - 001 -> Cód. Opção Ender. Correspondência:  R = Residencial   C = Comercial
	cTexto += fGerZero(04,"")					// 311 - 004 -> Cód. DDD Comercial (obrigatório, se o número de telefone presente)
	cTexto += fGerZero(08,"")					// 315 - 008 -> Num. Telefone Comercial
	cTexto += fGerZero(04,"")					// 323 - 004 -> Num . Ramal Comercial
	cTexto += fGerZero(04,"")					// 327 - 004 -> Cód. DDD Residencial (obrigatório, se o número de telefone presente)
	cTexto += fGerZero(08,"")					// 331 - 008 -> Num. Telefone Residencial
	cTexto += fGerStr(01,"")					// 339 - 001 -> Cód. Escolaridade
	cTexto += fGerZero(08,"")					// 340 - 008 -> Data de Admissão (DDMMAAAA)
	cTexto += " "								// 348 - 001 -> Espaço Reservado
	cTexto += fGerStr(40,(cAliasSRA)->RA_NOME)	// 349 - 040 -> Nome do Usuário
	cTexto += "      "							// 389 - 006 -> Espaço Reservado
	cTexto += fGerZero(6,Str(nCntReg))          // 395 - 006 -> Número seqüencial do registro
	cTexto += CRLF

	fGravaReg(AllTrim(cTexto))
                                                                                    

	If MV_PAR01 == 3

		RG2->(dbSetOrder(1))
		If RG2->(DbSeek(cFilHist + cMatHist + "1"+"09 "+cPerHist+"01"+"VRF"))
			lIncHist := .F.		
		EndIf

		RECLOCK( "RG2", lIncHist )
			RG2_FILIAL := cFilHist
			RG2_MAT := cMatHist
			RG2_PERIOD := cPerHist
			RG2_NROPGT := "01"
			RG2_ANOMES := cPerHist
			RG2_TPVALE := "1"
			RG2_TPBEM := "02"
			RG2_CODIGO := "09"
			RG2_ROTEIR := "VRF"
			RG2_DIACAL := 1
			RG2_VALCAL := nValbenef
			RG2_CC := (cAliasSRA)->RA_CC			
		RG2->(MSUNLOCK( ))

	EndIf

Return()

/*/{Protheus.doc} REGI_9
REGISTRO TRAILLER
/*/

Static Function REGI_9()

Local cTexto := ""
Local cValPed :=  StrZero(Round(nValreg5*100,2),15)

	nCntReg ++
													// INI - TAM
	cTexto := "9"                     				// 001 - 001 -> Tipo de registro. Fixo 2 = Área Funcional
	cTexto += fGerZero(6,Str(nCntReg5))             // 002 - 006 -> Quantidade total de registros de Usuários do Pedido (Registro 5)
	cTexto += cValPed                    			// 008 - 015 -> Valor total do Pedido (Somatória da Posição 002 do Registro 5)
	cTexto += fGerStr(372,'')		                // 023 - 372 -> Espeços em brancos
	cTexto += fGerZero(6,Str(nCntReg))              // 395 - 006 -> Número seqüencial do registro

	fGravaReg(AllTrim(cTexto))

Return()

/*/{Protheus.doc} MDM001
Rotina responsável por criar as perguntas do relatório no SX1 caso não existam.
@param		Nenhum
@return		Nenhum
@author 	André Luis Maximiano Longhini
@since 		07/12/2021
@version 	1.0
@Obs		07/12/2021 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/
Static Function MDM001()

	Local i := 0
	Local j := 0
	Local aHelpPor	 := {}
	Local cChaveHelp := ""

	_sAlias := Alias()
	DbSelectArea("SX1")
	DbSetOrder(1)
	cPerg := PADR(cPerg,10)
	aRegs:={}

// Grupo/Ordem/PerguntaP/PerguntaE/PerguntaI/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/DefSpa1/DefEng1/Cnt01/Var02/Def02/DefSpa2/DefEng2/Cnt02/Var03/Def03/DefSpa3/DefEng3/Cnt03/Var04/Def04/DefSpa4/DefEng4/Cnt04/Var05/Def05/DefSpa5/DefEng5/Cnt05/F3/Pyme/GRPSXG/Help/Picture/IDFIL
	AADD(aRegs,{cPerg,"05","Tipo Arquivo ?  ","","","mv_ch5","C",1,0,0,"C","","mv_par01","VA","","","","VR","","","","","","","","","","","","","","","","","","","",""})
	AADD(aRegs,{cPerg,"06","Matricula de ?   ","","","mv_ch6","C",TamSx3("RA_MAT")[1],0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","SRA"})
	AADD(aRegs,{cPerg,"07","Matricula ate ?   ","","","mv_ch7","C",TamSx3("RA_MAT")[1],0,0,"G","NaoVazio","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","SRA"})
	AADD(aRegs,{cPerg,"08","Data de Referencia ?  ","","","mv_ch8","D",08,0,0,"G","NaoVazio","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","",""})
	AADD(aRegs,{cPerg,"09","Local do arquivo ?    ","","","mv_ch9","C",30,0,0,"G","	","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","",""})
	AADD(aRegs,{cPerg,"10","Nome do arquivo ?   ","","","mv_cha","C",30,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","",""})
	AADD(aRegs,{cPerg,"11","Data Entrega ?    ","","","mv_chb","D",8,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","",""})
	AADD(aRegs,{cPerg,"12","Codigo Contrato ?   ","","","mv_chc","C",11,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","",""})
	AADD(aRegs,{cPerg,"13","Valor ?	  ","","","mv_chd","N",6,0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","",""})
	AADD(aRegs,{cPerg,"14","Centro de Custo de?	  ","","","mv_chd","C",TamSx3("RA_CC")[1],0,0,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})
    AADD(aRegs,{cPerg,"15","Centro de Custo ate?	  ","","","mv_chd","C",TamSx3("RA_CC")[1],0,0,"G","NaoVazio","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})
	//Adiciona o conteúdo dos helps no array.
	AADD(aHelpPor, "Selecione a opção de Integração: VA - Vale Alimentação; VR - Vale Refeição")
	AADD(aHelpPor, "Informe a Matrícula inicial.")
	AADD(aHelpPor, "Informe a Matrícula final.")
	AADD(aHelpPor, "Informe a Data de Referencia.")
	AADD(aHelpPor, "Informe o Local para salvar o arquivo.")
	AADD(aHelpPor, "Informe o nome que deseja para o arquivo.")
	AADD(aHelpPor, "Informe a Data de pagamento.")
	AADD(aHelpPor, "Informe o Código do Contrato na Alelo.")
    AADD(aHelpPor, "Informe o Valor.")
	AADD(aHelpPor, "Informe o Centro de Custo Inicial.")
	AADD(aHelpPor, "Informe o Centro de Custo Final.")

	

	//Cria as perguntas na SX1.
	For i:=1 to Len(aRegs)

		If !dbSeek(cPerg+aRegs[i,2])
			RecLock("SX1",.T.)
			For j:=1 to FCount()
				If j <= Len(aRegs[i])
					FieldPut(j,aRegs[i,j])
				Endif
			Next
			MsUnlock()
		Endif

		//Chave da Pergunta para criar o Help
		cChaveHelp := "P." + AllTrim(aRegs[i,1]) + AllTrim(aRegs[i,2]) + "."

		//Se tiver Help da pergunta cria
		If !Empty(aHelpPor[i])
			MDM009(cChaveHelp, aHelpPor[i], .T.)
		EndIf

	Next

Return


/*/{Protheus.doc} MDM009
Rotina responsável por criar o HELP das perguntas do relatório no arquivo "SIGAHLP.HLP".
@param		Parâmetros: cKey : Chave da Pergunta
cHelp: Texto do Help
lUpdate: Indica se deve atualizar o help
@return		Nenhum
@author 	André Luis Maximiano Longhini
@since 		07/12/2021
@version 	1.0
@Obs		07/12/2021 - MedMais - André Luis Maximiano Longhini - Construção inicial.

/*/

Static Function MDM009(cKey, cHelp, lUpdate)

	Local cFilePor  := "SIGAHLP.HLP"
	Local nRet      := 0
	Default cKey    := ""
	Default cHelp   := ""
	Default lUpdate := .F.

	//Se a Chave ou o Help estiverem em branco
	If Empty(cKey) .Or. Empty(cHelp)
		Return
	EndIf

	//**************************** Português
	nRet := SPF_SEEK(cFilePor, cKey, 1)

	//Se não encontrar, será inclusão
	If nRet < 0
		SPF_INSERT(cFilePor, cKey, , , cHelp)

		//Senão, será atualização
	Else
		If lUpdate
			SPF_UPDATE(cFilePor, nRet, cKey, , , cHelp)
		EndIf
	EndIf

Return


/*/{Protheus.doc} fGerStr
Geração do arquivo de integração ALELO
/*/
Static Function fGerStr(nNum,cVaria)

Local cVar

cVar := AllTrim(cVaria) + Space(nNum)

cVar := Subst(cVar,1,nNum)

Return(cVar)

/*/{Protheus.doc} fGerZero
Geração do arquivo de integração ALELO
/*/
Static Function fGerZero(nNum,cVaria)

Local cVar

cVar := Replic("0",nNum) + AllTrim(cVaria)

cVar := Right(cVar,nNum)

Return(cVar)

/*/{Protheus.doc} fGravaReg
Geração do arquivo de integração ALELO
/*/
Static Function fGravaReg(cLin)

If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin)
	If !MsgYesNo('Ocorreu um erro na grava‡„o do arquivo '+AllTrim(cNomeArq)+'.   Continua?','Aten‡„o!')
		lContinua := .F.
		Return
	Endif
Endif

Return()

/*/{Protheus.doc} fCData
Geração do arquivo de integração ALELO
/*/
Static Function fCData(dData)

_cData := GravaData(dData,.F.,1)

_cRet := Substr(_cData,1,2) + "/"
_cRet += Substr(_cData,3,2) + "/"
_cRet += Substr(_cData,5,2)

Return(_cRet)
