// input[text_var]:change: set contents of all spans with same text_var to value
$(document).on('change', 'input[text_var]', function() {
  var tvar = this.getAttribute('text_var')
  $("span[text_var='"+tvar+"']").html(this.value);
})
$(function(){
  $("span[text_var]").each(function(idx, elm) {
    $(elm).html(window.text_vars[elm.getAttribute('text_var')]);
  });
  $('input[text_var][value][value!=""]').trigger('change');
});
