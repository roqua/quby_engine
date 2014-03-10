function activatePanel(panel, updateHash, forward) {
    if (shownFlash) {
        $('.flash').hide();
    }
    shownFlash = true;
    $('.panel').hide().removeClass('current');
    panel.show().addClass('current');

    //If panel has no visible questions, skip to the next or previous panel based on 'forward'
    if (panel.is(".noVisibleQuestions")) {
        if (forward) {
            return activatePanel(panel.next(), updateHash, true);
        } else {
            return activatePanel(panel.prev(), updateHash, false);
        }
    }

    if (updateHash)
        changeHash(panel[0].id);
    window.scrollTo(0,0);

    $(document).trigger('panel_activated', [panel])
}

//This function is set to the onClick of the 'check_all' and the 'uncheck_all' checkboxes, with checkValue set
// to "1" and "0" respectively
function setAllCheckboxes(checked, allKey, nothingKey, question, checkValue){
    if(checked){
        // Setting all other checkboxes to checkValue
        check_boxes = $("#answer_"+question+"_input").find("input[type=checkbox]:not(:disabled)")
        if(check_boxes.length == 0){
            check_boxes = $("[data-for='"+question+"']").find("input[type=checkbox]:not(:disabled)")
        }
        for (i = 0; i < check_boxes.length; i++) {
          if (check_boxes[i].id != "answer_"+nothingKey && check_boxes[i].id != "answer_"+allKey){
            $(check_boxes[i]).attr("checked", checkValue);
            if (checkValue) {
                $(check_boxes[i]).attr("checked", checkValue);
            } else {
                $(check_boxes[i]).removeAttr("checked");
            }
            handleDisableCheckboxSubQuestions(check_boxes[i]);
          }
        }

        // Setting the 'check_all' and the 'uncheck_all' checkboxes appropriately, if both are used
        correctAllNothingCheckboxes(checkValue == "checked", allKey, nothingKey);
    }
}

//This function is set to the onClick of all checkboxes besides the 'check_all' or 'uncheck_all' checkboxes
//to appropriately set the 'check_all' or 'uncheck_all' checkboxes if a checkbox changes
//1: If a checkbox is checked, the 'uncheck_all' checkbox should be unchecked
//2: If a checkbox is unchecked, the 'check_all' checkbox should be unchecked
function correctAllNothingCheckboxes(checked, allKey, nothingKey){
    if(checked){
        var el = $('#answer_'+nothingKey)[0];
        if (el) {
            $(el).removeAttr("checked");
            handleDisableCheckboxSubQuestions(el);
        }
    } else {
        var el = $('#answer_'+allKey)[0];
        if (el) {
            $(el).removeAttr("checked");
            handleDisableCheckboxSubQuestions(el);
        }
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

function enableAllSubquestionsOfCheckedRadiosCheckboxes() {
    $('input[type="radio"]:checked, input[type="checkbox"]:checked').each(function(i, el) {
        handleDisableCheckboxSubQuestions(el)
    })
}

function handleDisableRadioSubQuestions(element){
    element.closest('.item').find('.item:not(.specifier)').find('.subinput').attr("disabled", "disabled");
    if(element.attr('checked')){
        element.closest('.option').find('.item:not(.specifier)').find('.subinput').removeAttr("disabled");
    }
}

function handleDisableCheckboxSubQuestions(element){
    element = $(element);
    if(element.attr('checked')){
        $(element).closest('.option').find('.item:not(.specifier)').find('.subinput').removeAttr("disabled");
    } else {
        $(element).closest('.option').find('.item:not(.specifier)').find('.subinput').attr("disabled", "disabled");
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
                input.first().attr("checked", "checked");
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
                if (cvalue == 1) {
                    input.attr("checked", "checked");
                } else {
                    input.removeAttr("checked");
                }
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
        activatePanel(errors.closest('.panel').eq(0), true, true);
    }
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

function handleAjaxFormRequests() {
  $(document).on('ajax:success', "form", function(event, data, status, xhr) {
    content_type = (xhr.getResponseHeader("content-type")||"").split(';')[0]
    if (content_type == 'text/html') { // not json response
      $('#content').replaceWith(data);
      preparePaged();
    }
  });
  $(document).on('ajax:error', "form", function(event, xhr, status) {
    var errorMessage = '';
    if (xhr.status == 0 || xhr.responseText == "") {
        errorMessage = 'Er ging iets fout bij het opslaan van de antwoorden. ' +
                       'Controleer je internetverbinding en probeer het nogmaals.';
        $('.flash').append('<div class="error">' + errorMessage +'</div>').show()
    } else {
        $('<div class="error">Er ging iets fout bij het opslaan van de antwoorden. Probeer het later nogmaals' +
          '<iframe id="error_iframe" style="width: 100%; height: 300px;" /></div>').appendTo('.flash');
        $('#error_iframe').contents().find('body').html(xhr.responseText)
        $('.flash').show()
    }
  });
  $(document).on('ajax:beforeSend', "form", function() {
    $('html').addClass('busy')
  })
  $(document).on('ajax:success ajax:error', "form", function() {
    $('html').removeClass('busy')
  })
}

var leave_page_text;
$(function() {
        $('input').placeholder();

        setupLeavePageNag();

        $(".deselectable").deselectable();

        $('input[type="radio"]:not(.subinput), input[type="checkbox"]:not(.subinput)').live("click", radioCheckboxEvents );

        processExtraData();

        if (isBulk) {
            prepareBulk();
        } else {

            handleAjaxFormRequests();

            preparePaged();
        }

        $('input[type="checkbox"]:not(.subinput), input[type="radio"]:not(.subinput)').each( function(index, element){
           radioCheckboxEvents(element);
        });

        enableAllSubquestionsOfCheckedRadiosCheckboxes();
    }
);
