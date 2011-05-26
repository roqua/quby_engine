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
var skipValidations = false;
var shownFlash = false;
var inIframe = false;

//For displaying answers differently within iframes 
if( self != top ) {
   $('head').append('<link type="text/css" rel="stylesheet" href="/stylesheets/answer_iframe.css">');
   inIframe = true;
}

function allInputsHidden(panel){
    var hiddenInputs = $(panel).find(".item input:hidden, .item textarea:hidden");
    return hiddenInputs.length > 0 && hiddenInputs.length == $(panel).find(".item input, .item textarea").length;
}

function activatePanel(panel, updateHash, forward) {
    if (shownFlash) {
        $('.flash').hide();
    }
    shownFlash = true;
    $('.panel').hide().removeClass('current');
    panel.show().addClass('current');
    
    //If all questions on this panel are hidden, skip to the next or previous panel based on 'forward'
    if (allInputsHidden(panel)) {
        if (forward) {
            return activatePanel($(panel).next(), updateHash, true);            
        } else {
            return activatePanel($(panel).prev(), updateHash, false);
        }
    }
    
    if (updateHash && !inIframe) {
        hashChangeEnabled = false;
        window.location.hash = panel[0].id;        
    }
    window.scrollTo(0,0);    
    
    nextButtonFocussed = false;
    saveButtonFocussed = false;
    if (hotkeysEnabled) {
        qitems = panel.find(".item:not(:hidden, .subitem, .text)");
        focusItem(qitems.first());
        lastInput = getValidInputs().first().focus();
    }    
}

function pushFailVal(val){
    fail_vals[validationI] = val;
    validationI++;
}

function is_answered(inputs){
    for (var j = 0; j < inputs.length; j++){
        var input = $(inputs[j]);
        if(input.is("[type=text], textarea")){
            if (input.attr("value") != "") {
                return true;
            }
        }
        if(input.is("[type=radio]") || input.is("[type=checkbox]")){
            if (input.attr("checked")) {
                return true;
            }
        }
    }
    return inputs.length == 0;
}

