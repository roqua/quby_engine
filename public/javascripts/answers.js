// Scope:
//
//   questionnaires/1/answers/edit
var hashChangeEnabled;
var lastFocus;
var lastInput;
var nextButtonFocussed = false;
var saveButtonFocussed = false; 
var isBulk;

function activatePanel(panel, updateHash, forward) {
    $('.flash').hide();
    $('.panel').hide().removeClass('current');
    panel.show().addClass('current');
    
    //If all questions on this panel are hidden, skip to the next or previous panel based on 'forward'
    var hiddenInputs = $(panel).find(".item.hidden");
    if (hiddenInputs.length > 0 && hiddenInputs.length == $(panel).find(".item").length){
        if (forward) {
            return activatePanel($(panel).next(), updateHash, true);
        } else {
            return activatePanel($(panel).prev(), updateHash, false);
        }
    }
    
    if (updateHash) {
        hashChangeEnabled = false;
        window.location.hash = panel[0].id;        
    }
    
    qitems = $(".description-and-fields:not(:hidden)");
    focusItem(qitems.first());
    lastInput = qitems.find("input:not(:disabled, :hidden)").first().focus();    
}

function validatePanel(panel) {
  var fail_vals;
  var failed = false;
  $(panel).find(".error").addClass("hidden");
  $(panel).find(".item").removeClass("errors");
  if (panel_validations[panel.id]) {
    validations = panel_validations[panel.id];
        
    for (var question_key in validations) {
      var question_item = $("#answer_"+question_key+"_input").closest('.item');
      
      var inputs = question_item.find("input").not(":disabled, :hidden");      
      fail_vals = [];
      
      for (var i in validations[question_key]) {
        validation = validations[question_key][i];
        switch(validation["type"]){
        case "requires_answer":
            var someChecked = -1;
            for (var j = 0; j < inputs.length; j++){
                var input = inputs[j];
                if(input.type == "text" && question_item.is(".string, .text, .integer, .float, .date") && input.value == "" ){
                    fail_vals.push(validation["type"]);
                    break;
                }
                if((input.type == "radio" && question_item.hasClass("radio")) || (input.type == "checkbox" && question_item.hasClass("checkbox"))){
                    if (input.checked) {
                        someChecked = true;                    
                        break;
                    } else {
                        someChecked = false;                        
                    }
                }
            }
            if (someChecked != -1 && !someChecked) {
              fail_vals.push(validation["type"]);
            }
            break;          
        case "minimum":
            var input = inputs[0];
            if(input.value == ""){
                continue;
            }
            if(parseFloat(input.value) < validation["value"]){
                fail_vals.push(validation["type"]);
            }
            break;
        case "maximum":
            var input = inputs[0];
            if(input.value == ""){
                continue;
            }
            if(parseFloat(input.value) > validation["value"]){
                fail_vals.push(validation["type"]);
            }
            break;
        case "regexp":
            var regex = eval(validation["matcher"]);
            var value;
            if (inputs.length == 3 && (inputs[0].value != "" || inputs[1].value != "" || inputs[2].value != "")) {
                var vals = [];
                inputs.map(function(index, ele){vals.push(ele.value)});
                value = vals.join("-");
            } else {
                value = inputs[0].value;
            }
            if(value == ""){
                continue;
            }
            var result = regex.exec(value);
            if(result == null || result[0] != value){
                fail_vals.push(validation["type"]);
            }
            break;
        case "valid_integer":
            var input = inputs[0];
            if(input.value == ""){
                continue;
            }
            var rgx = /(\s*-?[1-9]+[0-9]*\s*| \s*-?[0-9]?\s*)/;
            var result = rgx.exec(input.value);
            if(result == null || result[0] != input.value){
                fail_vals.push(validation["type"]);
            }             
            break;
        case "valid_float":
            var input = inputs[0];
            if(input.value == ""){
                continue;
            }
            var rgx = /(\s*-?[1-9]+[0-9]*\.[0-9]+\s*|\s*-?[1-9]+[0-9]*\s*|\s*-?[0-9]\.[0-9]+\s*|\s*-?[0-9]?\s*)/;
            var result = rgx.exec(input.value);
            if(result == null || result[0] != input.value){
                fail_vals.push(validation["type"]);
            }
            break;
        case "one_of":
            var input = inputs[0];
            if(input.value == ""){
                continue;
            }
            if(validation["array"].indexOf(parseFloat(input.value)) == -1){
                fail_vals.push(validation["type"]);
            }
            break;
        //These validations would only come into play if the javascript that makes it impossible
        //to check an invalid combination of checkboxes fails. 
        case "too_many_checked":            
            break;
        case "not_all_checked":        
            break;
        }
      }
      if (fail_vals.length != 0) {
          var item = $('#answer_' + question_key + "_input").closest(".item").addClass('errors');
          $(fail_vals).each(function(index, ele){
              item.find(".error." + ele+":first").removeClass("hidden");
          });
          failed = true;
      }
    }
  }
  //To correctly reposition the placeholders
  placeholder();
  return !failed;
}

