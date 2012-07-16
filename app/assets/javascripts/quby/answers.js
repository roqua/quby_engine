// Scope:
//
//   questionnaires/1/answers/edit
var curPanel;
var panelInputs;
var focusI = 0;

var hashChangeEnabled;
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

function loadcssfile(filename){
 var fileref=document.createElement("link");
  fileref.setAttribute("rel", "stylesheet");
  fileref.setAttribute("type", "text/css");
  fileref.setAttribute("href", filename);

 if (typeof fileref!="undefined")
  document.getElementsByTagName("head")[0].appendChild(fileref);
}

//For displaying answers differently within iframes
if( self != top ) {
   loadcssfile("/assets/quby/answer_iframe.css");
   inIframe = true;
}

function allInputsHidden(panel){
    var hiddenInputs = $(panel).find(".item input:hidden, .item textarea:hidden, .item select:hidden");
    return hiddenInputs.length > 0 && hiddenInputs.length == $(panel).find(".item input, .item textarea, .item select").length;
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
    curPanel = panel;
    if (hotkeysEnabled) {
        panelInputs = getValidInputs();
        focusI = 1;
        focusInputIndex(focusI, true);
    }
}

function pushFailVal(val){
    fail_vals[validationI] = val;
    validationI++;
}

function is_answered(inputs, item){
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
        if(input.is("select")){
          if (item.data('placeholder') != input[0].value){
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
        if(!is_answered(dep_inputs, question_item) || dep_inputs.length == 0){
            continue;
        }
      }

      if(question_item.length == 0){
          question_item = panel.find("[data-for=" + question_key + "]");
      }

      var inputs = question_item.find("input, textarea, select").not(":disabled, :hidden");

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
          var item = question_item.addClass('errors');
          $(fail_vals).each(function(index, ele){
              item.find(".error." + ele).first().removeClass("hidden");
          });
          failed = true;
      }
    }
  }
  //To correctly reposition the placeholders
  //placeholder();
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

