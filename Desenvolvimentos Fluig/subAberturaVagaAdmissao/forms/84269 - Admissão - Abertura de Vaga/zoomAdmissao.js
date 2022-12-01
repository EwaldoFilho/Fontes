$(document).on("ready", function() {

	var data = new Date();

	$("#processo").val(getWKNumProces());
	$("#estado").val(getWKNumState());

});

function zoomCustoSol(obj) {
	var type = $(obj).prev("input").attr("name");	
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("DsCustoSol", // Nome do Dataset
		"CTT_CUSTO,Custo,CTT_DESC01,Descrição", // Campos a serem
		// exibidos
		"CUSTO,DESCRICAO,LOCAL", // Campos de retorno
		"Centro de Custo", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);
	}

}

function zoomCusto(obj) {
	var type = $(obj).prev("input").attr("name");
	var filial = $("#codFilial").val();
	var filters = "FILIAL," + filial;
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("DsCustoSol", // Nome do Dataset
		"CTT_CUSTO,Custo,CTT_DESC01,Descrição", // Campos a serem
		// exibidos
		"CUSTO,DESCRICAO,LOCAL", // Campos de retorno
		"Centro de Custo", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);
	}

}

function zoomFuncaoC(obj) {
	var type = $(obj).prev("input").attr("name");	
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsFuncao", // Nome do Dataset
		"DESCRICAO,Descrição", // Campos a serem
		// exibidos
		"DESCRICAO", // Campos de retorno
		"Cargo", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);
	}

}

function zoomPais(obj) {
	var type = $(obj).prev("input").attr("name");	
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsPaisProtheus", // Nome do Dataset
		"CCH_CODIGO,Codigo,CCH_PAIS,Descrição", // Campos a serem
		// exibidos
		"CCH_CODIGO,CCH_PAIS", // Campos de retorno
		"Pais", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);
	}

}

function zoomNacionalidade(obj) {
	var type = $(obj).prev("input").attr("name");
	var filial = $("#codFilial").val();
	var filters = "FILIAL," + filial;
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsNacionalidade", // Nome do Dataset
		"X5_CHAVE,Codigo,X5_DESCRI,Descrição", // Campos a serem
		// exibidos
		"X5_CHAVE,X5_DESCRI", // Campos de retorno
		"Nacionalidade", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);
	}

}

function zoomNaturalidade(obj) {
	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("DsNaturalidade", // Nome do Dataset
		"X5_CHAVE,Codigo,X5_DESCRI,Descrição", // Campos a serem
		// exibidos
		"X5_CHAVE,X5_DESCRI", // Campos de retorno
		"Naturalidade", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);
	}

}

function zoomMunicipio(obj) {
	var type = $(obj).prev("input").attr("name");
	var RA_NATURAL = $("#RA_NATURAL").val();
	var filters = "RA_NATURAL," + RA_NATURAL;
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsMunicipio", // Nome do Dataset
		"CC2_CODMUN,Codigo,CC2_MUN,Descrição", // Campos a serem
		// exibidos
		"CC2_CODMUN,CC2_MUN", // Campos de retorno
		"Municipio", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);
	}

}

function zoomInstRais(obj) {
	var type = $(obj).prev("input").attr("name");	
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsInstRais", // Nome do Dataset
		"X5_CHAVE,Codigo,X5_DESCRI,Descrição", // Campos a serem
		// exibidos
		"X5_CHAVE,X5_DESCRI", // Campos de retorno
		"Grau de Instrução Rais", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);
	}

}


function zoomFilialFunc(obj) {
	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsFilial", // Nome do Dataset
		"M0_CODFIL,Filial,M0_FILIAL,Descrição", // Campos a serem exibidos
		"M0_CODFIL,M0_FILIAL", // Campos de retorno
		"Filial", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);
	}

}

function zoomCustoFunc(obj) {
		var type = "descricaoCcFunc"
		/* var type = $(obj).prev("input").attr("name"); */
		var Local = $("#RA_FILIAL").val();
		var FILIAL = Local.substring(0,2);
		var filters = "FILIAL," + FILIAL;
		var searchby = "FILTRO";
		var state = $("#estado").val();

		// FLUIGIP.TABLE.clearTable("itensTabelaRateio")
		$("#qtdCusto").val(0);
		// $("#codCentroCustoForn").val("");
		// $("#descricaoForn").val("");
		if (state == "0") {
			tdizoom.open("dsCustoAdm", // Nome do Dataset
			"CTT_CUSTO,Codigo,CTT_DESC01,Descricao", // Campos a serem exibidos
			"CTT_CUSTO,CTT_DESC01", // Campos de retorno
			"Centro de Custo", // Titulo
			filters, // Filtros
			type, // Type (deve ser sempre o atributo name do campo)
			null, // likefield
			null, // likevalue
			searchby // Campo/Constraint que será buscado o conteudo digitado
			// (Seachby)
			);
			// limpa campos vinculados ao centro de custo

		}

}

