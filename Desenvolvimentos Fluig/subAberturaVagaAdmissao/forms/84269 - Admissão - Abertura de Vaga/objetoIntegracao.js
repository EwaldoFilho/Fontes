


// declarar o intervalo em que será disparado.
function TestarJSON() { 
    	 
    	var RA_FILIAL        = $("#RA_FILIAL").val();    	
    	var RA_NOME          = $("#RA_NOME").val();
    	var RA_NOMECMP       = $("#RA_NOMECMP").val();
    	var RA_MAE           = $("#RA_MAE").val();
    	var RA_PAI           = $("#RA_PAI").val();
    	var RA_SEXO          = $("#RA_SEXO").val();
    	var RA_RACACOR       =  $("#RA_RACACOR").val();
    	var RA_NASC          = $("#RA_NASC").val();
    	var RA_ESTCIVI       = $("#RA_ESTCIVI").val();
    	var RA_CPAISOR       = $("#RA_CPAISOR").val();
    	var RA_DTFIMCT       = $("#RA_DTFIMCT").val();    	
    	var RA_NATURAL       = $("#RA_NATURAL").val();
    	var RA_NACIONA       = $("#RA_NACIONA").val();
    	var RA_CODMUNN       = $("#RA_CODMUNN").val();
    	var RA_MUNNASC       = $("#descricaoMun").val();
    	var RA_GRINRAI       = $("#RA_GRINRAI").val();
    	var RA_EMAIL         = $("#RA_EMAIL").val();
    	var RA_BRPDH         = $("#RA_BRPDH").val();
    	var RA_DEFIFIS       = $("#RA_DEFIFIS").val();
    	var RA_CC            = $("#RA_CC").val();
    	var RA_TIPOADM       = $("#RA_TIPOADM").val();
    	var RA_ADMISSA       = $("#RA_ADMISSA").val();
    	var RA_OPCAO         = $("#RA_OPCAO").val();
    	var RA_BCDEPSA       = $("#RA_BCDEPSA").val();
    	var RA_CTDEPSA       = $("#RA_CTDEPSA").val();
    	var RA_TPPREVI       = $("#RA_TPPREVI").val();
    	var RA_PROCES        = $("#RA_PROCES").val();
    	var RA_HRSMES        = $("#RA_HRSMES").val();
    	var RA_CATFUNC       = $("#RA_CATFUNC").val();
    	var RA_HRSEMAN       = $("#RA_HRSEMAN").val();
    	var RA_HRSDIA        = $("#RA_HRSDIA").val();
    	var RA_CODFUNC       = $("#RA_CODFUNC").val();
    	var RA_SALARIO       = $("#RA_SALARIO").val();
    	var RA_TPCONTR       = $("#RA_TPCONTR").val();
    	var RA_HOPARC        = $("#RA_HOPARC").val();
    	var RA_SINDICA       = $("#RA_SINDICA").val();
    	var RA_TIPOPGT       = $("#RA_TIPOPGT").val();
    	var RA_VIEMRAI       = $("#RA_VIEMRAI").val();
    	var RA_CATEFD        = $("#RA_CATEFD").val();
    	var RA_CONFED        = $("#RA_CONFED").val();
    	var RA_MENSIND       = $("#RA_MENSIND").val();
    	var RA_ASSIST        = $("#RA_ASSIST").val();
    	var RA_DEPTO         = $("#RA_DEPTO").val();
    	var RA_COMPSAB       = $("#RA_COMPSAB").val();
    	var RA_CIC           = $("#RA_CIC").val();
    	var RA_PIS           = $("#RA_PIS").val();
    	var RA_RG            = $("#RA_RG").val();
    	var RA_DTRGEXP       = $("#RA_DTRGEXP").val();
    	var RA_RGUF          = $("#RA_RGUF").val();
    	var RA_RGORG         = $("#RA_RGORG").val();
    	var RA_RGEXP         = $("#RA_RGEXP").val();
    	var RA_ORGEMRG       = $("#RA_ORGEMRG").val();
    	var RA_TITULOE       = $("#RA_TITULOE").val();
    	var RA_ZONASEC       = $("#RA_ZONASEC").val();
    	var RA_SECAO         = $("#RA_SECAO").val();
    	var RA_LOCBNF        = $("#RA_LOCBNF").val();    	
    	var RA_TNOTRAB       = $("#RA_TNOTRAB").val();
    	var RA_REGRA         = $("#RA_REGRA").val();
    	var RA_SEQTURN       = $("#RA_SEQTURN").val();
    	var RA_TIPENDE       = $("#RA_TIPENDE").val();
    	var RA_LOGRTP        = $("#RA_LOGRTP").val();
    	var RA_LOGRDSC       = $("#RA_LOGRDSC").val();
    	var RA_LOGRNUM       = $("#RA_LOGRNUM").val();
    	var RA_ENDEREC       = $("#RA_ENDEREC").val();
    	var RA_NUMENDE       = $("#RA_NUMENDE").val();
    	var RA_COMPLEM       = $("#RA_COMPLEM").val();
    	var RA_BAIRRO        = $("#RA_BAIRRO").val();
    	var RA_ESTADO        = $("#RA_ESTADO").val();
    	var RA_CODMUN        = $("#RA_CODMUN").val();    	
    	var RA_MUNICIP       = $("#RA_MUNICIP").val();
    	var RA_CEP           = $("#RA_CEP").val();
    	var RA_DDDCELU       = $("#RA_DDDCELU").val();
    	var RA_NUMCELU       = $("#RA_NUMCELU").val();
    	var RA_ADCPERI       = $("#RA_ADCPERI").val();
    	var RA_ADCINS        = $("#RA_ADCINS").val();
    	var RA_XTPCON        = $("#RA_XTPCON").val();
    	
    	var objBackEnd = JSON.parse('{"RA_FILIAL":"'+RA_FILIAL+'",' +    			
    			'"RA_NOME":"'+RA_NOME+'",' +
    			'"RA_NOMECMP":"'+RA_NOMECMP+'",' +
    			'"RA_MAE":"'+RA_MAE+'",' +
    			'"RA_PAI":"'+RA_PAI+'",' +
    			'"RA_SEXO":"'+RA_SEXO+'",' +
    			'"RA_RACACOR":"'+RA_RACACOR+'",' +
    			'"RA_NASC":"'+RA_NASC+'",' +
    			'"RA_ESTCIVI":"'+RA_ESTCIVI+'",' +
    			'"RA_CPAISOR":"'+RA_CPAISOR+'",' +
    			'"RA_DTFIMCT":"'+RA_DTFIMCT+'",' +    			
    			'"RA_NATURAL":"'+RA_NATURAL+'",' +
    			'"RA_NACIONA":"'+RA_NACIONA+'",' +
    			'"RA_CODMUNN":"'+RA_CODMUNN+'",' +
    			'"RA_MUNNASC":"'+RA_MUNNASC+'",' +
    			'"RA_GRINRAI":"'+RA_GRINRAI+'",' +
    			'"RA_EMAIL":"'+RA_EMAIL+'",' +
    			'"RA_BRPDH":"'+RA_BRPDH+'",' +
    			'"RA_DEFIFIS":"'+RA_DEFIFIS+'",' +
    			'"RA_CC":"'+RA_CC+'",' +
    			'"RA_TIPOADM":"'+RA_TIPOADM+'",' +
    			'"RA_ADMISSA":"'+RA_ADMISSA+'",' +
    			'"RA_OPCAO":"'+RA_OPCAO+'",' +
    			'"RA_BCDEPSA":"'+RA_BCDEPSA+'",' +
    			'"RA_CTDEPSA":"'+RA_CTDEPSA+'",' +
    			'"RA_TPPREVI":"'+RA_TPPREVI+'",' +
    			'"RA_PROCES":"'+RA_PROCES+'",' +
    			'"RA_HRSMES":"'+RA_HRSMES+'",' +
    			'"RA_CATFUNC":"'+RA_CATFUNC+'",' +
    			'"RA_HRSEMAN":"'+RA_HRSEMAN+'",' +
    			'"RA_HRSDIA":"'+RA_HRSDIA+'",' +
    			'"RA_CODFUNC":"'+RA_CODFUNC+'",' +
    			'"RA_SALARIO":"'+RA_SALARIO+'",' +
    			'"RA_TPCONTR":"'+RA_TPCONTR+'",' +
    			'"RA_HOPARC":"'+RA_HOPARC+'",' +
    			'"RA_SINDICA":"'+RA_SINDICA+'",' +
    			'"RA_TIPOPGT":"'+RA_TIPOPGT+'",' +
    			'"RA_VIEMRAI":"'+RA_VIEMRAI+'",' +
    			'"RA_CATEFD":"'+RA_CATEFD+'",' +
    			'"RA_CONFED":"'+RA_CONFED+'",' +
    			'"RA_MENSIND":"'+RA_MENSIND+'",' +
    			'"RA_ASSIST":"'+RA_ASSIST+'",' +
    			'"RA_DEPTO":"'+RA_DEPTO+'",' +
    			'"RA_COMPSAB":"'+RA_COMPSAB+'",' +
    			'"RA_CIC":"'+RA_CIC+'",' +
    			'"RA_PIS":"'+RA_PIS+'",' +
    			'"RA_RG":"'+RA_RG+'",' +
    			'"RA_DTRGEXP":"'+RA_DTRGEXP+'",' +
    			'"RA_RGUF":"'+RA_RGUF+'",' +
    			'"RA_RGORG":"'+RA_RGORG+'",' +
    			'"RA_RGEXP":"'+RA_RGEXP+'",' +
    			'"RA_ORGEMRG":"'+RA_ORGEMRG+'",' +
    			'"RA_TITULOE":"'+RA_TITULOE+'",' +
    			'"RA_ZONASEC":"'+RA_ZONASEC+'",' +
    			'"RA_SECAO":"'+RA_SECAO+'",' +
    			'"RA_LOCBNF":"'+RA_LOCBNF+'",' +    			
    			'"RA_TNOTRAB":"'+RA_TNOTRAB+'",' +
    			'"RA_REGRA":"'+RA_REGRA+'",' +
    			'"RA_SEQTURN":"'+RA_SEQTURN+'",' +
    			'"RA_TIPENDE":"'+RA_TIPENDE+'",' +
    			'"RA_LOGRTP":"'+RA_LOGRTP+'",' +
    			'"RA_LOGRDSC":"'+RA_LOGRDSC+'",' +
    			'"RA_LOGRNUM":"'+RA_LOGRNUM+'",' +
    			'"RA_ENDEREC":"'+RA_ENDEREC+'",' +
    			'"RA_NUMENDE":"'+RA_NUMENDE+'",' +
    			'"RA_COMPLEM":"'+RA_COMPLEM+'",' +
    			'"RA_BAIRRO":"'+RA_BAIRRO+'",' +
    			'"RA_ESTADO":"'+RA_ESTADO+'",' +
    			'"RA_CODMUN":"'+RA_CODMUN+'",' +    			
    			'"RA_MUNICIP":"'+RA_MUNICIP+'",' +
    			'"RA_CEP":"'+RA_CEP+'",' +
    			'"RA_DDDCELU":"'+RA_DDDCELU+'",' +
    			'"RA_NUMCELU":"'+RA_NUMCELU+'",' +
    			'"RA_ADCPERI":"'+RA_ADCPERI+'",' +
    			'"RA_ADCINS":"'+RA_ADCINS+'",' +    			
    			'"RA_XTPCON":"'+RA_XTPCON+'"}');
  
    	console.log(objBackEnd);
    	document.getElementById("obj")
    	.innerHTML = JSON.stringify(objBackEnd);
    
}

