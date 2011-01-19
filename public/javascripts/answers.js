// Scope:
//
//   questionnaires/1/answers/edit
var hashChangeEnabled;
var lastFocus;
var lastInput;
var nextButtonFocussed = false;
var saveButtonFocussed = false; 
var isBulk;
var qitems; 
var fail_vals = new Array();
var validationI = 0;
var hotkeysEnabled;
var radioChecked;
var setCurrent;
var setCheck;

function activatePanel(panel, updateHash, forward) {
    $('.panel').hide().removeClass('current');
    panel.show().addClass('current');
    
    //If all questions on this panel are hidden, skip to the next or previous panel based on 'forward'
    var hiddenInputs = $(panel).find(".item input:hidden");
    if (hiddenInputs.length > 0 && hiddenInputs.length == $(panel).find(".item input").length) {
        if (forward) {
            return activatePanel($(panel).next(), updateHash, true);            
        } else {
            return activatePanel($(panel).prev(), updateHash, false);
        }
    }
    
    //TODO make window scroll to top at every new panel
    //window.scrollTo(0,0);
    
    if (updateHash) {
        hashChangeEnabled = false;
        window.location.hash = panel[0].id;        
    }
    
    nextButtonFocussed = false;
    saveButtonFocussed = false;
    if (hotkeysEnabled) {
        qitems = panel.find(".description-and-fields:not(:hidden)");
        focusItem(qitems.first());
        lastInput = qitems.find("input:not(:disabled, :hidden)").first().focus();
    }    
}

function pushFailVal(val){
    fail_vals[validationI] = val;
    validationI++;
}

function is_answered(inputs, question_item){
    for (var j = 0; j < inputs.length; j++){
        var input = inputs[j];
        if(input.type === "text" && question_item.is(".string, .text, .integer, .float, .date")){
            if (input.value != "") {
                return true;
            }
        }
        if((input.type === "radio" && question_item.is(".radio, .scale")) || (input.type === "checkbox" && question_item.hasClass("check_box"))){
            if (input.checked) {
                return true;
            }
        }
    }
    return inputs.length == 0;
}

