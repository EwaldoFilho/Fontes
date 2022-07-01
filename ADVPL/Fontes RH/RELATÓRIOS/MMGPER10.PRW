#INCLUDE "Topconn.ch"
#INCLUDE "Protheus.ch"    
 

		
//--------------------------------------------------------------
/*{Protheus.doc} MMGPER10()
Description
Função MMGPER10 (Função para impressão de relatório de aviso de vencimento de
				  segundo período de férias.)
@param   		Parameter Description  
@return  		Return Description 
@author André Longhini
@since 17/06/2022 
*/ 
//--------------------------------------------------------------
//Atualizações:
//VRS001 17/06/2022  - MedMais 					- Desenvolvimento do Relatório.
//VRS002 17/06/2022  - MedMais                 	- Foi incluida a seguinte condição na query de busca:
//                                              - SRF.RF_STATUS='1' para adaptar a versão 12.
//                                              - Adicionada validação numDias<=MV_PAR07 .and. numDias > 0.

//--------------------------------------------------------------
 
User Function MMGPER10()
		
	local oReport
 	local cAlias := getNextAlias()//cria um nome de alias temporário, o próximo disponível
 									  //para não precisar definir um manualmente
	private cPerg  := 'MMGPER10'

 	ValidPerg()
 	Pergunte(cPerg, .F.)

 	oReport := reportDef(cAlias, cPerg)
	oReport:printDialog()
Return


 //+-----------------------------------------------------------------------------------------------+
 //! Função para criação da estrutura do relatório.                                                !
 //+-----------------------------------------------------------------------------------------------+
 Static Function ReportDef(cAlias,cPerg)

	local cTitle  := "Relatorio de Aviso de Vencimento de Férias"
	local cHelp   := "Permite gerar relatorio de Aviso de Vencimento de Férias."
	local oReport
	local oSection1
	
	_cMaskVr:="@E 999,999,999.99"	
 	
	//TReport():New(cReport,cTitle,uParam,bAction,cDescription,lLandscape,uTotalText,lTotalInLine,	cPageTText,lPageTInLine,lTPageBreak,nColSpace)
	oReport := TReport():New('MMGPER10',cTitle,cPerg,{|oReport|ReportPrint(oReport,cAlias)},cHelp)
	oReport:SetLandscape()
 	oReport:SetTotalInLine(.T.)
	oReport:oPage:setPaperSize(8)// 8=A3, a 9=A4 
	
	//Primeira seção
	//TRSection():New(oParent,cTitle,uTable,aOrder,lLoadCells,lLoadOrder,uTotalText,lTotalInLine,lHeaderPage,lHeaderBreak,lPageBreak,lLineBreak,nLeftMargin,lLineStyle,nColSpace,lAutoSize,cCharSeparator,nLinesBefore,nCols,nClrBack,nClrFore,nPercentage)
	oSection1 := TRSection():New(oReport,"Aviso de Vencimento de Férias",{"SRA","CTT","SRF"}) 
	
	//TRCell():New(oParent,cName,cAlias,cTitle,cPicture,nSize,lPixel,bBlock,cAlign,lLineBreak,cHeaderAlign,lCellBreak,nColSpace,lAutoSize,nClrBack,nClrFore,lBold)	
	TRCell():New(oSection1,"RA_FILIAL",        cAlias, "FILIAL",,,,) 
	TRCell():New(oSection1,"RA_CC",            cAlias, "CENTRO DE CUSTO",)
	TRCell():New(oSection1,"CTT_DESC01",       cAlias, "DESCRIÇÃO C.CUSTO",)
	TRCell():New(oSection1,"RA_MAT",           cAlias, "MATRICULA",)
	TRCell():New(oSection1,"RA_NOME",          cAlias, "FUNCIONÁRIO",)
	TRCell():New(oSection1,"RA_ADMISSA",       cAlias, "DATA ADMISSÃO",)
	TRCell():New(oSection1,"RF_DATABAS",       cAlias, "DATA BASE FÉRIAS",)
	TRCell():New(oSection1,"PER_AQUIS",        cAlias, "PERÍODO AQUISITIVO",)	
	TRCell():New(oSection1,"DATABAS2",         cAlias, "DATA BASE FÉRIAS 2º PERÍODO",)
	TRCell():New(oSection1,"PER_AQUIS2",        cAlias, "PERÍODO AQUISITIVO 2º PERÍODO",)
	TRCell():New(oSection1,"DT_LIM_MAX",       cAlias, "DATA LIMITE MÁXIMO",)
	TRCell():New(oSection1,"DIAS_VENC",        cAlias, "DIAS A VENCER 2º PERÍODO",)
					   
