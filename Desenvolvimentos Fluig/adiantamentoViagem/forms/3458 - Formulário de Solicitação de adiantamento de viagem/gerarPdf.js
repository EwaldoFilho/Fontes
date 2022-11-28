var doc = new jsPDF();
var specialElementHandlers = {
	'#editor' : function(element, renderer) {
		return true;
	}
};

$('#gerarPdf').click(function() {
	doc.fromHTML($('#panelDadosSolicitante').html(), 15, 15, {
		'width' : 170,
		'elementHandlers' : specialElementHandlers
	});
	doc.save('exemplo-pdf.pdf');
});