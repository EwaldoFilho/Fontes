function beforeTaskSave(colleagueId, nextSequenceId, userList) {
	
    var atividadeReprovacao = 530;

    if (nextSequenceId == atividadeReprovacao) {

        var comentario = getValue("WKUserComment");

        if (comentario == "") {
            throw "Obrigatório informar um Complemento justificando a reprovação.";
        }
    }
}