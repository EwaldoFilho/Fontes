function myFunction() {
	var prog = document.getElementById("qtDias1").value;
	var progConvert = parseInt(prog);
	var totalProg = progConvert

	if (totalProg > 30) {
		$("#qtDias1").val("");
		Swal
				.fire({
					icon : 'warning',
					title : 'A quantidade máxima de dias para programação é 30 e o mínimo 6 dias. Lembrando que no mínimo um período deverá conter 14 dias de gozo.'
				})
	} else if (totalProg < 6) {
		$("#qtDias1").val("");
		Swal
				.fire({
					icon : 'warning',
					title : 'A quantidade máxima de dias para programação é 30 e o mínimo 6 dias. Lembrando que no mínimo um período deverá conter 14 dias de gozo.'
				})
	} else if (totalProg == 30) {
		$("#dt2programacao").prop('readonly', true);
		$("#qtDias2").prop('readonly', true);
		$("#abonoPecuniario1").attr('readonly', 'readonly');
		$("#abonoPecuniario1").attr("style",
				"pointer-events:none;touch-action:none");
		$("#abonoPecuniario2").attr('readonly', 'readonly');
		$("#abonoPecuniario2").attr("style",
				"pointer-events:none;touch-action:none");
		$("#abonoPecuniario1").val("nao");
		$("#abonoPecuniario2").val("");
		$("#dt2programacao").val("");
		$("#qtDias2").val("");

	} else if (totalProg > 20 && totalProg < 30) {
		if (totalProg <= 24) {
			$("#dt2programacao").prop('readonly', false);
			$("#qtDias2").prop('readonly', false);
			$("#abonoPecuniario1").attr('readonly', 'readonly');
			$("#abonoPecuniario1").attr("style",
					"pointer-events:none;touch-action:none");
			$("#abonoPecuniario2").attr('readonly', 'readonly');
			$("#abonoPecuniario2").attr("style",
					"pointer-events:none;touch-action:none");
			$("#abonoPecuniario1").val("nao");
			$("#abonoPecuniario2").val("nao");

		} else if (totalProg > 24) {
			$("#qtDias1").val("");
			Swal
					.fire({
						icon : 'warning',
						title : 'A quantidade máxima de dias para programação é 30 e o mínimo 6 dias. Lembrando que no mínimo um período deverá conter 14 dias de gozo.'
					})
		}
	} else if (totalProg >= 15 && totalProg <= 20) {

		$("#dt2programacao").prop('readonly', false);
		$("#qtDias2").prop('readonly', false);
		$("#abonoPecuniario1").attr('readonly', 'readonly');
		$("#abonoPecuniario1").attr("style",
				"pointer-events:none;touch-action:none");
		$("#abonoPecuniario2").attr('readonly', 'readonly');
		$("#abonoPecuniario2").attr("style",
				"pointer-events:none;touch-action:none");
		$("#abonoPecuniario1").val("nao");
		$("#abonoPecuniario2").val("nao");

	} else if (totalProg <= 14) {

		$("#dt2programacao").prop('readonly', false);
		$("#qtDias2").prop('readonly', false);
		$("#abonoPecuniario1").attr('readonly', false);
		$("#abonoPecuniario1").attr("style", "pointer-events:;touch-action:");
		$("#abonoPecuniario2").attr('readonly', false);
		$("#abonoPecuniario2").attr("style", "pointer-events:;touch-action:");
		$("#abonoPecuniario1").val("");
		$("#abonoPecuniario2").val("");
	}
};

