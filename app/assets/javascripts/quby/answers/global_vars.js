var displayMode;
var isBulk;
var shownFlash = false;

$(function() {
  displayMode = $('#display_mode').val();
  isBulk = (displayMode === 'bulk' || displayMode === 'single_page');
});
