// Scope:
//
//   questionnaires/1/answers/edit

function activatePanel(panel) {
    $('.panel').hide().removeClass('current');
    window.location.hash = panel[0].id;
    panel.show().addClass('current');
    if(panel.hasClass('last-panel')){
        $(".buttons").show();
    } else {
        $(".buttons").hide();
    }
}

$(document).ready(
    function() {

        // enable javascript-based previous/next links
        $(".panel .prevnext").show();

        // hide all panels
        $(".panel").hide();

        // hide Submit button
        $(".buttons").hide();

        // hide first previous button, and last next button
        $(".panel:first .prevnext .prev").hide();
        $(".panel:last  .prevnext .next").hide();

        // if we have a window.location.hash, and we can find a panel for that hash, switch to that panel
        if (window.location.hash != "") {
            panel = $(".panel#" + window.location.hash);
            if (panel[0]) {
                activatePanel(panel);
            }
        } else { // if we have no hash, activate the first panel
            activatePanel($(".panel:first"));
        }

        // show previous panel
        $(".panel .prev").click(
            function(event) {
                var prevPanel = $(this).parents('.panel').prev()
                activatePanel(prevPanel);
                return false;
            }
        );

        // show next panel
        $(".panel .next").click(
            function(event) {
                var nextPanel = $(this).parents('.panel').next();
                activatePanel(nextPanel);
                return false;
            }
        );

    }
);