function zoomTipoAdm(obj) {
	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsTipoAdmissao", // Nome do Dataset
		"X5_CHAVE,Codigo,X5_DESCRI,Descrição", // Campos a serem exibidos
		"X5_CHAVE,X5_CHAVE", // Campos de retorno
		"Tipo de Admissão", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);
	}

}

function zoomBAg(obj) {
	var type = $(obj).prev("input").attr("name");
	var Local = $("#RA_FILIAL").val();
	var FILIAL = Local.substring(0,2);
	var filters = "FILIAL," + FILIAL;
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsBancoAg", // Nome do Dataset
		"A6_COD,Banco,A6_AGENCIA,Agencia,A6_NOME,Nome", // Campos a serem exibidos
		"A6_COD,A6_AGENCIA,A6_NOME", // Campos de retorno
		"Banco", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);
	}

}

function zoomCatFunc(obj) {
	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsCatFunc", // Nome do Dataset
		"X5_CHAVE,Codigo,X5_DESCRI,Descrição", // Campos a serem exibidos
		"X5_CHAVE,X5_DESCRI", // Campos de retorno
		"Categoria Funcional", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);
	}

}

function zoomFuncaoAdm(obj) {
	var type = $(obj).prev("input").attr("name");
	var Local = $("#RA_FILIAL").val();
	var FILIAL = Local.substring(0,2);
	var filters = "FILIAL," + FILIAL;
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsFuncaoAdm", // Nome do Dataset
		"RJ_FUNCAO,Codigo,RJ_DESC,Descrição", // Campos a serem
		// exibidos
		"RJ_FUNCAO,RJ_DESC", // Campos de retorno
		"Função", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);
	}

}

function zoomCSindical(obj) {
	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsCSindical", // Nome do Dataset
		"X5_CHAVE,Codigo,X5_DESCRI,Descrição", // Campos a serem exibidos
		"X5_CHAVE,X5_DESCRI", // Campos de retorno
		"Contribuição Sindical", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);
	}

}

function zoomSindicato(obj) {
	var type = $(obj).prev("input").attr("name");
	var Local = $("#RA_FILIAL").val();
	var FILIAL = Local.substring(0,2);
	var filters = "FILIAL," + FILIAL;
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsSindicato", // Nome do Dataset
		"RCE_CODIGO,Codigo,RCE_DESCRI,Descrição", // Campos a serem exibidos
		"RCE_CODIGO,RCE_DESCRI", // Campos de retorno
		"Empresa/Filial", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);
	}

}

function zoomRais(obj) {
	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsRais", // Nome do Dataset
		"X5_CHAVE,Codigo,X5_DESCRI,Descrição", // Campos a serem
		// exibidos
		"X5_CHAVE,X5_DESCRI", // Campos de retorno
		"Vinculo Empregatício", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);
	}

}

function zoomEsocial(obj) {
	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsCatEsocial", // Nome do Dataset
		"codigo,Codigo,Descr,Descrição", // Campos a serem exibidos
		"codigo,Descr", // Campos de retorno
		"Categoria Esocial", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);

	}

}

function zoomDepartamento(obj) {
	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsDepartamento", // Nome do Dataset
		"QB_DEPTO,Codigo,QB_DESCRIC,Descrição", // Campos a serem exibidos
		"QB_DEPTO,QB_DESCRIC", // Campos de retorno
		"Departamento", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);

	}

}

function zoomUfRg(obj) {
	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsUfRg", // Nome do Dataset
		"X5_CHAVE,Codigo,X5_DESCRI,Descrição", // Campos a serem exibidos
		"X5_CHAVE,X5_DESCRI", // Campos de retorno
		"UF RG", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);

	}

}

function zoomEmissor(obj) {
	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsOrgaoEmissor", // Nome do Dataset
		"X5_CHAVE,Filial,X5_DESCRI,Descrição", // Campos a serem exibidos
		"X5_CHAVE,X5_DESCRI", // Campos de retorno
		"Orgão Emissor", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);

	}

}

function zoomLBenef(obj) {
	var type = $(obj).prev("input").attr("name");
	var Local = $("#RA_FILIAL").val();
	var FILIAL = Local.substring(0,2);
	var filters = "FILIAL," + FILIAL;
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsLBen", // Nome do Dataset
		"RGC_KEYLOC,Codigo,RGC_DESLOC,Descrição", // Campos a serem exibidos
		"RGC_KEYLOC,RGC_DESLOC", // Campos de retorno
		"Local Benefício", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);

		
	}

}

