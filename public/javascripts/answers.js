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
                var prevPanel = $(this).parents('.panel').prev()
                activatePanel(prevPanel);
                if(prevPanel.hasClass('last-panel')){
                  $(".buttons").show();
                } else {
                  $(".buttons").hide();
                }
                return false;
            }
        );

        // show next panel
        $(".panel .next").click(
            function(event) {
                var nextPanel = $(this).parents('.panel').next();
                activatePanel(nextPanel);
                if(nextPanel.hasClass('last-panel')){
                  $(".buttons").show();
                } else {
                  $(".buttons").hide();
                }
                return false;
            }
        );

    }
);

