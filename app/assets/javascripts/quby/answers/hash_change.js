// Handle initialising and changing panels in paged mode.
(function() {
  var inIframe = self != top;
  var hashChangeEnabled = true;

  window.changeHash = function(newhash) {
    if (!inIframe) {
      hashChangeEnabled = false;
      window.location.hash = newhash;
    }
  }

  function hashchangeEventHandler(){
    if (hashChangeEnabled) {
      // if we have a window.location.hash, and we can find a panel for that hash, switch to that panel
      if (window.location.hash != "" && window.location.hash != $(".panel:first").id) {
        var panel = $(window.location.hash);
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

  $(function() {
    if (!isBulk) {
      if (inIframe) {
        activatePanel($(".panel:first"), false, true);
      } else {
        jQuery(window).bind('hashchange', hashchangeEventHandler);
      }
      // Trigger the hashchange event (useful on page load).
      $(window).hashchange();
    }
  });
})();
