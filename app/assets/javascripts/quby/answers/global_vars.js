var isBulk;
var fail_vals = new Array();
var validationI = 0;
var shownFlash = false;

$(function() {
  isBulk = $('form.bulk, form.print').size() > 0;
});
