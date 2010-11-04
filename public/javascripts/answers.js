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
                activatePanel(nextPanel, true);
                return false;
            }
        );

    }
);

