function enableFields(form) {		var activity = getValue('WKNumState');if (activity == 16) {form.setEnabled('DataAbertura', false);}if (activity == 4 || activity == 0) {form.setEnabled('DataAbertura', false);}if (activity == 5) {form.setEnabled('DataAbertura', false);}if (activity == 7) {form.setEnabled('DataAbertura', false);}if (activity == 9) {form.setEnabled('DataAbertura', false);}if (activity == 13) {form.setEnabled('DataAbertura', false);}}