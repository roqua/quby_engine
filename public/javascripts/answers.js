// Scope:
//
//   questionnaires/1/answers/edit
var hashChangeEnabled;
function activatePanel(panel, updateHash) {
    $('.panel').hide().removeClass('current');
        
    if (updateHash) {
		hashChangeEnabled = false;
        window.location.hash = panel[0].id;        
    }
        
    panel.show().addClass('current');
    
    if(panel.hasClass('last-panel')){
        $(".buttons").show();
    } else {
        $(".buttons").hide();
    }
}

function validatePanel(panel) {
  return_val = true;
  if (panel_validations[panel.id]) {
    validations = panel_validations[panel.id];
    for (question_key in validations) {
      for (i in validations[question_key]) {
        validation = validations[question_key][i];
        if (validation["type"] == "requires_answer") {
          alert("Require answer");
          return_val = false;
        } else {
          alert("Unknown validation type");
        }
      }
    }
  }
  return return_val;
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
		  }
        }
		
		// Setting the 'check_all' and the 'uncheck_all' checkboxes appropriately, if both are used
		if(checkValue == "1"){
			$('#answer_'+nothingKey).attr("checked", "");
		} else {
			$('#answer_'+allKey).attr("checked", "");
		}
	}
}

//This function is set to the onClick of all checkboxes besides the 'check_all' or 'uncheck_all' checkboxes
//to appropriately set the 'check_all' or 'uncheck_all' checkboxes if a checkbox changes
//1: If a checkbox is checked, the 'uncheck_all' checkbox should be unchecked
//2: If a checkbox is unchecked, the 'check_all' checkbox should be unchecked
function correctAllNothingCheckboxes(checked, allKey, nothingKey){
	if(checked){
		$("#answer_" + nothingKey).attr("checked", "");
	} else {
		$("#answer_" + allKey).attr("checked", "");
	}
}

function hashchangeEventHandler(){
	if (hashChangeEnabled) {
		// if we have a window.location.hash, and we can find a panel for that hash, switch to that panel
		if (window.location.hash != "" && window.location.hash != $(".panel:first").id) {
		    panel = $(".panel#" + window.location.hash);
		    if (panel[0]) {
		        activatePanel(panel, true);
		    }
		} else { // if we have no hash, activate the first panel
		    activatePanel($(".panel:first"), false);
		}
    } else {
		hashChangeEnabled = true;
	}       
}

$(document).ready(
    function() {
		hashChangeEnabled = true;
        jQuery(window).bind( 'hashchange', hashchangeEventHandler);
        //$.address.change( 'hashchange', hashchangeEventHandler);
        
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
        $(".panel .prev").click(
            function(event) {
                var prevPanel = $(this).parents('.panel').prev()
                activatePanel(prevPanel, true);
                return false;
            }
        );

        // show next panel
        $(".panel .next").click(
            function(event) {
                var nextPanel = $(this).parents('.panel').next();
                if (validatePanel($(this).parents('.panel')[0])) {
                    activatePanel(nextPanel, true);
                } else {
                    alert("Answer wrong");
                }
                return false;
            }
        );

    }
);