//This function is set to the onClick of the 'check_all' and the 'uncheck_all' checkboxes, with checkValue set
// to "1" and "0" respectively
function setAllCheckboxes(checked, allKey, nothingKey, question, checkValue){
    if(checked){
        
        // Setting all other checkboxes to checkValue
        check_boxes = $("#answer_"+question+"_input").find("input[type=checkbox]:not(:disabled)")        
        for (i = 0; i < check_boxes.length; i++) {
          if (check_boxes[i].id != "answer_"+nothingKey && check_boxes[i].id != "answer_"+allKey){
            $(check_boxes[i]).attr("checked", checkValue);
            handleDisableCheckboxSubQuestions(check_boxes[i]);
          }
        }
        
        // Setting the 'check_all' and the 'uncheck_all' checkboxes appropriately, if both are used
        correctAllNothingCheckboxes(checkValue == "1", allKey, nothingKey);
    }
}

//This function is set to the onClick of all checkboxes besides the 'check_all' or 'uncheck_all' checkboxes
//to appropriately set the 'check_all' or 'uncheck_all' checkboxes if a checkbox changes
//1: If a checkbox is checked, the 'uncheck_all' checkbox should be unchecked
//2: If a checkbox is unchecked, the 'check_all' checkbox should be unchecked
function correctAllNothingCheckboxes(checked, allKey, nothingKey){
    if(checked){
        var el = $('#answer_'+nothingKey)[0];
        $(el).attr("checked", "");
        handleDisableCheckboxSubQuestions(el);
    } else {
        var el = $('#answer_'+allKey)[0];
        $(el).attr("checked", "");
        handleDisableCheckboxSubQuestions(el);
    }
}

function hashchangeEventHandler(){
    if (hashChangeEnabled) {
        // if we have a window.location.hash, and we can find a panel for that hash, switch to that panel
        if (window.location.hash != "" && window.location.hash != $(".panel:first").id) {
            panel = $(".panel#" + window.location.hash);
            if (panel[0]) {
                activatePanel(panel, true, true);
            }
        } else { // if we have no hash, activate the first panel
            activatePanel($(".panel:first"), false, true);
        }
    } else {
        hashChangeEnabled = true;
    }       
}

function handleHideQuestions(element, hidekeys, allkeys){
    $.each(allkeys, function(){
        if (element.checked) {
            $("#answer_" + this + "_input").closest('.item').removeClass('hidden');
        }
    });
    $.each(hidekeys, function(){
        if (element.checked) {
            $("#answer_" + this + "_input").closest('.item').addClass('hidden');
        }
    });    
}

function handleDisableRadioSubQuestions(element){
    if(element.checked){
        $(element).closest('.item').find('.subinput').attr("disabled", "true");
        $(element).closest('.option').find('.subinput').attr("disabled", "");
    } 
}

function handleDisableCheckboxSubQuestions(element){
    if(element.checked){
        $(element).parent().find('.item input').attr("disabled", "");       
    } else {
        $(element).parent().find('.item input').attr("disabled", "true");
    }
}

function selectInput(value){
    var values = lastFocus.find(".value");
    values.each(function(index, element){
       if(parseInt(element.textContent) == value){
           $(element).closest(".option").find("input:not(.subinput, :hidden, :disabled)").click();
       }
    });
    
    if(values.length == 0){
        lastFocus.find("input:not(.subinput, :hidden, :disabled)").get(value).click();
    }
}

function handleHotKeys(event){
    
    event.which = event.which || event.keyCode;
    
    switch (event.which) {
        //enter
        case 13:            
            if (!(nextButtonFocussed || saveButtonFocussed)) {
                event.preventDefault();
                focusNextInput();
            }
            break;
        //0
        case 48:
        case 96:
            selectInput(0);
            break;
        //1
        case 49:
        case 97:        
            selectInput(1);
            break;
        //2
        case 50:
        case 98:
            selectInput(2);
            break;
        //3
        case 51:
        case 99:
            selectInput(3);
            break;
        //4
        case 52:
        case 100:
            selectInput(4);
            break;
        //5
        case 53:
        case 101:
            selectInput(5);
            break;
        //6
        case 54:
        case 102:
            selectInput(6);
            break;
        //7
        case 55:
        case 103:
            selectInput(7);
            break;
        //8
        case 56:
        case 104:
            selectInput(8);
            break;
        //9
        case 57:
        case 105:
            selectInput(9);
            break;
        //pg up, up arrow
        case 33:
        case 38:
            focusPrevInput();
            event.preventDefault();
            break;
        //pg dwn, down arrow
        case 34:
        case 40:
            focusNextInput();
            event.preventDefault();
            break;
        //space
        case 32:
            break;    
    }
}

