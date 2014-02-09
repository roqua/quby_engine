var isBulk;
var fail_vals = new Array();
var validationI = 0;
var shownFlash = false;

var scrollToNextQuestion = false;
var curQuestionInputIndex;
var questionInputs;
var nextQuestionInput;

$(function() {
  isBulk = $('form.bulk, form.print').size() > 0;
});
