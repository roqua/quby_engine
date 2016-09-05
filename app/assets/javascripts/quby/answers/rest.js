function initShowsHides(untilPanelId) {
  Quby.panels.find(function (bbPanel) {
    bbPanel.initShowsHides(Quby.questions);
    return bbPanel.get('panelId') == untilPanelId;
  });
}

function activatePanel(panel, forward) {
    if (shownFlash) {
        $('.flash').hide();
    }
    shownFlash = true;
    $('.panel').hide().removeClass('current');
    panel.show().addClass('current');

    // initialize every panel in front of the panel that is activated
    initShowsHides(panel[0].id);

    //If panel has no visible questions, skip to the next or previous panel based on 'forward'
    if (panel.is(".noVisibleQuestions")) {
        if (forward) {
            return activatePanel(panel.next(), true);
        } else {
            return activatePanel(panel.prev(), false);
        }
    }

    enableDisableSubquestionsOfCheckedRadiosCheckboxes(panel)
    window.scrollTo(0,0);
    // iOS 7 will scroll to top, then figure "hey, you scrolled up" and enlarge the URL bar.
    // The URL bar is then displayed on top of our content, which sometimes hides the first
    // question. By scrolling to top again after it is enlarged already, we make sure it is
    // no longer over our content.
    window.setTimeout(function() { window.scrollTo(0,0) }, 1);

    $(document).trigger('panel_activated', [panel])
}

//This function is set to the onClick of the 'check_all' and the 'uncheck_all' checkboxes, with checkValue set
// to true and false respectively
function setAllCheckboxes(checked, allKey, nothingKey, question, checkValue){
    if(checked){
        // Setting all other checkboxes to checkValue
        check_boxes = $("#answer_"+question+"_input").find("input[type=checkbox]:not(:disabled)");
        if(check_boxes.length == 0){
            check_boxes = $("[data-for='"+question+"']").find("input[type=checkbox]:not(:disabled)")
        }
        for (i = 0; i < check_boxes.length; i++) {
          if (check_boxes[i].id != "answer_" + nothingKey && check_boxes[i].id != "answer_" + allKey){
            if (checkValue != $(check_boxes[i]).is(':checked')) {
              $(check_boxes[i]).trigger('click')
            }
            handleDisableCheckboxSubQuestions(check_boxes[i]);
          }
        }

        // Setting the 'check_all' and the 'uncheck_all' checkboxes appropriately, if both are used
        correctAllNothingCheckboxes(checkValue, allKey, nothingKey);
    }
}

//This function is set to the onClick of all checkboxes besides the 'check_all' or 'uncheck_all' checkboxes
//to appropriately set the 'check_all' or 'uncheck_all' checkboxes if a checkbox changes
//1: If a checkbox is checked, the 'uncheck_all' checkbox should be unchecked
//2: If a checkbox is unchecked, the 'check_all' checkbox should be unchecked
function correctAllNothingCheckboxes(checked, allKey, nothingKey){
    var el;
    if(checked){
        el = $('#answer_'+nothingKey)[0];
    } else {
        el = $('#answer_'+allKey)[0];
    }
    if (el) {
        $(el).prop('checked', false);
        handleDisableCheckboxSubQuestions(el);
    }
}

function radioCheckboxEvents(event){
    var element = $(event.target || event);
    if(element.is("[type=radio]")){
        handleDisableRadioSubQuestions(element);
    } else {
        handleDisableCheckboxSubQuestions(element);
    }
}

// uses handleDisableCheckboxSubQuestions, since radio checking would disable all if the last options was not checked.
function enableDisableSubquestionsOfCheckedRadiosCheckboxes(panel) {
    panel.find('input[type="radio"]:not(.subinput), input[type="checkbox"]:not(.subinput)').each(function(i, el) {
        handleDisableCheckboxSubQuestions(el)
    })
}

function handleDisableRadioSubQuestions(element){
    element.closest('.item').find('.item:not(.specifier)').find('.subinput').attr("disabled", "disabled");
    if(element.is(':checked')){
        element.closest('.option').find('.item:not(.specifier)').find('.subinput').removeAttr("disabled");
    }
}

function handleDisableCheckboxSubQuestions(element){
    var element = $(element);
    var subinput = $(element).closest('.option').find('.item:not(.specifier)').find('.subinput');
    if(element.is(':checked')) {
        subinput.removeAttr("disabled");
    } else {
        subinput.attr("disabled", "disabled");
    }
}

function handleMaximumCheckedAllowed(element, max) {
  var item                 = $(element).closest('.item');
  var checkboxes           = item.find('input[type=checkbox]');
  var checked_checkboxes   = checkboxes.filter(':checked');
  var unchecked_checkboxes = checkboxes.filter(':not(:checked)');

  if (checked_checkboxes.length >= max) {
    unchecked_checkboxes.attr('disabled', true);
  }
  else {
    checkboxes.removeAttr('disabled');
  }
}

function preventDefault(event){
    if (event.preventDefault) {
        event.preventDefault();
    } else {
        event.stop();
    }
    event.returnValue = false;
    event.stopPropagation();
}