function focusItem(qitem){
    if (qitem.length > 0) {
        if (lastFocus != undefined) {
            lastFocus.removeClass('focus');
        }
        qitem.addClass('focus');
        qitem.closest('.item')[0].scrollIntoView(false);
        lastFocus = qitem;
    }
    return qitem;
}

function focusNextItem(){
    var item;
    if (nextButtonFocussed) {
        item = $('.item:not(:hidden, .text)').find('.description-and-fields:not(:hidden)').first();
        nextButtonFocussed = false;
    } else {
        item = lastFocus.closest(".item:not(:hidden, .text)").nextAll().find('.description-and-fields:not(:hidden)').first();   
    }
    if(item.length == 0){
        if (isBulk) {
            item = lastFocus.closest(".panel").next().find('.description-and-fields:not(:hidden)').first();
            if (item.length > 0) {
                return focusItem(item);
            } else {
                $(".save input").focus();
                saveButtonFocussed = true;
            }
        } else {
            lastFocus.removeClass('focus');
            $(".next input").focus();
            nextButtonFocussed = true;
        }
    } else {
        return focusItem(item);
    }
}
function focusPrevItem(){
    var item;
    if (nextButtonFocussed || saveButtonFocussed) {
        item = $('.item:not(:hidden, .text)').find('.description-and-fields:not(:hidden)').last();
        nextButtonFocussed = false;
        saveButtonFocussed = false;
    } else {
        item = lastFocus.closest(".item:not(:hidden, .text)").prevAll().find('.description-and-fields:not(:hidden)').first();
    }
    
    if(item.length == 0){
        if (isBulk) {
            item = lastFocus.closest(".panel").prev().find('.description-and-fields:not(:hidden)').last()
            
            return focusItem(item);
        } else {
            lastFocus.removeClass('focus');
            $(".next input").focus();
            nextButtonFocussed = true;
        }
    } else {
        return focusItem(item);
    }
}

function focusNextInput(){
    var input = lastInput.nextAll('input:not(:disabled, :hidden)').first().focus();
    
    if(input.length == 0){
        var item = focusNextItem();
        if(item != undefined){
            input = item.find("input:not(:disabled, :hidden)").first().focus();             
        }
    }
    if (input.length != 0) {
        lastInput = input;
    } 
}
function focusPrevInput(){
    var input = lastInput.prevAll('input:not(:disabled, :hidden)').last().focus();
    
    if(input.length == 0){ 
        var item = focusPrevItem();
        if(item != undefined){
            input = item.find("input:not(:disabled, :hidden)").last().focus();
        }
    }
    if (input.length != 0) {
        lastInput = input;
    } 
}

$(document).ready(
    function() {
        $('.subinput').attr("disabled", "true");
        $('input[type="radio"]').each( function(index, element){            
           handleDisableRadioSubQuestions(element);
        });
        //TODO: change this once the 'click to deselect radio inputs' feature is in
        $('input[type="radio"]:checked').click();
        
        $('input[type="checkbox"]').each( function(index, element){
           handleDisableCheckboxSubQuestions(element);
        });
        
        isBulk = $('form.bulk').size() > 0;
        // Don't hide panels when we're doing a bulk version
        if (!isBulk) {
            hashChangeEnabled = true;
            jQuery(window).bind( 'hashchange', hashchangeEventHandler);
            //$.address.change( 'hashchange', hashchangeEventHandler);

            // enable javascript-based previous/next links
            $(".panel .buttons").show();

            // hide all panels
            $(".panel").hide();

            // hide first previous button, and last next button
            $(".panel:first .buttons .prev").hide();
            $(".panel:last  .buttons .next").hide();
        
            // Trigger the hashchange event (useful on page load).
            $(window).hashchange();
            
            // show previous panel
            $(".panel .prev input").click(
                function(event) {
                    event.preventDefault();
                    var prevPanel = $(this).parents('.panel').prev()
                    activatePanel(prevPanel, true, false);
                }
            );

            // show next panel
            $(".panel .next input").click(
                function(event) {
                    event.preventDefault();
                    var nextPanel = $(this).parents('.panel').next();
                    if (validatePanel($(this).parents('.panel')[0])) {
                        activatePanel(nextPanel, true, true);                        
                    }          
                }
            );
        }
        
        //Layout breaks with this
        //$("input[type=radio]").customInput();
        //$("input[type=checkbox]").customInput();
        
        $("input").keypress(handleHotKeys);
        
        $(".item input").click(function(event){
            focusItem($(event.target).closest(".description-and-fields").first());
            lastInput = $(event.target);
        });
    }
);

