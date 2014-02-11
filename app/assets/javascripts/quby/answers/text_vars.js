// input[text_var]:change: set contents of all spans with same text_var to value
$(document).on('change', 'input[text_var]', function() {
  var tvar = this.getAttribute('text_var')
  $("span[text_var='"+tvar+"']").html(this.value);
})
$(function(){
  $('input[text_var][value][value!=""]').trigger('change');
});
