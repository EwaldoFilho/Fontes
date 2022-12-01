

var leitor
// declarar o intervalo em que será disparado.
function TestarJSON() { 
    	 
    	var RA_FILIAL        = $("#RA_FILIAL").val();    	
    	var RA_NOME        = '"'+hAPI.getCardValue("RA_NOME")+'"';
    	var RA_NOMECMP       = '"'+hAPI.getCardValue("RA_NOMECMP")+'"';
    	var RA_MAE       = '"'+hAPI.getCardValue("RA_MAE")+'"';
    	var RA_SEXO  = '"'+hAPI.getCardValue("RA_SEXO")+'"';
    	var RA_RACACOR        =  '"'+hAPI.getCardValue ("RA_RACACOR")+'"';
    	var RA_NASC       = '"'+hAPI.getCardValue("RA_NASC")+'"';
    	var RA_ESTCIVI       = '"'+hAPI.getCardValue("RA_ESTCIVI")+'"';
    	var RA_CPAISOR       = '"'+hAPI.getCardValue("RA_CPAISOR")+'"';
    	var RA_DTFIMCT       = '"'+hAPI.getCardValue("RA_DTFIMCT")+'"';
    	var RA_NACIONC       = '"'+hAPI.getCardValue("RA_NACIONC")+'"';
    	var RA_NACIONN       = '"'+hAPI.getCardValue("RA_NACIONN")+'"';
    	var RA_NATURAL       = '"'+hAPI.getCardValue("RA_NATURAL")+'"';
    	var RA_NACIONA       = '"'+hAPI.getCardValue("RA_NACIONA")+'"';
    	var RA_CODMUNN       = '"'+hAPI.getCardValue("RA_CODMUNN")+'"';
    	var RA_MUNNASC       = '"'+hAPI.getCardValue("RA_MUNNASC")+'"';
    	var RA_GRINRAI       = '"'+hAPI.getCardValue("RA_GRINRAI")+'"';
    	var RA_EMAIL       = '"'+hAPI.getCardValue("RA_EMAIL")+'"';
    	var RA_BRPDH       = '"'+hAPI.getCardValue("RA_BRPDH")+'"';
    	var RA_DEFIFIS       = '"'+hAPI.getCardValue("RA_DEFIFIS")+'"';
    	var RA_CC       = '"'+hAPI.getCardValue("RA_CC")+'"';
    	var RA_TIPOADM       = '"'+hAPI.getCardValue("RA_TIPOADM")+'"';
    	var RA_ADMISSA       = '"'+hAPI.getCardValue("RA_ADMISSA")+'"';
    	var RA_OPCAO       = '"'+hAPI.getCardValue("RA_OPCAO")+'"';
    	var RA_BCDEPSA       = '"'+hAPI.getCardValue("RA_BCDEPSA")+'"';
    	var RA_CTDEPSA       = '"'+hAPI.getCardValue("RA_CTDEPSA")+'"';
    	var RA_TPPREVI       = '"'+hAPI.getCardValue("RA_TPPREVI")+'"';
    	var RA_PROCES       = '"'+hAPI.getCardValue("RA_PROCES")+'"';
    	var RA_HRSMES       = '"'+hAPI.getCardValue("RA_HRSMES")+'"';
    	var RA_CATFUNC       = '"'+hAPI.getCardValue("RA_CATFUNC")+'"';
    	var RA_HRSEMAN       = '"'+hAPI.getCardValue("RA_HRSEMAN")+'"';
    	var RA_HRSDIA       = '"'+hAPI.getCardValue("RA_HRSDIA")+'"';
    	var RA_CODFUNC       = '"'+hAPI.getCardValue("RA_CODFUNC")+'"';
    	var RA_SALARIO       = '"'+hAPI.getCardValue("RA_SALARIO")+'"';
    	var RA_TPCONTR       = '"'+hAPI.getCardValue("RA_TPCONTR")+'"';
    	var RA_HOPARC       = '"'+hAPI.getCardValue("RA_HOPARC")+'"';
    	var RA_SINDICA       = '"'+hAPI.getCardValue("RA_SINDICA")+'"';
    	var RA_TIPOPGT       = '"'+hAPI.getCardValue("RA_TIPOPGT")+'"';
    	var RA_VIEMRAI       = '"'+hAPI.getCardValue("RA_VIEMRAI")+'"';
    	var RA_CATEFD       = '"'+hAPI.getCardValue("RA_CATEFD")+'"';
    	var RA_CONFED       = '"'+hAPI.getCardValue("RA_CONFED")+'"';
    	var RA_MENSIND       = '"'+hAPI.getCardValue("RA_MENSIND")+'"';
    	var RA_ASSIST       = '"'+hAPI.getCardValue("RA_ASSIST")+'"';
    	var RA_DEPTO       = '"'+hAPI.getCardValue("RA_DEPTO")+'"';
    	var RA_COMPSAB       = '"'+hAPI.getCardValue("RA_COMPSAB")+'"';
    	var RA_CIC       = '"'+hAPI.getCardValue("RA_CIC")+'"';
    	var RA_PIS       = '"'+hAPI.getCardValue("RA_PIS")+'"';
    	var RA_RG       = '"'+hAPI.getCardValue("RA_RG")+'"';
    	var RA_DTRGEXP       = '"'+hAPI.getCardValue("RA_DTRGEXP")+'"';
    	var RA_RGUF       = '"'+hAPI.getCardValue("RA_RGUF")+'"';
    	var RA_RGORG       = '"'+hAPI.getCardValue("RA_RGORG")+'"';
    	var RA_RGEXP       = '"'+hAPI.getCardValue("RA_RGEXP")+'"';
    	var RA_ORGEMRG       = '"'+hAPI.getCardValue("RA_ORGEMRG")+'"';
    	var RA_TITULOE       = '"'+hAPI.getCardValue("RA_TITULOE")+'"';
    	var RA_ZONASEC       = '"'+hAPI.getCardValue("RA_ZONASEC")+'"';
    	var RA_SECAO       = '"'+hAPI.getCardValue("RA_SECAO")+'"';
    	var RA_LOCBNF       = '"'+hAPI.getCardValue("RA_LOCBNF")+'"';
    	var RA_CHAPA       = '"'+hAPI.getCardValue("RA_CHAPA")+'"';
    	var RA_TNOTRAB       = '"'+hAPI.getCardValue("RA_TNOTRAB")+'"';
    	var RA_REGRA       = '"'+hAPI.getCardValue("RA_REGRA")+'"';
    	var RA_SEQTURN       = '"'+hAPI.getCardValue("RA_SEQTURN")+'"';
    	var RA_TIPENDE       = '"'+hAPI.getCardValue("RA_TIPENDE")+'"';
    	var RA_LOGRTP       = '"'+hAPI.getCardValue("RA_LOGRTP")+'"';
    	var RA_LOGRDSC       = '"'+hAPI.getCardValue("RA_LOGRDSC")+'"';
    	var RA_LOGRNUM       = '"'+hAPI.getCardValue("RA_LOGRNUM")+'"';
    	var RA_ENDEREC       = '"'+hAPI.getCardValue("RA_ENDEREC")+'"';
    	var RA_NUMENDE       = '"'+hAPI.getCardValue("RA_NUMENDE")+'"';
    	var RA_COMPLEM       = '"'+hAPI.getCardValue("RA_COMPLEM")+'"';
    	var RA_BAIRRO       = '"'+hAPI.getCardValue("RA_BAIRRO")+'"';
    	var RA_ESTADO       = '"'+hAPI.getCardValue("RA_ESTADO")+'"';
    	var RA_CODMUN       = '"'+hAPI.getCardValue("RA_CODMUN")+'"';
    	var RA_CODMUNE       = '"'+hAPI.getCardValue("RA_CODMUNE")+'"';
    	var RA_MUNICIP       = '"'+hAPI.getCardValue("RA_MUNICIP")+'"';
    	var RA_CEP       = '"'+hAPI.getCardValue("RA_CEP")+'"';
    	var RA_DDDCELU       = '"'+hAPI.getCardValue("RA_DDDCELU")+'"';
    	var RA_NUMCELU       = '"'+hAPI.getCardValue("RA_NUMCELU")+'"';
    	var RA_ADCPERI       = '"'+hAPI.getCardValue("RA_ADCPERI")+'"';
    	var RA_ADCINS       = '"'+hAPI.getCardValue("RA_ADCINS")+'"';
    	var RA_XTPCON       = '"'+hAPI.getCardValue("RA_XTPCON")+'"';
    	
    	var objBackEnd = JSON.parse('{"RA_FILIAL":'+RA_FILIAL+',' +    			
    			'"RA_NOME":'+RA_NOME+',' +
    			'"RA_NOMECMP":'+RA_NOMECMP+',' +
    			'"RA_MAE":'+RA_MAE+',' +
    			'"RA_PAI":'+RA_PAI+',' +
    			'"RA_SEXO":'+RA_SEXO+',' +
    			'"RA_RACACOR":'+RA_RACACOR+',' +
    			'"RA_NASC":'+RA_NASC+',' +
    			'"RA_ESTCIVI":'+RA_ESTCIVI+',' +
    			'"RA_CPAISOR":'+RA_CPAISOR+',' +
    			'"RA_DTFIMCT":'+RA_DTFIMCT+',' +
    			'"RA_NACIONC":'+RA_NACIONC+',' +
    			'"RA_NACIONN":'+RA_NACIONN+',' +
    			'"RA_NATURAL":'+RA_NATURAL+',' +
    			'"RA_NACIONA":'+RA_NACIONA+',' +
    			'"RA_CODMUNN":'+RA_CODMUNN+',' +
    			'"RA_MUNNASC":'+RA_MUNNASC+',' +
    			'"RA_GRINRAI":'+RA_GRINRAI+',' +
    			'"RA_EMAIL":'+RA_EMAIL+',' +
    			'"RA_BRPDH":'+RA_BRPDH+',' +
    			'"RA_DEFIFIS":'+RA_DEFIFIS+',' +
    			'"RA_CC":'+RA_CC+',' +
    			'"RA_TIPOADM":'+RA_TIPOADM+',' +
    			'"RA_ADMISSA":'+RA_ADMISSA+',' +
    			'"RA_OPCAO":'+RA_OPCAO+',' +
    			'"RA_BCDEPSA":'+RA_BCDEPSA+',' +
    			'"RA_CTDEPSA":'+RA_CTDEPSA+',' +
    			'"RA_TPPREVI":'+RA_TPPREVI+',' +
    			'"RA_PROCES":'+RA_PROCES+',' +
    			'"RA_HRSMES":'+RA_HRSMES+',' +
    			'"RA_CATFUNC":'+RA_CATFUNC+',' +
    			'"RA_HRSEMAN":'+RA_HRSEMAN+',' +
    			'"RA_HRSDIA":'+RA_HRSDIA+',' +
    			'"RA_CODFUNC":'+RA_CODFUNC+',' +
    			'"RA_SALARIO":'+RA_SALARIO+',' +
    			'"RA_TPCONTR":'+RA_TPCONTR+',' +
    			'"RA_HOPARC":'+RA_HOPARC+',' +
    			'"RA_SINDICA":'+RA_SINDICA+',' +
    			'"RA_TIPOPGT":'+RA_TIPOPGT+',' +
    			'"RA_VIEMRAI":'+RA_VIEMRAI+',' +
    			'"RA_CATEFD":'+RA_CATEFD+',' +
    			'"RA_CONFED":'+RA_CONFED+',' +
    			'"RA_MENSIND":'+RA_MENSIND+',' +
    			'"RA_ASSIST":'+RA_ASSIST+',' +
    			'"RA_DEPTO":'+RA_DEPTO+',' +
    			'"RA_COMPSAB":'+RA_COMPSAB+',' +
    			'"RA_CIC":'+RA_CIC+',' +
    			'"RA_PIS":'+RA_PIS+',' +
    			'"RA_RG":'+RA_RG+',' +
    			'"RA_DTRGEXP":'+RA_DTRGEXP+',' +
    			'"RA_RGUF":'+RA_RGUF+',' +
    			'"RA_RGORG":'+RA_RGORG+',' +
    			'"RA_RGEXP":'+RA_RGEXP+',' +
    			'"RA_ORGEMRG":'+RA_ORGEMRG+',' +
    			'"RA_TITULOE":'+RA_TITULOE+',' +
    			'"RA_ZONASEC":'+RA_ZONASEC+',' +
    			'"RA_SECAO":'+RA_SECAO+',' +
    			'"RA_LOCBNF":'+RA_LOCBNF+',' +
    			'"RA_CHAPA":'+RA_CHAPA+',' +
    			'"RA_TNOTRAB":'+RA_TNOTRAB+',' +
    			'"RA_REGRA":'+RA_REGRA+',' +
    			'"RA_SEQTURN":'+RA_SEQTURN+',' +
    			'"RA_TIPENDE":'+RA_TIPENDE+',' +
    			'"RA_LOGRTP":'+RA_LOGRTP+',' +
    			'"RA_LOGRDSC":'+RA_LOGRDSC+',' +
    			'"RA_LOGRNUM":'+RA_LOGRNUM+',' +
    			'"RA_ENDEREC":'+RA_ENDEREC+',' +
    			'"RA_NUMENDE":'+RA_NUMENDE+',' +
    			'"RA_COMPLEM":'+RA_COMPLEM+',' +
    			'"RA_BAIRRO":'+RA_BAIRRO+',' +
    			'"RA_ESTADO":'+RA_ESTADO+',' +
    			'"RA_CODMUN":'+RA_CODMUN+',' +
    			'"RA_CODMUNE":'+RA_CODMUNE+',' +
    			'"RA_MUNICIP":'+RA_MUNICIP+',' +
    			'"RA_CEP":'+RA_CEP+',' +
    			'"RA_DDDCELU":'+RA_DDDCELU+',' +
    			'"RA_NUMCELU":'+RA_NUMCELU+',' +
    			'"RA_ADCPERI":'+RA_ADCPERI+',' +
    			'"RA_ADCINS":'+RA_ADCINS+',' +    			
    			'"RA_XTPCON":'+RA_XTPCON+'}');
  
    log.info("INFO OBJBACK::::"+JSON.stringify(objBackEnd));
}

