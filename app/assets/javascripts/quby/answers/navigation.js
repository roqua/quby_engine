(function() {
  var form_submit_semaphore = true;
  var revertSemaphore = function(clickedElement) {
    form_submit_semaphore = true;
    $("#content").css("cursor", "auto");
    if(clickedElement instanceof jQuery){
      clickedElement.css("cursor", "pointer");
    }
  };

  var setSemaphore = function(clickedElement) {
    form_submit_semaphore = false;
    $("#content").css("cursor", "wait");
    // firefox does not inherit changed cursor styles, so we also need to change the style on the clicked element
    if(clickedElement instanceof jQuery){
      clickedElement.css("cursor", "wait");
    }
    setTimeout(function() { revertSemaphore(clickedElement); }, 3000);
  };

  // 3s timeout on anything that submits the form
  $(document).on("click", ".save input#done-button, .back input, .abort input", function(event) {
    window.onbeforeunload = null;
    if (form_submit_semaphore) {
      setSemaphore($(this));
      return true;
    } else {
      return false;
    }
  });

  $(document).on("click", ".print .print_button", function(event) {
    var iOSSafari = !!navigator.platform.match(/iPhone|iPod|iPad/) &&
                    !!navigator.userAgent.match(/Version\/[\d\.]+.*Safari/);
    event.preventDefault();
    var url = $(this).data("url");
    if (form_submit_semaphore && activePanelsValid()) {
      setSemaphore($(".print_button"));
      var old_unload = window.onbeforeunload;
      window.onbeforeunload = null;
      if(iOSSafari) {
        alert($("#ios-download-instruction").text());
      }
      formSubmitDownload(url, iOSSafari);
      window.onbeforeunload = old_unload;
    }
  });

  $(document).on("ajax:success ajax:error", "form", revertSemaphore);

  function formSubmitDownload(url, iOSSafari) {
    var form = $("#questionnaire-form")[0];
    var oldAction = form.action;
    form.action = url;
    if(iOSSafari) {
      form.target = "_blank";
    }
    form.submit();
    if(iOSSafari) {
      form.target = null;
    }
    form.action = oldAction;
  }

  function activePanelsValid() {
    var panelsToValidate = $(".current.panel");
    if (panelsToValidate.length == 0) {
      panelsToValidate = $(".panel");
    }
    var validPanels = _.map(panelsToValidate, function(panel) { return validatePanel($(panel)); });
    return _.all(validPanels);
  }

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
})();
