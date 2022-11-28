function validateForm(form){
var state = getValue('WKNumState');


if ((form.getValue("codCentroCusto") == null || form.getValue("codCentroCusto") ==  "") && ( getValue('WKNumProces') == null ||
		(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Informe um centro de custo através da pesqusisa.";
}
if ((form.getValue("TPCONTRATO") == null || form.getValue("TPCONTRATO") ==  "") && ( getValue('WKNumProces') == null ||
		(getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {
			throw "Informe o tipo de contrato CLT ou PJ.";
}



if(state=="53"){

	if ((form.getValue("JustiCEO") == null || form.getValue("JustiCEO") == "") && ( getValue('WKNumProces') == null ||
			(getValue('WKNumProces') > 0 && getValue('WKNextState') == '51') )) {
			throw "Justifique a reprovação do  desligamento.";
			}




	}
}