Return(oReport)


//+-----------------------------------------------------------------------------------------------+
//! Rotina para montagem dos dados do relatório.                                  !
//+-----------------------------------------------------------------------------------------------+
Static Function ReportPrint(oReport,cAlias) //modelo1
    // usar esse modelo quando for para apresentar todas as linhas que foram
    // recuperadas pela query 
		
	Local oSection1 := oReport:Section(1)
	local _cQuery	:= getQry()
	
	oSection1:Init()
	oSection1:SetHeaderSection(.T.)
 

	IF Select((cAlias)) > 0
    	(cAlias)->(DBclosearea())
    Endif		
		
	TcQuery _cQuery New Alias (cAlias)	
	
	DbSelectArea((cAlias))
	dbGoTop()
		
	oReport:SetMeter((cAlias)->(RecCount()))

	While (cAlias)->(!Eof())
		If oReport:Cancel()
			Exit
		EndIf
 
		oReport:IncMeter()
 		
		//colocar alteração de conteúdo de campos aqui	
		
		
		anoAux1:=val(substr((cAlias)->RF_DATABAS,7,4))
		mesAux1:=val(substr((cAlias)->RF_DATABAS,4,2))
		
		
		dtBs2Per:=substr((cAlias)->RF_DATABAS,1,6)+strzero(anoAux1+1,4)
		
		dtFim2PerAq:=substr((cAlias)->RF_DATABAS,1,6)+strzero(anoAux1+2,4)		
		dtFim2PerAq:=dtoc(ctod(dtFim2PerAq)-1)
				
			
		perAquisi:=(cAlias)->RF_DATABAS + ' - ' + dtoc(ctod(dtBs2Per)-1)			
		per2Aquisi:=dtBs2Per + ' - ' + dtFim2PerAq 
		
			
		numDias:=ctod(dtFim2PerAq)-ddatabase
		
				
		anoAux2:=anoAux1+2
		mesAux1:=mesAux1-3
		if mesAux1<=0
			mesAux1:=12+mesAux1
			anoAux2:=anoAux2-1
		endif
		dtLim:=substr((cAlias)->RF_DATABAS,1,3)+strzero(mesAux1,2)+"/"+strzero(anoAux2,4)
		
				
		oSection1:Cell("PER_AQUIS"):SetValue(perAquisi)
		
		
		oSection1:Cell("DATABAS2"):SetValue(dtBs2Per)
		oSection1:Cell("PER_AQUIS2"):SetValue(per2Aquisi) 		
		
		
		oSection1:Cell("DT_LIM_MAX"):SetValue(dtLim)
		oSection1:Cell("DIAS_VENC"):SetValue(numDias)
 		
 		
 		
 		
 		//fim de colocar alteração de conteúdo de campos aqui

 		//if numDias<=MV_PAR07 
		if numDias<=MV_PAR07 .and. numDias > 0
 			oSection1:PrintLine()
		endif
		
		
		dbSelectArea(cAlias)
		(cAlias)->(dbSkip())
	EndDo
	oSection1:Finish() 

return




