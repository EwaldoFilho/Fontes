function validateForm(form) {		var activity = getValue('WKNumState');if ((form.getValue("textbox6") == null || form.getValue("textbox6") ==  "") && ( getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {throw "Informe o CPF n\u00E3o pode ser vazio.";}if ((form.getValue("cbAssuntoRH") == null || form.getValue("cbAssuntoRH") ==  "") && ( getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {throw "Informe o assunto n\u00E3o pode ser vazio.";}if ((form.getValue("contratp") == null || form.getValue("contratp") ==  "") && ( getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {throw "Informe o local de trabalho n\u00E3o pode ser vazio.";}if ((form.getValue("txDescricaoRH") == null || form.getValue("txDescricaoRH") ==  "") && ( getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {throw "Descri\u00E7\u00E3o n\u00E3o pode ser vazio.";}if (activity == 8) {if ((form.getValue("TxTrativaRh") == null || form.getValue("TxTrativaRh") ==  "") && ( getValue('WKNumProces') == null || (getValue('WKNumProces') > 0 && getValue('WKCompletTask') == 'true') )) {throw "Por favor, preencher o campo tratativa!";}}}