function zoomTTrab(obj) {
	var type = $(obj).prev("input").attr("name");
	var Local = $("#RA_FILIAL").val();
	var FILIAL = Local.substring(0,2);
	var filters = "FILIAL," + FILIAL;
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsTurnoTrabalho", // Nome do Dataset
		"R6_TURNO,Codigo,R6_DESC,Descrição", // Campos a serem exibidos
		"R6_TURNO,R6_DESC", // Campos de retorno
		"Turno de Trabalho", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);

		
	}

}

function zoomRAp(obj) {
	var type = $(obj).prev("input").attr("name");
	var Local = $("#RA_FILIAL").val();
	var FILIAL = Local.substring(0,2);
	var filters = "FILIAL," + FILIAL;
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsRAp", // Nome do Dataset
		"PA_CODIGO,Codigo,PA_DESC,Descrição", // Campos a serem exibidos
		"PA_CODIGO,PA_DESC", // Campos de retorno
		"Regra de Apontamento", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);

		
		
		
		
	}

}

function zoomSeqTurn(obj) {
	var type = $(obj).prev("input").attr("name");
	var Local = $("#RA_FILIAL").val();
	var FILIAL = Local.substring(0,2);
	var TURNO = $("#RA_TNOTRAB").val().toString();
	var filters = "TURNO," +TURNO+",FILIAL," +FILIAL;
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsSeqTurno", // Nome do Dataset
		"PJ_TURNO,Codigo,R6_DESC,Descrição,PJ_SEMANA,Semana", // Campos a serem exibidos
		"PJ_TURNO,R6_DESC,PJ_SEMANA", // Campos de retorno
		"Sequência Inicial do Turno", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);

	}

}

function zoomTLog(obj) {
	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsTipoLog", // Nome do Dataset
		"COD,Codigo,DESCRICAO,Descrição", // Campos a serem exibidos
		"COD,DESCRICAO", // Campos de retorno
		"Tipo Logradouro", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);
		$("#RA_LOGRDSC").val("");
		$("#RA_ENDEREC").val("");
	}
}

function zoomEstado(obj) {
	var type = $(obj).prev("input").attr("name");
	var filters = "";
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsEstado", // Nome do Dataset
		"X5_CHAVE,Codigo,X5_DESCRI,Descrição", // Campos a serem exibidos
		"X5_CHAVE,X5_DESCRI", // Campos de retorno
		"Estado", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);

		
		
		
		
	}

}