Static Function getQry()

	local cQry:=""
	
	cQry+="select " 
	cQry+="	RA_FILIAL "
	cQry+="	,RA_CC "
	cQry+="	,CTT_DESC01 "
	cQry+="	,RA_MAT "
	cQry+="	,RA_NOME "
	cQry+="	,substring(RA_ADMISSA,7,2)+'/'+substring(RA_ADMISSA,5,2)+'/'+substring(RA_ADMISSA,1,4) as RA_ADMISSA "
	cQry+="	,substring(RF_DATABAS,7,2)+'/'+substring(RF_DATABAS,5,2)+'/'+substring(RF_DATABAS,1,4) as RF_DATABAS "		
	cQry+="	,'' as PER_AQUIS " 
	cQry+="	,'' as DT_LIM_MAX "
	cQry+="	,'' as DIAS_VENC "
	cQry+="from "
	cQry+="	"+RETSQLNAME("SRA")+" SRA " 
	cQry+="	left join "+RETSQLNAME("CTT")+" CTT on CTT_FILIAL = SUBSTRING(RA_FILIAL,1,2) and RA_CC=CTT_CUSTO and CTT.D_E_L_E_T_='' "
	
	//cQry+="	left join "+RETSQLNAME("SRF")+" SRF on RA_FILIAL=RF_FILIAL and RA_MAT=RF_MAT and SRF.D_E_L_E_T_='' "	
	cQry+=" left join "+RETSQLNAME("SRF")+" SRF on RA_FILIAL=RF_FILIAL and RA_MAT=RF_MAT and SRF.RF_STATUS='1' and SRF.D_E_L_E_T_='' "
	
	cQry+="where "
	cQry+="	RA_FILIAL between '"+MV_PAR01+"' and '"+MV_PAR02+"' "
	cQry+="	and RA_MAT between '"+MV_PAR03+"' and '"+MV_PAR04+"' "
	cQry+="	and RA_CC between '"+MV_PAR05+"' and '"+MV_PAR06+"' "
	cQry+="	and CHARINDEX(RA_SITFOLH,'"+MV_PAR08+"')>0 "
	cQry+="	and CHARINDEX(RA_CATFUNC,'"+MV_PAR09+"')>0 "
	cQry+="	and SRA.D_E_L_E_T_='' "
	cQry+="order by RA_FILIAL,RA_MAT "
		
return cQry




//+-----------------------------------------------------------------------------------------------+
 //! Função para criação das perguntas (se não existirem)                                          !
 //+-----------------------------------------------------------------------------------------------+
Static Function ValidPerg()

	Local _sAlias := Alias()
	Local aRegs := {}
	Local i,j
		
	dbSelectArea("SX1")
	dbSetOrder(1)
	cPerg := PADR(cPerg,10)
	// Grupo/Ordem/Pergunta/Pergunta Espanhol/Pergunta Ingles/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/DefSpa1/DefEng1/Cnt01/Var02/Def02/DefSpa2/DefEng2/Cnt02/Var03/Def03/DefSpa3/DefEng3/Cnt03/Var04/Def04/DefSpa4/DefEng4/Cnt04/Var05/Def05/DefSpa5/DefEng5/Cnt05/F3/GRPSX6	
	aAdd(aRegs,{cPerg,"01","Filial De          ?","            ?","            ?","mv_ch1","C",TamSx3("RV_FILIAL")[1],0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","SM0"})	
	aAdd(aRegs,{cPerg,"02","Filial Ate         ?","            ?","            ?","mv_ch2","C",TamSx3("RV_FILIAL")[1],0,0,"G","NaoVazio","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","SM0"})
	aAdd(aRegs,{cPerg,"03","Matricula De       ?","            ?","            ?","mv_ch3","C",TamSx3("RA_MAT")[1],0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","SRA"})	
	aAdd(aRegs,{cPerg,"04","Matricula Ate      ?","            ?","            ?","mv_ch4","C",TamSx3("RA_MAT")[1],0,0,"G","NaoVazio","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","SRA"})
	aAdd(aRegs,{cPerg,"05","C. Custo De        ?","            ?","            ?","mv_ch5","C",TamSx3("CTT_CUSTO")[1],0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})	
	aAdd(aRegs,{cPerg,"06","C. Custo Ate       ?","            ?","            ?","mv_ch6","C",TamSx3("CTT_CUSTO")[1],0,0,"G","NaoVazio","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","CTT"})
	aAdd(aRegs,{cPerg,"07","Dias a Vencer      ?","            ?","            ?","mv_ch7","N",04,0,0,"G","NaoVazio","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","",   ""})
	aAdd(aRegs,{cPerg,"08","Situacoes a Imp.   ?","            ?","            ?","mv_ch8","C",05,0,0,"G","fSituacao","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","",   ""})
	aAdd(aRegs,{cPerg,"09","Categorias a Imp.  ?","            ?","            ?","mv_ch9","C",15,0,0,"G","fCategoria","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","",   ""})
	
	
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
	Next
	
	dbSelectArea(_sAlias)
	
Return aRegs                                    