function validatePanel(panel) {
  var failed = false;
  validationI = 0;
  $(panel).find(".error").addClass("hidden");
  $(panel).find(".item").removeClass("errors");
  if (panel_validations[panel.id]) {
    var validations = panel_validations[panel.id];
        
    for (var question_key in validations) {
      var question_item = $("#answer_" + question_key + "_input").closest('.item');
      
      var inputs = question_item.find("input").not(":disabled, :hidden");      
      fail_vals = new Array();
      
      for (var i in validations[question_key]) {
        var validation = validations[question_key][i];
        switch(validation.type) {
            case "requires_answer":
                if (!is_answered(inputs, question_item)) {
                  pushFailVal(validation.type);
                }
                break;          
            case "minimum":
                var input = inputs[0];
                if(input === undefined || input.value == ""){
                    continue;
                }
                if(parseFloat(input.value) < validation.value){
                    pushFailVal(validation.type);
                }
                break;
            case "maximum":
                var input = inputs[0];
                if(input === undefined || input.value == ""){
                    continue;
                }
                if(parseFloat(input.value) > validation.value){
                    pushFailVal(validation.type);
                }
                break;
            case "regexp":
                var regex = eval(validation.matcher);
                var value = undefined;
                if (inputs.length == 3 && (inputs[0].value != "" || inputs[1].value != "" || inputs[2].value != "")) {
                    var vals = [];
                    inputs.map(function(index, ele){vals.push(ele.value)});
                    value = vals.join("-");
                } else if (inputs.length == 1){
                    value = inputs[0].value;
                }
                if(value == undefined || value == ""){
                    continue;
                }
                var result = regex.exec(value);
                if(result === null || result[0] != value){
                    pushFailVal(validation.type);
                }
                break;
            case "valid_integer":
                var input = inputs[0];
                if(input === undefined || input.value == ""){
                    continue;
                }
                var rgx = /(\s*-?[1-9]+[0-9]*\s*|\s*-?[0-9]?\s*)/;
                var result = rgx.exec(input.value);
                if(result == null || result[0] != input.value){
                    pushFailVal(validation.type);
                }             
                break;
            case "valid_float":
                var input = inputs[0];
                if(input === undefined || input.value == ""){
                    continue;
                }
                var rgx = /(\s*-?[1-9]+[0-9]*\.[0-9]+\s*|\s*-?[1-9]+[0-9]*\s*|\s*-?[0-9]\.[0-9]+\s*|\s*-?[0-9]?\s*)/;
                var result = rgx.exec(input.value);
                if(result === null || result[0] != input.value){
                    pushFailVal(validation.type);
                }
                break;
            case "one_of":
                var input = inputs[0];
                if(input == undefined || input.value == ""){
                    continue;
                }
                if(validation.array.indexOf(parseFloat(input.value)) == -1){
                    pushFailVal(validation.type);
                }
                break;
            case "answer_group_minimum":
                var count = get_answer_count(validation.group, panel);
                if(count < validation.value){
                    pushFailVal(validation.type);
                }
                break;
            case "answer_group_maximum":
                var count = get_answer_count(validation.group, panel);
                if(count > validation.value){
                    pushFailVal(validation.type);
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

function get_answer_count(groupkey, panel){
    var answered = 0;
    
    var quest_items = $(panel).find(".item."+ groupkey);
    for(var i = 0; i < quest_items.length; i++){
        var inputs = $(quest_items[i]).find(" input").not(":disabled, :hidden")
        if (is_answered(inputs, quest_items.eq(i))) {
            answered++;
        }
    }
    
    return answered;
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
        if (el) {
            $(el).attr("checked", "");
            handleDisableCheckboxSubQuestions(el);
        }
    } else {
        var el = $('#answer_'+allKey)[0];
        if (el) {
            $(el).attr("checked", "");
            handleDisableCheckboxSubQuestions(el);
        }
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
        $(element).closest('.option').find('.subinput').attr("disabled", "");       
    } else {
        $(element).closest('.option').find('.subinput').attr("disabled", "true");
    }
}

function selectInput(value){
    var values = lastFocus.find(".value");
    var selectedInput = $([]);
    values.each(function(index, element){
       if(parseInt(element.textContent) == value){
           selectedInput = $(element).closest(".option").find("input:not(.subinput, :hidden, :disabled)");           
       }
    });
    
    if(values.length == 0){
        selectedInput = lastFocus.find("input:not(.subinput, :hidden, :disabled)").eq(value-1);
    }
    if(selectedInput.length > 0) {
        setCurrent(selectedInput[0]);
        setCheck(selectedInput[0], selectedInput.is('.deselectable'));
        radioEvents(selectedInput[0]);
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

function handleHotKeys(event){
    
    event.which = event.which || event.keyCode;
    
    switch (event.which) {
        //enter
        case 13:            
            if (!(nextButtonFocussed || saveButtonFocussed)) {
                preventDefault(event)
                focusNextInput();
            }
            break;
        //pg up, up arrow
        case 33:
        case 38:
            preventDefault(event)
            focusPrevInput();
            break;
        //pg dwn, down arrow
        case 34:
        case 40:
            preventDefault(event)
            focusNextInput();
            break;
        //space
        case 32:
            break;    
    }
}
function handleRadioHotKeys(event){
    event.which = event.which || event.keyCode;
    
    switch (event.which) {
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
    }
}

function focusItem(qitem){
    if (qitem.length > 0) {
        if (lastFocus != undefined) {
            lastFocus.removeClass('focus');
        }
        qitem.addClass('focus');
        var toScrollTo = qitem.closest('.item')[0];
        //Might not work properly inside a frame?
        window.scrollTo(0, toScrollTo.offsetTop-80);
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

function getValidInputs(){
    return lastInput.closest(".description-and-fields.focus").find('input:not(:disabled, :hidden, [type=radio])');
}

function focusNextInput(){
    var input = getValidInputs();
    var index = input.index(lastInput);
    if (index != -1) {
        input = input.filter(":gt(" + index + ")").first().focus();
    } else {
        input.first().focus();
    }
    
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
    var input = getValidInputs();
    var index = input.index(lastInput);
    if (index != -1) {
        input = input.filter(":lt(" + index + ")").last().focus();
    } else {
        input.last().focus()
    }
    
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

function hotkeyDialog(){;
    $("#hotkeyDialog").dialog({ draggable : false, resizable : false, modal : true, width : 550,
    buttons: {
        "Sluiten": function(){
            $(this).dialog("close");
        }
    }
    });
}

function radioEvents(element){
    handleDisableRadioSubQuestions(element);
    handleHideQuestions(element, eval(element.getAttribute('hides')), eval(element.getAttribute('allhidden')));
}

$(document).ready(
    function() {
        
        //IE7 indexOf fix
        if(!Array.indexOf){
            Array.prototype.indexOf = function(obj){
                for(var i=0; i < this.length; i++){
                    if(this[i]==obj){
                        return i;
                    }
                }
            }
        }
        
        $('.subinput').attr("disabled", "true");
        $('input[type="radio"]').each( function(index, element){            
           handleDisableRadioSubQuestions(element);
        });
        $('input[type="radio"]').not("[value='DESELECTED_RADIO_VALUE']").click( function(){
           radioEvents(this);
        });
        $('input[type="radio"]:checked').click();


        var allDeselectableRadios = $('input[type=radio].deselectable');
        
        setCurrent = function(obj) {
            radioChecked = $(obj).attr('checked');
        };
                            
        setCheck = function(obj, deselectable) {            
            if (radioChecked) {
                if (deselectable) {
                    $(obj).attr('checked', false);
                    $(obj).closest(".fields").find("input[value=DESELECTED_RADIO_VALUE]").attr('checked', true);
                }
            } else {
                $(obj).closest(".fields").find("input[value=DESELECTED_RADIO_VALUE]").attr('checked', false);
                $(obj).attr('checked', true);
            }
        };    
                             
        $.each(allDeselectableRadios, function(i, val){
            var label = $('label[for=' + $(this).attr("id") + ']');
            
            $(this).bind('mousedown', function(e){
                setCurrent(e.target);
            });
            
            label.bind('mousedown', function(e){
                e.target = $('#' + $(this).attr("for"));
                setCurrent(e.target);
            });
            
            $(this).bind('click', function(e){
                setCheck(e.target, true);    
            });
        });
        
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
            
            //Go to first panel with errors
            var errors = $('.errors');
            if (errors.length > 0){
                activatePanel(errors.closest('.panel').eq(0), true, true);
            }
        }
        
        //Layout breaks with this
        //$("input[type=radio]").customInput();
        //$("input[type=checkbox]").customInput();
        hotkeysEnabled = $("#hotkeyDialogLink").length > 0;
        if (hotkeysEnabled) {
            $("input").keydown(handleHotKeys);
            $("input[type=radio]").keypress(handleRadioHotKeys);
            
            
            $(".item input").click(function(event){
                focusItem($(event.target).closest(".description-and-fields").first());
                lastInput = $(event.target);
            });
        }
    }
);

