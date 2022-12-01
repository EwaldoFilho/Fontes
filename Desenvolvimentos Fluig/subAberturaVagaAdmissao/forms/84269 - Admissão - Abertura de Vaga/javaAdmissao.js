function btCadastrais() {
	  var x = document.getElementById("cardFuncionais");	  
	  
	  if(document.getElementById("RA_NOMECMP").value == "" || document.getElementById("RA_NOMECMP").value ==null){
		  document.getElementById("RA_NOMECMP").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_NOME").value == "" || document.getElementById("RA_NOME").value ==null){
		  document.getElementById("RA_NOME").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_MAE").value == "" || document.getElementById("RA_MAE").value ==null){
		  document.getElementById("RA_MAE").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_SEXO").value == "" || document.getElementById("RA_SEXO").value ==null){
		  document.getElementById("RA_SEXO").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_RACACOR").value == "" || document.getElementById("RA_RACACOR").value ==null){
		  document.getElementById("RA_RACACOR").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_NASC").value == "" || document.getElementById("RA_NASC").value ==null){
		  document.getElementById("RA_NASC").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_ESTCIVI").value == "" || document.getElementById("RA_ESTCIVI").value ==null){
		  document.getElementById("RA_ESTCIVI").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("descricaoPais").value == "" || document.getElementById("RA_CPAISOR").value ==null){
		  document.getElementById("descricaoPais").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("descricaoNac").value == "" || document.getElementById("descricaoNac").value ==null){
		  document.getElementById("descricaoNac").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("descricaoNatu").value == "" || document.getElementById("descricaoNatu").value ==null){
		  document.getElementById("descricaoNatu").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("descricaoMun").value == "" || document.getElementById("descricaoMun").value ==null){
		  document.getElementById("descricaoMun").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("descricaoRais").value == "" || document.getElementById("RA_EMAIL").value ==null){
		  document.getElementById("descricaoRais").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_EMAIL").value == "" || document.getElementById("RA_EMAIL").value ==null){
		  document.getElementById("RA_EMAIL").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_DEFIFIS").value == "" || document.getElementById("RA_DEFIFIS").value ==null){
		  document.getElementById("RA_DEFIFIS").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_BRPDH").value == "" || document.getElementById("RA_BRPDH").value ==null){
		  document.getElementById("RA_BRPDH").style = "border: 1px solid #ccc;border-color: #f00;";
	  }else{
		  $('#buttonCadastrais').hide();
		  x.style.display = "block";
		  document.getElementById("RA_NOMECMP").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("RA_NOME").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("RA_MAE").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("RA_SEXO").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("RA_RACACOR").style = "border: 1px solid #ccc;border-color: black;";
		  document.getElementById("RA_NASC").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("RA_ESTCIVI").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("descricaoPais").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("descricaoNac").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("descricaoNatu").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("descricaoMun").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("descricaoRais").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("RA_EMAIL").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("RA_DEFIFIS").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("RA_BRPDH").style = "border: opx solid #ccc;border-color: black;";		  
	  }	    
	}

