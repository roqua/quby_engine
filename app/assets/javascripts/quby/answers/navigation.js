(function() {
  // 3s timeout on anything that submits the form
  var done_button_semaphore = true;
  $(document).on('click', '.save input#done-button, .back input, .abort input', function(event){
    window.onbeforeunload = null;
    if (done_button_semaphore){
      done_button_semaphore = false
      setTimeout(function(){ done_button_semaphore = true }, 3000)
      return true;
    } else {
      return false;
    }
  });
  $(document).on('ajax:success ajax:error', "form", function() {
    done_button_semaphore = true;
  })

  // .paged #done-button:click: validate panel
  $(document).on("click", ".paged #done-button", function(event) {
    if (!validatePanel($('.current.panel').first())) {
      done_button_semaphore = true;
      event.preventDefault(); return false;
    }
  });

  // .paged .prev:click: show previous panel
  $(document).on('click', '.paged .panel .prev input', function(event) {
    event.preventDefault();
    var prevPanel = $(this).parents('.panel').prev()
    activatePanel(prevPanel, false);
  });

  // .paged .next:click: show next panel
  $(document).on('click', '.paged .panel .next input', function(event) {
    event.preventDefault();
    var $panel = $(this).parents('.panel').first();
    if (validatePanel($panel)) {
      activatePanel($panel.next(), true);
    }
  });
})();
