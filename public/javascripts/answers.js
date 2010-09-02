// Scope:
//
//   questionnaires/1/answers/new
//   questionnaires/1/answers/edit

function activatePanel(panel) {
    $('.panel').hide().removeClass('current');
    panel.show().addClass('current');
}

$(document).ready(
    function() { 
        
        // enable javascript-based previous/next links
        $(".panel .prevnext").show();
        
        // hide all panels except first one
        $(".panel").hide();

        // hide Submit button
        $(".buttons").hide();
        $(".panel:first").show().addClass('current');
        
        // hide first previous button, and last next button
        $(".panel:first .prevnext .prev").hide();
        $(".panel:last  .prevnext .next").hide();
        
        // show previous panel
        $(".panel .prev").click(
            function(event) {
                activatePanel($(this).parents('.panel').prev());
                return false;
            }
        );
        
        // show next panel
        $(".panel .next:not(:last)").click(
            function(event) {
                activatePanel($(this).parents('.panel').next());
                return false;
            }
        );
        
    }
);