function myFunction2() {
	var prog1 = document.getElementById("qtDias1").value;
	var prog1Convert = parseInt(prog1);
	var abon1 = document.getElementById("abonoPecuniario1").value;
	var prog2 = document.getElementById("qtDias2").value;
	var prog2Convert = parseInt(prog2);
	var totalProg = 0;
	var qtAbon = 0;

	if (abon1 == "sim") {
		qtAbon = 10
	}
	totalProg = prog2Convert + prog1Convert + qtAbon

	if (totalProg > 30) {
		$("#qtDias2").val("");
		Swal
				.fire({
					icon : 'warning',
					title : 'A quantidade máxima de dias para programação é 30 e o mínimo 6 dias. Lembrando que no mínimo um período deverá conter 14 dias de gozo.'
				})
	} else if (totalProg == 30) {
		$("#abonoPecuniario2").attr('readonly', 'readonly');
		$("#abonoPecuniario2").attr("style",
				"pointer-events:none;touch-action:none");
		$("#abonoPecuniario2").val("nao");

	} else if (totalProg > 20 && totalProg < 30) {
		if (totalProg <= 24) {
			$("#abonoPecuniario2").attr('readonly', 'readonly');
			$("#abonoPecuniario2").attr("style",
					"pointer-events:none;touch-action:none");
			$("#abonoPecuniario2").val("nao");

		} else if (totalProg > 24) {
			$("#qtDias2").val("");
			Swal
					.fire({
						icon : 'warning',
						title : 'A quantidade máxima de dias para programação é 30 e o mínimo 6 dias. Lembrando que no mínimo um período deverá conter 14 dias de gozo.'
					})
		}

	} else if (totalProg >= 15 && totalProg <= 20) {
		$("#abonoPecuniario2").attr('readonly', 'readonly');
		$("#abonoPecuniario2").attr("style",
				"pointer-events:none;touch-action:none");
		$("#abonoPecuniario2").val("nao");
	} else if (totalProg >= 6 && totalProg <= 14) {
		$("#abonoPecuniario2").attr('readonly', false);
		$("#abonoPecuniario2").attr("style", "pointer-events:;touch-action:");
		$("#abonoPecuniario2").val("");
	} else if (totalProg < 6) {
		$("#qtDias2").val("");
		Swal
				.fire({
					icon : 'warning',
					title : 'A quantidade máxima de dias para programação é 30 e o mínimo 6 dias. Lembrando que no mínimo um período deverá conter 14 dias de gozo.'
				})
	}

};

function myFunction3() {

	$('input[type="text"]').keyup(function(e) {
		$(this).val($(this).val().toUpperCase());
	});
	var perLimit = document.getElementById("perLimite").value;
	var qtProporcional = document.getElementById("diasProporcionais").value;
	var RF_DATAFIM = document.getElementById("dataBaseFim").value;
	var RF_DATABASE = document.getElementById("dataBaseIni").value;
	var today = new Date();
	perLimit = perLimit.split('/').reverse().join('-');
	today.setDate(today.getDate() + 60); // Voalá
	today = today.toISOString().split('T')[0];
	if (qtProporcional == '0.0') {
		document.getElementsByName("dt1programacao")[0].setAttribute('min',
				today);
		document.getElementsByName("dt1programacao")[0].setAttribute('max',
				perLimit);
		document.getElementsByName("dt2programacao")[0].setAttribute('min',
				today);
		document.getElementsByName("dt2programacao")[0].setAttribute('max',
				perLimit);
	} else if (qtProporcional == '') {
		document.getElementsByName("dt1programacao")[0].setAttribute('min',
				today);
		document.getElementsByName("dt1programacao")[0].setAttribute('max',
				perLimit);
		document.getElementsByName("dt2programacao")[0].setAttribute('min',
				today);
		document.getElementsByName("dt2programacao")[0].setAttribute('max',
				perLimit);

	} else {
		var dia = RF_DATABASE.substring(2, 0);
		var diaConvert = parseInt(dia);
		var diaLimit = String(diaConvert)
		var counterDia = diaLimit.length;
		while (counterDia < 2) {

			diaLimit = "0" + diaLimit;

			counterDia++;

		}
		var mes = RF_DATABASE.substring(5, 3);
		var mesConvert = parseInt(mes);
		var mesLimit = String(mesConvert);
		var counter = mesLimit.length;
		while (counter < 2) {

			mesLimit = "0" + mesLimit;

			counter++;

		}
		var ano = RF_DATABASE.substring(10, 6);
		var anoLimit = parseInt(ano) + 1;
		var limitMax = diaLimit + "/" + mesLimit + "/" + anoLimit;
		limitMax = limitMax.split('/').reverse().join('-');

		document.getElementsByName("dt1programacao")[0].setAttribute('min',
				limitMax);
		document.getElementsByName("dt1programacao")[0].setAttribute('max',
				perLimit);
		document.getElementsByName("dt2programacao")[0].setAttribute('min',
				limitMax);
		document.getElementsByName("dt2programacao")[0].setAttribute('max',
				perLimit);
	}
};
