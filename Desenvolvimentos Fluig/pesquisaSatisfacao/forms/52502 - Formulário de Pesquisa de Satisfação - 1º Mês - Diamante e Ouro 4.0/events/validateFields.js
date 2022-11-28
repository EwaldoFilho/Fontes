function validateForm(form){
	var state = getValue('WKNumState');

		if (form.getValue("dataaviso") == null  || form.getValue("dataaviso") == "") {
		 	throw "Informe a data do aviso.";
		 }
			
		if (form.getValue("centroCusto") == null  || form.getValue("centroCusto") == "") {
		 	throw "Informe o contrato.";
		 }
		
		if (form.getValue("fiscal") == null  || form.getValue("fiscal") == "") {
		 	throw "Informe o fiscal do contrato.";
		}
		
		if (form.getValue("resposavel") == null  || form.getValue("resposavel") == "") {
		 	throw "Informe o responsável pela pesquisa.";
		}
		
		if (form.getValue("gerente") == null  || form.getValue("gerente") == "") {
		 	throw "Informe o gestor do contrato.";
		} 	
		
		if (form.getValue("Nota1") == null  || form.getValue("Nota1") == "") {
		 	throw "Informe a nota do gestor.";
		} 
		
		if (form.getValue("Nota2") == null  || form.getValue("Nota2") == "") {
		 	throw "Avalie a comunicação com a equipe.";
		} 
		
		if (form.getValue("Nota3") == null  || form.getValue("Nota3") == "") {
		 	throw "Avalie sua satisfação com o embaixador.";
		} 
		if (form.getValue("Nota4") == null  || form.getValue("Nota4") == "") {
		 	throw "Avalie se é facil falar com nossa equipe.";
		} 
		if (form.getValue("Nota5") == null  || form.getValue("Nota5") == "") {
		 	throw "Avalie qual seu nível de satisfação quanto ao desempenho da equipe.";
		} 
		if (form.getValue("Nota6") == null  || form.getValue("Nota6") == "") {
		 	throw "Avalie qual seu nível de satisfação com a apresentação pessoal da equipe, uniformes, EPI’s etc.";
		} 
		if (form.getValue("Nota7") == null  || form.getValue("Nota7") == "") {
		 	throw "Avalie qual seu nível de satisfação com a instalação física do local.";
		} 
		if (form.getValue("Nota8") == null  || form.getValue("Nota8") == "") {
		 	throw "Avalie se você recomendaria o grupo Med+ para alguma instituição.";
		} 			
}
		
		