function btFuncionais() {
	  var x = document.getElementById("cardDocumentos");
	  
	  if(document.getElementById("descricaoFilial").value == "" || document.getElementById("descricaoFilial").value ==null){
		  document.getElementById("descricaoFilial").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("descricaoCcFunc").value == "" || document.getElementById("descricaoCcFunc").value ==null){
		  document.getElementById("descricaoCcFunc").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_ADMISSA").value == "" || document.getElementById("RA_ADMISSA").value ==null){
		  document.getElementById("RA_ADMISSA").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("descricaoTipoAdm").value == "" || document.getElementById("descricaoTipoAdm").value ==null){
		  document.getElementById("descricaoTipoAdm").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("descricaoBcDep").value == "" || document.getElementById("descricaoBcDep").value ==null){
		  document.getElementById("descricaoBcDep").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_CTDEPSA").value == "" || document.getElementById("RA_CTDEPSA").value ==null){
		  document.getElementById("RA_CTDEPSA").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_TPPREVI").value == "" || document.getElementById("RA_TPPREVI").value ==null){
		  document.getElementById("RA_TPPREVI").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_PROCES").value == "" || document.getElementById("RA_PROCES").value ==null){
		  document.getElementById("RA_PROCES").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_HRSMES").value == "" || document.getElementById("RA_HRSMES").value ==null){
		  document.getElementById("RA_HRSMES").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_HRSEMAN").value == "" || document.getElementById("RA_HRSEMAN").value ==null){
		  document.getElementById("RA_HRSEMAN").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_HRSDIA").value == "" || document.getElementById("RA_HRSDIA").value ==null){
		  document.getElementById("RA_HRSDIA").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("descricaoCatFunc").value == "" || document.getElementById("RA_CATFUNC").value ==null){
		  document.getElementById("descricaoCatFunc").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("descricaoFuncao").value == "" || document.getElementById("descricaoFuncao").value ==null){
		  document.getElementById("descricaoFuncao").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_SALARIO").value == "" || document.getElementById("RA_SALARIO").value ==null){
		  document.getElementById("RA_SALARIO").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("descricaoSindical").value == "" || document.getElementById("descricaoSindical").value ==null){
		  document.getElementById("descricaoSindical").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_TPCONTR").value == "" || document.getElementById("RA_TPCONTR").value ==null){
		  document.getElementById("RA_TPCONTR").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("descricaoSindicato").value == "" || document.getElementById("descricaoSindicato").value ==null){
		  document.getElementById("descricaoSindicato").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("descricaoVRais").value == "" || document.getElementById("descricaoVRais").value ==null){
		  document.getElementById("descricaoVRais").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("descricaoEsocial").value == "" || document.getElementById("descricaoEsocial").value ==null){
		  document.getElementById("descricaoEsocial").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("descricaoDepartamento").value == "" || document.getElementById("descricaoDepartamento").value ==null){
		  document.getElementById("descricaoDepartamento").style = "border: 1px solid #ccc;border-color: #f00;";
	  }else{
		  $('#buttonFuncionais').hide();
		  x.style.display = "block";
		  document.getElementById("descricaoFilial").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("descricaoCcFunc").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("RA_ADMISSA").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("descricaoTipoAdm").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("descricaoBcDep").style = "border: 1px solid #ccc;border-color: black;";
		  document.getElementById("RA_CTDEPSA").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("RA_TPPREVI").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("RA_PROCES").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("RA_HRSMES").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("RA_HRSEMAN").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("RA_HRSDIA").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("descricaoCatFunc").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("descricaoFuncao").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("RA_SALARIO").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("descricaoSindical").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("RA_TPCONTR").style = "border: 0px solid #ccc;border-color: black;";
		  document.getElementById("descricaoSindicato").style = "border: 0px solid #ccc;border-color: black;";	
		  document.getElementById("descricaoVRais").style = "border: 0px solid #ccc;border-color: black;";
		  document.getElementById("descricaoEsocial").style = "border: 0px solid #ccc;border-color: black;";
		  document.getElementById("descricaoDepartamento").style = "border: 0px solid #ccc;border-color: black;";		  
		  var banco = $("#banco").val();
			var agencia =$("#agencia").val();
			var ba = 0;
			ba = banco.toString()+agencia.toString();
			$("#RA_BCDEPSA").val(ba);
	  }
	  
	}

function btDocumentos() {
	  var x = document.getElementById("cardBeneficios");
	  
	  if(document.getElementById("RA_CIC").value == "" || document.getElementById("RA_CIC").value ==null){
		  document.getElementById("RA_CIC").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_PIS").value == "" || document.getElementById("RA_PIS").value ==null){
		  document.getElementById("RA_PIS").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_RG").value == "" || document.getElementById("RA_RG").value ==null){
		  document.getElementById("RA_RG").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_DTRGEXP").value == "" || document.getElementById("RA_DTRGEXP").value ==null){
		  document.getElementById("RA_DTRGEXP").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("descricaoUfRg").value == "" || document.getElementById("descricaoUfRg").value ==null){
		  document.getElementById("descricaoUfRg").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("descricaoOEmissor").value == "" || document.getElementById("descricaoOEmissor").value ==null){
		  document.getElementById("descricaoOEmissor").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_RGEXP").value == "" || document.getElementById("RA_RGEXP").value ==null){
		  document.getElementById("RA_RGEXP").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_TITULOE").value == "" || document.getElementById("RA_TITULOE").value ==null){
		  document.getElementById("RA_TITULOE").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_ZONASEC").value == "" || document.getElementById("RA_ZONASEC").value ==null){
		  document.getElementById("RA_ZONASEC").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("RA_SECAO").value == "" || document.getElementById("RA_SECAO").value ==null){
		  document.getElementById("RA_SECAO").style = "border: 1px solid #ccc;border-color: #f00;";
	  }else{
		  $('#buttonDocumentos').hide();
		  x.style.display = "block";
		  document.getElementById("RA_CIC").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("RA_PIS").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("RA_RG").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("RA_DTRGEXP").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("descricaoUfRg").style = "border: 1px solid #ccc;border-color: black;";
		  document.getElementById("descricaoOEmissor").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("RA_RGEXP").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("RA_TITULOE").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("RA_ZONASEC").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("RA_SECAO").style = "border: opx solid #ccc;border-color: black;";		  	  
		  
	  }
	}