function validatePanel(panel) {
  if(skipValidations){
      return true;
  }
  var failed = false;
  validationI = 0;
  panel.find(".error").addClass("hidden");
  panel.find(".errors").removeClass("errors");
  if (panel_validations[panel.attr("id")]) {
    var validations = panel_validations[panel.attr("id")];
        
    for (var question_key in validations) {
      if(validations[question_key].length == 0){
          continue;
      }
      
      var question_item = $("#answer_" + question_key + "_input").closest('.item');
      
      var depends_on = eval(question_item.attr("data-depends_on"));
      if(depends_on){
        var dep_inputs = $($.map(depends_on, function(key){
            return $("#answer_"+key).not(":disabled, :hidden");
        }));
        if(!is_answered(dep_inputs) || dep_inputs.length == 0){
            continue;
        }
      }
      
      if(question_item.length == 0){
          question_item = panel.find("[data-for=" + question_key + "]");
      }
      
      var inputs = question_item.find("input, textarea").not(":disabled, :hidden");
      
      fail_vals = new Array();
      
      for (var i in validations[question_key]) {
        var validation = validations[question_key][i];
        switch(validation.type) {
            case "requires_answer":
                if (!is_answered(inputs)) {
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
          var item = question_item.addClass('errors');
          $(fail_vals).each(function(index, ele){
              item.find(".error." + ele).first().removeClass("hidden");
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
    
    var quest_items = panel.find(".item."+ groupkey);
    for(var i = 0; i < quest_items.length; i++){
        var inputs = $(quest_items[i]).find(" input, textarea").not(":disabled, :hidden")
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
        if (element.attr('checked')) {
            $("#answer_" + this + "_input").closest('.item').removeClass('hidden');
        }
    });
    $.each(hidekeys, function(){
        if (element.attr('checked')) {
            $("#answer_" + this + "_input").closest('.item').addClass('hidden');
        }
    });    
}

function handleDisableRadioSubQuestions(element){
    if(element.attr('checked')){
        element.closest('.item').find('.subinput').attr("disabled", "true");
        element.closest('.option').find('.subinput').attr("disabled", "");
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
       
       if(parseInt(element.textContent || element.innerHTML) == value){
           selectedInput = $(element).closest(".option").find("input[type='radio']:not(.subinput, :hidden, :disabled)");           
       }
    });
    
    if(values.length == 0){
        selectedInput = lastFocus.find("input[type='radio']:not(.subinput, :hidden, :disabled)").eq(value-1);
    }
    if(selectedInput.length > 0) {
        setCurrent(selectedInput[0]);
        setCheck(selectedInput[0], selectedInput.is('.deselectable'));
        radioEvents(selectedInput[0]);
        lastFocus.find('.first.option input').focus();
        focusNextInput();   
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

function handlePreventDefault(event){
    
    event.which = event.which || event.keyCode;
    
    switch (event.which) {
        //enter
        case 13:
        //pg up, up arrow
        case 33:
        case 38:
        //pg dwn, down arrow
        case 34:
        case 40:
            preventDefault(event);
            break;
        //space
        case 32:
            break;    
    }
}

function handleHotKeys(event){
    event.which = event.which || event.keyCode;
    if ($(lastInput).is("textarea")) {
        return;
    }
    
    switch (event.which) {
        //enter
        case 13:            
            if (!(nextButtonFocussed || saveButtonFocussed)) {
                preventDefault(event);
                focusNextInput();
            }
            break;
        //pg up, up arrow
        case 33:
        case 38:
            preventDefault(event);
            focusPrevInput();
            break;
        //pg dwn, down arrow
        case 34:
        case 40:
            preventDefault(event);
            focusNextInput();
            break;
        //space
        case 32:
            break;    
    }
}
function handleRadioHotKeys(event){
    event.which = event.which || event.keyCode;
    if (saveButtonFocussed || nextButtonFocussed || !$(lastInput).is("[type='radio']")){
        return;
    }
    
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
        var toScrollTo = qitem[0];
        //Might not work properly inside a frame?
        //window.scrollTo(0, toScrollTo.offsetTop-80);
        lastFocus = qitem;
    }
    return qitem;
}

function focusNextItem(){
    var item;
    if (nextButtonFocussed) {
        item = lastFocus.closest(".panel").find('.item:not(:hidden, .text)').first();
        nextButtonFocussed = false;
    } else {
        item = lastFocus.nextAll('.item:not(:hidden, .text, .subitem)').first();        
    }
    
    if(item.length == 0){
        if (isBulk) {
            item = lastFocus.closest(".panel").nextAll().find('.item:not(:hidden, .text, .subitem)').first();
            if (item.length > 0) {
                return focusItem(item);
            } else {
                lastFocus.removeClass('focus');
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
        //Takes a bit in IE7
        item = lastFocus.closest(".panel").find('.item:not(:hidden, .text)').last();
        nextButtonFocussed = false;
        saveButtonFocussed = false;
    } else {
        item = lastFocus.prevAll('.item:not(:hidden, .text, .subitem)').last();
    }
    
    if(item.length == 0){
        if (isBulk) {
            var curPanel = lastFocus.closest(".panel");
            item = curPanel.prev().find('.item:not(:hidden, .text, .subitem)').last();
            while (item.length == 0){
                curPanel = curPanel.prev();
                if(curPanel.length == 0){
                    break;
                }
                item = curPanel.prev().find('.item:not(:hidden, .text, .subitem)').last();                
            }
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
    if (lastFocus) { 
        return lastFocus.find('input:not(:disabled, :hidden, [type=radio]), textarea:not(:disabled, :hidden)').add(lastFocus.find('input:not(:disabled, :hidden)').first());
    } else {
        return $([]);
    }
}

function focusNextInput(){
    var input = getValidInputs();
    var index = input.index(lastInput);
    if (index >= 0) {
        input = input.filter(":gt(" + index + ")").first().focus();
    } else {
        input.first().focus();
    }
    
    if(input.length == 0){
        var item = focusNextItem();
        if(item != undefined){
            input = getValidInputs().first().focus();             
        }
    }
    if (input.length != 0) {
        lastInput = input;
    }
}
function focusPrevInput(){
    var input = getValidInputs();
    var index = input.index(lastInput);
    if (index >= 0) {
        input = input.filter(":lt(" + index + ")").last().focus();
    } else {
        input.first().focus()
    }
    
    if(input.length == 0){ 
        var item = focusPrevItem();
        if(item != undefined){
            input = getValidInputs().last().focus();
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

function radioEvents(event){
    var element = $(event.target || event);
    handleDisableRadioSubQuestions(element);
    handleHideQuestions(element, eval(element.attr('hides')) || [], eval(element.attr('allhidden')) || []);
}


//TODO: make this work for: 
//* enabling/disabling subquestions,
//* hiding other questions,
//* dates,
//* all/nothing checkboxes
function assignValue(qkey, val){
    //FIXME: also finds inputs named ex. v_11 when looking for inputs for v_1 
    var inputs = $("[name^='answer["+qkey+"'][type!='hidden']");
    if(inputs.length > 0){
        var type = inputs[inputs.length-1].type;
        if (type == "radio" || type == "scale") {
            var input = inputs.filter("[value='" + val + "']");
            if (input && input.length > 0) {
                input.get(0).checked = 'checked';
            }
        } else if (type == "text") {
            var input = inputs.get(0);
            input.value = val;
        } else if (type == "checkbox") {
            $.each(val, function(ckey, cvalue){
                var input = inputs.filter("input[name='answer["+ckey+"]']");
                input.attr("checked", cvalue == 1);
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

function doPrint(url){
    var form = $('form');
    var oldAction = form.attr('action');
    form.attr('action', url);
    form.attr('target', "_blank");
    form.submit();
    form.attr('action', oldAction);
    form.attr('target', "_top");
}

function modalFrame(url){
    $("#modalFrame").attr('src', url);
    $("#modalFrameDialog").dialog({ draggable : false, resizable : false, modal : true, width : 700, height : 900,
    buttons: {
        "Sluiten": function(){
            $(this).dialog("close");
        }
    }
    });
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
        
        $('input[type="radio"][value!="DESELECTED_RADIO_VALUE"]').click( radioEvents );        

        var allDeselectableRadios = $('input[type=radio].deselectable');
        
        setCurrent = function(obj) {
            radioChecked = $(obj).attr('checked');
        };
                            
        setCheck = function(obj, deselectable) {
            if (radioChecked) {
                if (deselectable) {
                    $(obj).attr('checked', false);
                    $("input[name="+obj.name+"][value=DESELECTED_RADIO_VALUE]").attr('checked', true);
                }
            } else {
                $("input[name="+obj.name+"][value=DESELECTED_RADIO_VALUE]").attr('checked', false);
                $(obj).attr('checked', true);
            }
        };    

        //FIXME: honos65+ performance opportunity
        //lots of labels are selected individually,
        allDeselectableRadios.each( function(i, val){
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
        
        processExtraData();
        
        isBulk = $('form.bulk, form.print').size() > 0;
        if (!isBulk) {
            hashChangeEnabled = true;
            if (inIframe) {
                activatePanel($(".panel:first"), false, true);
            } else {
                jQuery(window).bind('hashchange', hashchangeEventHandler);
            }
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
                    if (validatePanel($(this).parents('.panel').first())) {
                        activatePanel(nextPanel, true, true);                        
                    }          
                }
            );
            
            //Go to first panel with errors
            var errors = $('.errors');
            if (errors.length > 0){
                shownFlash = false;
                activatePanel(errors.closest('.panel').eq(0), true, true);
            }
        }
        
        $(document).keypress(handlePreventDefault);        
        //Layout breaks with this
//        $(".radiocheckwrapper input[type=radio]").customInput();
//        $("input[type=checkbox]").customInput();
        hotkeysEnabled = $("#hotkeyDialogLink").length > 0;
        if (hotkeysEnabled) {
            $(document).keydown(handleHotKeys);
            $(document).keyup(handleRadioHotKeys);
            $(document).click(function (){
                nextButtonFocussed = false;
                saveButtonFocussed = false;
            })
            $(".item input, .item textarea").click(function(event){
                focusItem($(event.target).closest(".item:not(:hidden, .text, .subitem)").first());
                lastInput = event.target;    
            }).focus(function(event){
                focusItem($(event.target).closest(".item:not(:hidden, .text, .subitem)").first());
                lastInput = event.target;
            });
            $("label.main").click(function(event){
                focusItem($(event.target).closest(".item:not(:hidden, .text, .subitem)").first());
                lastInput = getValidInputs().first();
                lastInput.focus();       
            });
            if (isBulk) {
                focusItem($('.panel').find(".item:not(:hidden, .text, .subitem)").first());
                lastInput = getValidInputs().first();
                lastInput.focus();
            }
        }
        
        $("input[text_var]").each(function(i, ele){
            ele = $(ele);
            var tvar = ele.attr('text_var');
            ele.blur(function (){
                $("span[text_var='"+tvar+"']").attr('innerHTML', ele.attr('value'));
            });  
        });

        // Don't submit if we've just submitted already
        var done_button_semaphore = true;
        $(".save input#done-button").click(function(event){
          if (done_button_semaphore){
            done_button_semaphore = false
            setTimeout("done_button_semaphore = true;", 3000)
            return true;
          } else {
            return false;
          }
        });
    }
);