//TODO: make this work for:
//* enabling/disabling subquestions,
//* hiding other questions,
//* dates,
//* all/nothing checkboxes
function assignValue(qkey, val){
    var inputs;
    if(val instanceof Object){//checkbox vals are passed as an object hash
        inputs = $("[name^='answer["+qkey+"_'][type!='hidden']");
    } else {
        inputs = $("[name='answer["+qkey+"]'][type!='hidden']");
    }
    if(inputs.length > 0){
        var type = inputs[inputs.length-1].type;
        if (type == "radio" || type == "scale") {
            var input = inputs.filter("[value='" + val + "']");
            if (input && input.length > 0) {
                input.first().prop("checked", true);
            }
        } else if (type == "text") {
            var input = inputs.get(0);
            input.value = val;
        } else if( inputs.get(0).tagName == "TEXTAREA"){
            var input = inputs.get(0);
            input.textContent = val;
        } else if (type == "checkbox") {
            $.each(val, function(ckey, cvalue){
                var input = inputs.filter("input[name='answer["+ckey+"]']");
                input.prop("checked", cvalue == 1);
            });
        } else if (type == 'select-one'){
            var input = inputs.find("[value="+val+"]")[0]
            if(input){
                input.selected = "selected";
            }
        }
    }
}


function processExtraData(){

    if (typeof(extra_question_values) != "undefined") {
        $.each(extra_question_values, function(question, value){
            if (value != null) {
                assignValue(question, value);
            }
        });
    }
    if (typeof(extra_failed_validations) != "undefined") {
        $.each(extra_failed_validations, function(question, hash){
            var item = $('#answer_' + question + "_input").closest('.item');
            item.addClass('errors');

            if (hash instanceof Array) {
                $.each(hash, function(){
                    item.find("." + this['valtype']).first().show();
                });
            }
            else {
                item.find("." + hash['valtype']).first().show();
            }
        });
    }
}

function doDivPrint(url){
    var result = $(document.createElement("div"));
    result.load(url, $('form').serializeArray(), function(){
        if(result.find(".notice").length == 0){
          $('.x_container').html(result.find("#content").html());
          if(document.recalc){
            document.recalc();
          }
          $('.x_container').print_area({ afterFilter : function(){
              $('.x_container *').remove();
          }});
        } else {
          $("body > #content").replaceWith(result.find("#content"));
          if (isBulk){
            prepareBulk();
          } else {
            preparePaged();
          }
        }
    });
}


function modalFrame(url){
    $("#modalFrame").attr('src', url);
    //window.scrollTo(0,0);
    $("#modalFrameDialog").dialog({ draggable : false, resizable : false, modal : true, width : 700, height : 600,
    buttons: {
        "Terug": function(){
            $(this).dialog("close");
            $("#modalFrame").attr('src', "about:blank");
        }
    }
    });
}

function prepareBulk(){
    $(document).trigger('panel_activated', [$('form')])
}

function preparePaged(){
    // enable javascript-based previous/next links
    $(".panel .buttons").show();

    // hide first previous button, and last next button
    $(".panel:first .buttons .prev").css('visibility', 'hidden');
    $(".panel:last  .buttons .next").css('visibility', 'hidden');

    //Go to first panel with errors
    var errors = $('.errors');
    if (errors.length > 0){
        shownFlash = false;
        activatePanel(errors.closest('.panel').eq(0), true);
    }
}

function prepareSinglePage() {
    $(document).trigger('panel_activated', [$('form')])
}

function setupLeavePageNag() {
  leave_page_text = $("#leave_page_alert").html();

  function leave_page_nag(e){
    var e = e || window.event;

    e.cancelBubble = true;

    //Firefox 4+ does not use this text
    e.returnValue = leave_page_text;

    if (e.stopPropagation) {
      e.stopPropagation();
      e.preventDefault();
    }

    return leave_page_text;
  }
  if(leave_page_text && leave_page_text.length > 0){
    window.onbeforeunload = leave_page_nag;
  }
}

function handleAjaxFormRequests(prepareDisplayModeCallback) {
  $(document).on('ajax:success', "form", function(event, data, status, xhr) {
    content_type = (xhr.getResponseHeader("content-type")||"").split(';')[0];
    if (content_type == 'text/html') { // not json response
      $('#content').replaceWith(data);
      prepareDisplayModeCallback();
    }
  });
  $(document).on('ajax:error', "form", function(event, xhr, status) {
    var errorMessage = '';
    var flashes = $('.flash');
    if (xhr.status == 0 || xhr.responseText == "") {
        errorMessage = 'Er ging iets fout bij het opslaan van de antwoorden. ' +
                       'Controleer je internetverbinding en probeer het nogmaals.';
        flashes.append('<div class="error">' + errorMessage +'</div>').show()
    } else {
      var error = $('<div class="error">Er ging iets fout bij het opslaan van de antwoorden. Probeer het later nogmaals</div>');
      var response_text = $($.parseHTML(xhr.responseText)).text();
      var error_details = $('<div class="error-details">').text(response_text);
      if (error_details.text().length > 0) { error.append(error_details); }
      flashes.append(error);
      flashes.show();
    }
    // Scroll the flash at the bottom of the page into view
    if(flashes[1] != undefined){
      $('body').scrollTo(flashes[1]);
    }
  });

  $(document).on('ajax:beforeSend', "form", function() {
    $('html').addClass('busy')
  });

  $(document).on('ajax:success ajax:error', "form", function() {
    $('html').removeClass('busy')
  });
}

var leave_page_text;
$(function() {
    $('input').placeholder();

    setupLeavePageNag();

    $(".deselectable").deselectable();

    $('input[type="radio"]:not(.subinput), input[type="checkbox"]:not(.subinput)').on("click", radioCheckboxEvents );

    processExtraData();

    if (displayMode == 'bulk') {
        prepareBulk();
    } else if (displayMode == 'paged') {
        handleAjaxFormRequests(preparePaged);
        preparePaged();
    } else if (displayMode == 'single_page') {
        handleAjaxFormRequests(prepareSinglePage);
        prepareSinglePage();
    }
  }
);