function btBeneficios() {
	  var x = document.getElementById("cardPonto");
	  
	  if(document.getElementById("descricaoLBenef").value == "" || document.getElementById("descricaoLBenef").value ==null){
		  document.getElementById("descricaoLBenef").style = "border: 1px solid #ccc;border-color: #f00;";
	  }else{
		  $('#buttonBeneficios').hide();
		  x.style.display = "block";
		  document.getElementById("descricaoLBenef").style = "border: opx solid #ccc;border-color: black;";	  	  	  
		  }
	}
function btPonto() {
	  var x = document.getElementById("cardInformacoes");
	  
	  if(document.getElementById("descricaoTurno").value == "" || document.getElementById("descricaoTurno").value ==null){
		  document.getElementById("descricaoTurno").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("descricaoRegra").value == "" || document.getElementById("descricaoRegra").value ==null){
		  document.getElementById("descricaoRegra").style = "border: 1px solid #ccc;border-color: #f00;";
	  }if(document.getElementById("descricaoSeqT").value == "" || document.getElementById("descricaoSeqT").value ==null){
		  document.getElementById("descricaoSeqT").style = "border: 1px solid #ccc;border-color: #f00;";
	  }else{
		  $('#buttonPonto').hide();
		  x.style.display = "block";
		  document.getElementById("descricaoTurno").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("descricaoRegra").style = "border: opx solid #ccc;border-color: black;";
		  document.getElementById("descricaoSeqT").style = "border: opx solid #ccc;border-color: black;";		  	  	  
		  
	  }
	}

function btOInformacoes() {
	  var x = document.getElementById("cardAdicionais");
	  if(document.getElementById("RA_XTPCON").value == "" || document.getElementById("RA_XTPCON").value ==null){
		  document.getElementById("RA_XTPCON").style = "border: 1px solid #ccc;border-color: #f00;";
	  }else{
		  $('#buttonOInformacoes').hide();
		  x.style.display = "block";
		  document.getElementById("RA_XTPCON").style = "border: opx solid #ccc;border-color: black;";
		  
	  }
	}
function btAdicionais() {
	  var x = document.getElementById("cardEndereco");
	  if (x.style.display === "none") {
	    x.style.display = "block";
	    $('#buttonAdicionais').hide();
	  } else {
	    x.style.display = "none";
	  }
	}
function btAdicionais() {
	  var x = document.getElementById("cardEndereco");
	  if (x.style.display === "none") {
	    x.style.display = "block";
	    $('#buttonAdicionais').hide();
	  } else {
	    x.style.display = "none";
	  }
	}

function endChange() {
	  var x = document.getElementById("cardEndereco");
	  if (x.style.display === "none") {
	    x.style.display = "block";
	    $('#buttonAdicionais').hide();
	  } else {
	    x.style.display = "none";
	  }
	}

function tpContrato() {
	  var x = document.getElementById("RA_TPCONTR");
	  if (x.value === "2") {
		  document.getElementById("RA_DTFIMCT").readOnly = false;
		  document.getElementById("RA_DTFIMCT").style = "border: 1px solid #ccc;border-color: #f00;";
		  document.getElementById('RA_DTFIMCT').focus();
		  Swal.fire({
              icon: 'warning',
              title: 'Digite a Data Fim do Contrato Determinado'
          })
	  } else {
		  document.getElementById("RA_DTFIMCT").readOnly = true;
		  document.getElementById("RA_DTFIMCT").style = "border: opx solid #ccc;border-color: black;";
	  }
	}

//var js = JSON.parse(vo.getResult());
//hAPI.setCardValue("nSolicitaProtheus", js.codsc);