// Scope:
//
//   questionnaires/1/answers/edit

function activatePanel(panel) {
    $('.panel').hide().removeClass('current');
    window.location.hash = panel[0].id;
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
        
        // if we have a window.location.hash, and we can find a panel for that hash, switch to that panel
        if (window.location.hash != "") {
            panel = $(".panel#" + window.location.hash);
            if (panel[0]) {
                activatePanel(panel);
            }
        }

        // show previous panel
        $(".panel .prev").click(
            function(event) {
                activatePanel($(this).parents('.panel').prev());
                return false;
            }
        );
        
        // show next panel
        $(".panel .next").click(
            function(event) {
                activatePanel($(this).parents('.panel').next());
                return false;
            }
        );

        // show buttons when showing last panel
        $(".panel:nth-last-child(3) .next").click(
            function(event) {
                $(".buttons").show();
            }
        );

        // hide buttons when going back from last panel
        $(".panel:nth-last-child(2) .prev").click(
            function(event) {
                $(".buttons").hide();
            }
        );
    }
);

