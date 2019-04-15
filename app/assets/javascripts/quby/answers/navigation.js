(function() {
  // 3s timeout on anything that submits the form
  var done_button_semaphore = true;
  $(document).on("click", ".save input#done-button, .back input, .abort input", function(event) {
    window.onbeforeunload = null;
    if (done_button_semaphore) {
      done_button_semaphore = false;
      setTimeout(function() { done_button_semaphore = true }, 3000);
      return true;
    } else {
      return false;
    }
  });

  $(document).on("ajax:success ajax:error", "form", function() {
    done_button_semaphore = true;
  });

  window.activePanelsValid = function() {
    var panelsToValidate = $(".current.panel");
    if (panelsToValidate.length == 0) {
      panelsToValidate = $(".panel");
    }
    var validPanels = _.map(panelsToValidate, function(panel) { return validatePanel($(panel)); });
    return _.all(validPanels);
  };

  // #done-button:click: validate all panels for bulk/single page mode, or current panel in case of paged mode
  $(document).on("click", "#done-button", function(event) {
    if (activePanelsValid()) {
      return true;
    } else {
      // on display modes that allow it, show the force submit dialog and scroll to it
      var forceSubmit = $("#force-submit");
      if (forceSubmit.length > 0) {
        forceSubmit.show();
        window.scrollTo(0, 0);
      }
      event.preventDefault();
      return false;
    }
  });

  // .paged .prev:click: show previous panel
  $(document).on("click", ".paged .panel .prev input", function(event) {
    event.preventDefault();
    var prevPanel = $(this).parents(".panel").prev();
    activatePanel(prevPanel, false);
  });

  // .paged .next:click: show next panel
  $(document).on("click", ".paged .panel .next input", function(event) {
    event.preventDefault();
    var $panel = $(this).parents(".panel").first();
    if (validatePanel($panel)) {
      activatePanel($panel.next(), true);
    }
  });

  var pdf_button_semaphore = true;
  $(document).on("click", ".print .print_button", function(event) {
    event.preventDefault();
    url = $(this).data("url");
    if (pdf_button_semaphore && window.activePanelsValid()) {
      $("#content").css("cursor", "wait");
      pdf_button_semaphore = false;
      setTimeout(function() { pdf_button_semaphore = true; }, 3000);
      var old_unload = window.onbeforeunload;
      window.onbeforeunload = null;
      var form = $("#questionnaire-form")[0];
      var old_action = form.action;
      form.action = url;
      form.submit();
      form.action = old_action;
      window.onbeforeunload = old_unload;
      $("#content").css("cursor", "default");
    }
  });
})();