function hashchangeEventHandler(){
    if (hashChangeEnabled) {
        // if we have a window.location.hash, and we can find a panel for that hash, switch to that panel
        if (window.location.hash != "" && window.location.hash != $(".panel:first").id) {
            var panel = $(".panel#" + window.location.hash);
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

// Array Remove - By John Resig (MIT Licensed)
Array.prototype.remove = function(from, to) {
  var rest = this.slice((to || from) + 1 || this.length);
  this.length = from < 0 ? this.length + from : from;
  return this.push.apply(this, rest);
};

function handleHideQuestions(element, hidekeys, allkeys){
    $.each(allkeys, function(){
        var item = $("#answer_" + this + "_input").closest('.item:not(.table)');

        if(item.length == 0){ //table
            item = $("[data-for^='" + this + "']")
        }

        var hiddenby = item.first().data('hiddenBy');
        hiddenby = hiddenby || [];

        var loc = $.inArray(element.attr('name'), hiddenby);
        if(loc != undefined && loc != -1){
          hiddenby.remove(loc,loc);
          item.first().data('hiddenBy', hiddenby);
        }

        if (hiddenby.length == 0) {
            item.removeClass('hidden-childs');
        }

        var panel;
        if( isBulk && allInputsHidden(panel = item.closest(".panel")) ){
          panel.show();
        }
    });

    $.each(hidekeys, function(){
        if (element.attr('checked')) {
            var item = $("#answer_" + this + "_input").closest('.item');

            if(item.length == 0){ //table
                item = $("[data-for^='" + this + "']")
            }

            var hiddenby = item.first().data('hiddenBy');
            hiddenby = hiddenby || [];
            var loc = $.inArray(element.attr('name'), hiddenby);
            if(loc == undefined || loc == -1){
                hiddenby.push(element.attr('name'));
                item.first().data('hiddenBy', hiddenby);
            }

            item.addClass('hidden-childs');

            var panel;
            if( isBulk && allInputsHidden(panel = item.closest(".panel")) ){
              panel.hide();
            }
        }
    });
}


function radioCheckboxEvents(event){
    var element = $(event.target || event);
    if(element.is("[type=radio]")){
        handleDisableRadioSubQuestions(element);
    } else {
        handleDisableCheckboxSubQuestions(element);
    }
    handleHideQuestions(element, eval(element.attr('hides')) || [], eval(element.attr('unhides')) || []);
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

function selectInput(value){
    var lastFocus = $('.focus');
    var values = lastFocus.find(".value");
    var selectedInput = $([]);
    values.each(function(index, element){
       if(parseInt(element.textContent || element.innerHTML) == value){
           selectedInput = $(element).closest(".option").find("input[type='radio'][name='"+lastInput[0].name+"']:not(.subinput, :hidden, :disabled)");
       }
    });

    if(selectedInput.length == 0){
        selectedInput = lastFocus.find("input[type='radio'][name='"+lastInput[0].name+"']:not(.subinput, :hidden, :disabled)").eq(value-1);
    }
    if(selectedInput.length > 0) {
        setCurrent(selectedInput[0]);
        setCheck(selectedInput[0], selectedInput.is('.deselectable'));
        radioCheckboxEvents(selectedInput[0]);
        focusNextInput();
    }
}

function selectFocusedInput(){
    var el = $(document.activeElement);
    setCurrent(el);
    setCheck(el, el.is("input[type='checkbox'], .deselectable"));
    radioCheckboxEvents(el);
    focusNextInput();
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

function handleDownHotKeys(event){
    event.which = event.charCode || event.which || event.keyCode;
    if ($(lastInput).is("textarea") || $(lastInput).is("input[type=submit]") && (event.which == 32 || event.which == 13)) {
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
            if (!$(lastInput).is("select")) {
                preventDefault(event);
                focusPrevInput();
            }
            break;
        case 37: // left arrow
            if (!$(lastInput).is("input[type=text]") && !$(lastInput).is("input[type=range]")) {
                preventDefault(event);
                focusPrevInput();
            }
            break;
        //pg dwn, down arrow
        case 34:
        case 40:
            if (!$(lastInput).is("select")) {
                preventDefault(event);
                focusNextInput();
            }
            break;
        case 39: //right arrow
            if (!$(lastInput).is("input[type=text]") && !$(lastInput).is("input[type=range]")) {
                preventDefault(event);
                focusNextInput();
            }
            break;
        //space
        case 32:
            if(!$(lastInput).is("input[type=text], select")){
                preventDefault(event);
            }
            break;
    }
}
function handleUpHotKeys(event){
    event.which = event.which || event.keyCode;
    if ($(lastInput).is("input[type=submit]") && (event.which == 32 || event.which == 13)){
        event.target.click();
        return;
    } else if($(lastInput).is("textarea, input[type=text]")){
        return;
    }

    if ($(lastInput).is("[type='radio']")) {
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
    //space
    if(event.which == 32){
            preventDefault(event);
            selectFocusedInput();
    }
}

function focusInput(input){
    $('.focus').removeClass('focus');
    focusI = panelInputs.index(input);
    if(focusI == -1 && $(input).is("[type=radio]")){
        input = $(input).closest('.fields').find('[type=radio]:first');
        focusI = panelInputs.index(input);
    }
    if($(input).is("[type='submit']")){
        $('.buttons').addClass('focus');
    } else if ($(input).is("[type='checkbox']")) {
        $(input).closest('.option').addClass('focus');
    } else {
        var focus = $(input).closest('.item:not(.table)');
        if (focus.length == 0) {
            var qname = $(input).closest('td.option').data('for');
            curPanel.find('td.option[data-for="' + qname + '"]').addClass('focus');
        } else {
            focus.addClass('focus');
        }
    }
    lastInput = $(input);
}

function focusInputIndex(index, forward){
    if (forward) {
        lastInput = panelInputs.filter(':eq('+index+'), :gt(' + index + ')').not(':hidden, :disabled').first();
    } else {
        lastInput = panelInputs.filter(':eq('+index+'), :lt(' + index + ')').not(':hidden, :disabled').last();
    }

    if (index < 0 || index > panelInputs.length || lastInput.length == 0) {
        if(forward){
            index = 0
            lastInput = panelInputs.filter(':eq('+index+'), :gt(' + index + ')').not(':hidden, :disabled').first();
        } else {
            index = panelInputs.length -1;
            lastInput = panelInputs.filter(':eq('+index+'), :lt(' + index + ')').not(':hidden, :disabled').last();
        }
    }
    if (lastInput.length > 0) {
        //IE7 disabled element focus hack
        $(lastInput[0]).show();
        lastInput[0].focus();

        saveButtonFocussed = lastInput.is('#done-button');
        nextButtonFocussed = lastInput.is('.next');
        focusI = panelInputs.index(lastInput);
    }
}

function getValidInputs(){
    var inputs = curPanel.find('input:not([value="DESELECTED_RADIO_VALUE"], [id^="abortButton"]), textarea, select');
    var hadRadioQ = [];
    inputs = inputs.filter(function (index){
        if (this.type == "radio") {
            var valid = $.inArray(this.name, hadRadioQ) == -1;
            hadRadioQ.push(this.name);
            return valid;
        }
        return true;
    });

    var backI = inputs.index(inputs.filter('#back, [id^="prevButton"]').not(':hidden'));
    if(backI != -1){
        inputs = inputs.toArray();
        inputs.unshift(inputs.splice(backI, 1)[0]);
        inputs = $(inputs);
    }

    return inputs;
}

function focusNextInput(){
    lastInput.blur();
    setTimeout(function() { focusInputIndex(focusI+1, true);}, 50);
}
function focusPrevInput(){
    lastInput.blur();
    setTimeout(function() { focusInputIndex(focusI-1, false);}, 50);
}

function hotkeyDialog(){;
    $(".hotkeyDialog").last().dialog({ draggable : false, resizable : false, modal : true, width : 550,
    buttons: {
        "Sluiten": function(){
            $(this).dialog("close");
        }
    }
    });
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
          registerDeselectables();
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
    if(hotkeysEnabled) {
      curPanel = $('form');
      panelInputs = getValidInputs();
      focusI = 0;
      focusInputIndex(focusI, true);
    }
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

//ONLY USE FOR KEYUP AND KEYDOWN
function handlePreventDefault(event){

    event.which = event.which || event.keyCode;

    if($(event.target).is('textarea')){
        return;
    }
    switch (event.which) {
        //enter
        case 13:
            preventDefault(event);
            break;
        //pg up, up arrow
        case 33:
        case 38:
        //pg dwn, down arrow
        case 34:
        case 40:
        //space
        case 32:
            break;
    }
}

function registerDeselectables(){
    //FIXME: honos65+ performance opportunity
    //lots of labels are selected individually
    $('input[type=radio].deselectable').each( function(i, val){
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
}

function showPrint(url){
  var result = $(document.createElement("div"));
    result.load(url, $('form').serializeArray(), function(){
        if(result.find(".errors").length == 0){
          $('.x_container').html(result.find("#content").html());
          if(document.recalc){
            document.recalc();
          }
          $('.x_container').show();
        }
    });
}

var leave_page_text;
$(document).ready(
    function() {

        $('input').placeholder();

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
        hotkeysEnabled = $(".hotkeyDialog").length > 0;

        setCurrent = function(obj) {
            radioChecked = $(obj).attr('checked');
        };

        setCheck = function(obj, deselectable) {
            if (radioChecked){
                if (deselectable) {
                    $(obj).removeAttr('checked');
                    $("input[name='"+obj.name+"'][value='DESELECTED_RADIO_VALUE']").attr('checked', 'checked');
                }
            } else {
                $("input[name='"+obj.name+"'][value='DESELECTED_RADIO_VALUE']").removeAttr('checked');
                $(obj).attr('checked', 'checked');
            }
        };

        registerDeselectables();

        $('input[type="radio"][value!="DESELECTED_RADIO_VALUE"]:not(.subinput), input[type="checkbox"]:not(.subinput)').live("click", radioCheckboxEvents );

        processExtraData();

        isBulk = $('form.bulk, form.print').size() > 0;
        if (hotkeysEnabled) {
            $("body").live("keydown", handleDownHotKeys);
            $("body").live("keyup", handleUpHotKeys);
            $("body").live("click", function (){
                nextButtonFocussed = false;
                saveButtonFocussed = false;
            })
            $(".item input, .item textarea, .buttons input, select").live("click", function(event){
                focusInput(event.target);
            })
            $(".item input, .item textarea, .buttons input, select").live("focus", function(event){
                focusInput(event.target);
            });
        }

        if (isBulk) {
            prepareBulk();
        } else{
            hashChangeEnabled = true;
            if (inIframe) {
                activatePanel($(".panel:first"), false, true);
            } else {
                jQuery(window).bind('hashchange', hashchangeEventHandler);
            }
            //$.address.change( 'hashchange', hashchangeEventHandler);
            // Trigger the hashchange event (useful on page load).
            $(window).hashchange();

            // show previous panel
            $(".panel .prev input").live("click",
                function(event) {
                    event.preventDefault();
                    var prevPanel = $(this).parents('.panel').prev()
                    activatePanel(prevPanel, true, false);
                }
            );

            // show next panel
            $(".panel .next input").live("click",
                function(event) {
                    event.preventDefault();
                    var nextPanel = $(this).parents('.panel').next();
                    if (validatePanel($(this).parents('.panel').first())) {
                        activatePanel(nextPanel, true, true);
                    }
                }
            );

            preparePaged();
        }

        $('input[type="checkbox"]:not(.subinput), input[type="radio"][value!="DESELECTED_RADIO_VALUE"]:not(.subinput)').each( function(index, element){
           radioCheckboxEvents(element);
        });

        $(document).keydown(handlePreventDefault);
        $("input[text_var]").each(function(i, ele){
            ele = $(ele);
            var tvar = ele.attr('text_var');
            ele.blur(function (){
                $("span[text_var='"+tvar+"']").attr('innerHTML', ele.attr('value'));
            });
        });

        // Don't submit if we've just submitted already
        var done_button_semaphore = true;
        $(".save input#done-button, .back input, .abort input").click(function(event){
            window.onbeforeunload = null;
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

