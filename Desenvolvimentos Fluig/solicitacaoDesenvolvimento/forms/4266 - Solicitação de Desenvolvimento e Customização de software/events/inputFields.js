function inputFields(form) {if (form && form.getValue("dtAbertura") && form.getValue("dtAbertura").match("^[0-3]?[0-9]/[0-3]?[0-9]/(?:[0-9]{2})?[0-9]{2}$")) {var split = form.getValue("dtAbertura").split('/');form.setValue("dtAbertura", split[2] + '-' + split[1] + '-' + split[0]);}if (form && form.getValue("date4") && form.getValue("date4").match("^[0-3]?[0-9]/[0-3]?[0-9]/(?:[0-9]{2})?[0-9]{2}$")) {var split = form.getValue("date4").split('/');form.setValue("date4", split[2] + '-' + split[1] + '-' + split[0]);}}