function zoomCMuni(obj) {
	var type = $(obj).prev("input").attr("name");
	var ESTADO = $("#RA_ESTADO").val();	
	var filters = "ESTADO," + ESTADO;
	var searchby = "FILTRO";
	var state = $("#estado").val();

	if (state == "0" || state =="11") {
		tdizoom.open("dsMunicipioAdm", // Nome do Dataset
		"CC2_CODMUN,Codigo,CC2_MUN,Município", // Campos a serem exibidos
		"CC2_CODMUN,CC2_MUN", // Campos de retorno
		"Município", // Titulo
		filters, // Filtros
		type, // Type (deve ser sempre o atributo name do campo)
		null, // likefield
		null, // likevalue
		searchby // Campo/Constraint que será buscado o conteudo digitado
		// (Seachby)
		);

		
	}

}
function setSelectedZoomItem(selectedItem) {
	var name = selectedItem.type.split("___")[0];
	var indice = selectedItem.type.split("___");	
	// "CODIGO,DESCRICAO",
	if (name == "descricaoCentroCustoSol") {
		$("#codCentroCustoSol").val(selectedItem.CTT_CUSTO);
		$("#descricaoCentroCustoSol").val(selectedItem.CTT_DESC01);					
	} 	else if (name == "descricaoCentroCusto") {
		$("#codCentroCusto").val(selectedItem.CTT_CUSTO);
		$("#descricaoCentroCusto").val(selectedItem.CTT_DESC01)
	} else if (name == "descricaoFunc") {		
		$("#descricaoFunc").val(selectedItem.DESCRICAO);		
	}else if (name == "descricaoPais") {		
		$("#RA_CPAISOR").val(selectedItem.CCH_CODIGO);
		$("#descricaoPais").val(selectedItem.CCH_PAIS);
	}else if (name == "descricaoNac") {		
		$("#RA_NACIONA").val(selectedItem.X5_CHAVE);
		$("#descricaoNac").val(selectedItem.X5_DESCRI);
	}else if (name == "descricaoNatu") {		
		$("#RA_NATURAL").val(selectedItem.X5_CHAVE);
		$("#descricaoNatu").val(selectedItem.X5_DESCRI);
	}else if (name == "descricaoMun") {		
		$("#RA_CODMUNN").val(selectedItem.CC2_CODMUN);
		$("#descricaoMun").val(selectedItem.CC2_MUN);
	}else if (name == "descricaoRais") {		
		$("#RA_GRINRAI").val(selectedItem.X5_CHAVE);
		$("#descricaoRais").val(selectedItem.X5_DESCRI);
	}else if (name == "descricaoFilial") {		
		$("#RA_FILIAL").val(selectedItem.M0_CODFIL);
		$("#descricaoFilial").val(selectedItem.M0_FILIAL);
	}else if (name == "descricaoCcFunc") {		
		$("#RA_CC").val(selectedItem.CTT_CUSTO);
		$("#descricaoCcFunc").val(selectedItem.CTT_DESC01);
	}else if (name == "descricaoTipoAdm") {		
		$("#RA_TIPOADM").val(selectedItem.X5_CHAVE);
		$("#descricaoTipoAdm").val(selectedItem.X5_DESCRI);
	}else if (name == "descricaoBcDep") {		
		$("#banco").val(selectedItem.A6_COD);
		$("#agencia").val(selectedItem.A6_AGENCIA);		
		$("#descricaoBcDep").val(selectedItem.A6_NOME);				
	}else if (name == "descricaoCatFunc") {		
		$("#RA_CATFUNC").val(selectedItem.X5_CHAVE);
		$("#descricaoCatFunc").val(selectedItem.X5_DESCRI);
	}else if (name == "descricaoFuncao") {		
		$("#RA_CODFUNC").val(selectedItem.RJ_FUNCAO);
		$("#descricaoFuncao").val(selectedItem.RJ_DESC);
	}else if (name == "descricaoSindical") {		
		$("#RA_PGCTSIN").val(selectedItem.X5_CHAVE);
		$("#descricaoSindical").val(selectedItem.X5_DESCRI);
	}else if (name == "descricaoSindicato") {		
		$("#RA_SINDICA").val(selectedItem.RCE_CODIGO);
		$("#descricaoSindicato").val(selectedItem.RCE_DESCRI);
	}else if (name == "descricaoVRais") {		
		$("#RA_VIEMRAI").val(selectedItem.X5_CHAVE);
		$("#descricaoVRais").val(selectedItem.X5_DESCRI);
	}else if (name == "descricaoEsocial") {		
		$("#RA_CATEFD").val(selectedItem.codigo);
		$("#descricaoEsocial").val(selectedItem.Descr);
	}else if (name == "descricaoDepartamento") {		
		$("#RA_DEPTO").val(selectedItem.QB_DEPTO);
		$("#descricaoDepartamento").val(selectedItem.QB_DESCRIC);
	}else if (name == "descricaoUfRg") {		
		$("#RA_RGUF").val(selectedItem.X5_CHAVE);
		$("#descricaoUfRg").val(selectedItem.X5_DESCRI);
	}else if (name == "descricaoOEmissor") {		
		$("#RA_RGORG").val(selectedItem.X5_CHAVE);
		$("#descricaoOEmissor").val(selectedItem.X5_DESCRI);
	}else if (name == "descricaoLBenef") {		
		$("#RA_LOCBNF").val(selectedItem.RGC_KEYLOC);
		$("#descricaoLBenef").val(selectedItem.RGC_DESLOC);
	}else if (name == "descricaoTurno") {		
		$("#RA_TNOTRAB").val(selectedItem.R6_TURNO);
		$("#descricaoTurno").val(selectedItem.R6_DESC);
	}else if (name == "descricaoRegra") {		
		$("#RA_REGRA").val(selectedItem.PA_CODIGO);
		$("#descricaoRegra").val(selectedItem.PA_DESC);
	}else if (name == "descricaoSeqT") {		
		$("#RA_SEQTURN").val(selectedItem.PJ_SEMANA);
		$("#descricaoSeqT").val(selectedItem.PJ_TURNO);
	}else if (name == "descricaoEstado") {		
		$("#RA_ESTADO").val(selectedItem.X5_CHAVE);
		$("#descricaoEstado").val(selectedItem.X5_DESCRI);
	}else if (name == "RA_MUNICIP") {		
		$("#RA_CODMUN").val(selectedItem.CC2_CODMUN);
		$("#RA_MUNICIP").val(selectedItem.CC2_MUN);		
	}else if (name == "descricaoTLog") {		
		$("#RA_LOGRTP").val(selectedItem.COD);
		$("#descricaoTLog").val(selectedItem.DESCRICAO);		
	}
	
}

function removedZoomItem(selectedItem) {
	if (selectedItem == "fornecedor") {

		$("#fornecedor").val("");
		$("#estadoForn").val("");		
		$("#cnpjFornecedor").val("");
		$("#codForn").val("");
		$("#codLoja").val("");

	} else if (selectedItem == "nameUser") {

		$("#nameUser").val("")
	} else if (selectedItem == "Custo") {

		$("#Custo").val("")
	}

}
