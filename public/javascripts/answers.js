// Scope:
//
//   questionnaires/1/answers/edit
var hashChangeEnabled;
function activatePanel(panel, updateHash, forward) {
    $('.flash').hide();
    $('.panel').hide().removeClass('current');
    panel.show().addClass('current');
    
    var hiddenInputs = $(panel).find(".question-item.hidden");
    if (hiddenInputs.length > 0 && hiddenInputs.length == $(panel).find(".question-item").length){
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
    
    if(panel.hasClass('last-panel')){
        $(".buttons").show();
    } else {
        $(".buttons").hide();
    }
}

function validatePanel(panel) {
  var fail_vals;
  var failed = false;
  $(".error").addClass("hidden");
  $(".item").removeClass("errors");
  if (panel_validations[panel.id]) {
    validations = panel_validations[panel.id];
        
    for (var question_key in validations) {
      var inputs = $("#answer_"+question_key+"_input input:not(.subinput)");      
      fail_vals = [];
      
      for (var i in validations[question_key]) {
        validation = validations[question_key][i];
        switch(validation["type"]){
        case "requires_answer":
            //Hidden questions are not required
            if($("#answer_"+question_key+"_input:hidden").length != 0){
                break;
            }
            var someChecked = -1;
            for (var j = 0; j < inputs.length; j++){
                var input = inputs[j];
                if(input.type == "text" && input.value == "" ){
                    fail_vals.push(validation["type"]);
                    break;            
                }
                if(input.type == "radio" || input.type == "checkbox"){
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
            if (inputs.length == 3 && inputs[0].value != "") {
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
              item.find(".error." + ele).removeClass("hidden");
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
            $("#answer_" + this + "_input").removeClass('hidden');
        }
    });
    $.each(hidekeys, function(){
        if (element.checked) {
            $("#answer_" + this + "_input").addClass('hidden');
        }
    });    
}

function handleDisableRadioSubQuestions(element){
    if(element.checked){
        $(element).closest('.item').find('.subinput').attr("disabled", "true");
        $(element).closest('li').find('.subinput').attr("disabled", "");
    } 
}

function handleDisableCheckboxSubQuestions(element){
    if(element.checked){
        $(element).parent().find('.item input').attr("disabled", "");       
    } else {
        $(element).parent().find('.item input').attr("disabled", "true");
    }
} 


$(document).ready(
    function() {
        hashChangeEnabled = true;
        jQuery(window).bind( 'hashchange', hashchangeEventHandler);
        //$.address.change( 'hashchange', hashchangeEventHandler);

        $('.subinput').attr("disabled", "true");
        $('input[type="radio"]').each( function(index, element){            
           handleDisableRadioSubQuestions(element);
        });
        //TODO: change this once the 'click to deselect radio inputs' feature is in
        $('input[type="radio"]:checked').click();
        
        $('input[type="checkbox"]').each( function(index, element){
           handleDisableCheckboxSubQuestions(element);
        });
        
        // enable javascript-based previous/next links
        $(".panel .prevnext").show();

        // hide all panels
        $(".panel").hide();

        // hide Submit button
        $(".buttons").hide();

        // hide first previous button, and last next button
        $(".panel:first .prevnext .prev").hide();
        $(".panel:last  .prevnext .next").hide();

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

        $("input[type=radio]").customInput();
        
        //Layout breaks with this
        //$("input[type=checkbox]").customInput();

    }
);

