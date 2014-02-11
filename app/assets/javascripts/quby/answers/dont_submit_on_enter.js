(function() {
  function dontSubmitOnEnter(event){
    event.which = event.which || event.keyCode;

    if($(event.target).is('textarea'))
      return;

    if(event.which == 13)
      preventDefault(event);
  }
  $(document).on('keydown', dontSubmitOnEnter);
})();
