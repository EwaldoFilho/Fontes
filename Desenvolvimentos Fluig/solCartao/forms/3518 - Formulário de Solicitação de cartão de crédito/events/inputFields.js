function inputFields(form) {if (form && form.getValue("dataAbertura") && form.getValue("dataAbertura").match("^[0-3]?[0-9]/[0-3]?[0-9]/(?:[0-9]{2})?[0-9]{2}$")) {var split = form.getValue("dataAbertura").split('/');form.setValue("dataAbertura", split[2] + '-' + split[1] + '-' + split[0]);}if (form && form.getValue("dataDesligament") && form.getValue("dataDesligament").match("^[0-3]?[0-9]/[0-3]?[0-9]/(?:[0-9]{2})?[0-9]{2}$")) {var split = form.getValue("dataDesligament").split('/');form.setValue("dataDesligament", split[2] + '-' + split[1] + '-' + split[0]);}}