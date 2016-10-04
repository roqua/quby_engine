var displayMode;
var isBulkOrSinglePage;
var shownFlash = false;

$(function() {
  displayMode = $('#display_mode').val();
  isBulkOrSinglePage = (displayMode === 'bulk' || displayMode === 'single_page');
});
