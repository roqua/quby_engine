(function(){
  var hotkeysEnabled;
  var curPanel;
  var panelInputs;
  var focusI = 0;
  var lastInput;
  var nextButtonFocussed = false;
  var saveButtonFocussed = false;

  $(function() {
    hotkeysEnabled = $(".hotkeyDialog").length > 0;

    if (hotkeysEnabled) {
      $("body").live("keydown", handleDownHotKeys);
      $("body").live("keyup", handleUpHotKeys);
      $("body").live("click", function (){
        nextButtonFocussed = false;
        saveButtonFocussed = false;
      })
      $(".item input, .item textarea, .buttons input, select").live("click", function(event){
        focusInput(event.target);
      })
      $(".item input, .item textarea, .buttons input, select").live("focus", function(event){
        focusInput(event.target);
      });
    }
  })

  $(document).on('panel_activated', function(e, $panel) {
    curPanel = $panel;

    nextButtonFocussed = false;
    saveButtonFocussed = false;
    if (hotkeysEnabled) {
      panelInputs = getValidInputs();
      focusI = 1;
      focusInputIndex(focusI, true);
    }
  })

  function focusInputIndex(index, forward){
    if (forward) {
      lastInput = panelInputs.filter(':eq('+index+'), :gt(' + index + ')').not(':hidden, :disabled').first();
    } else {
      lastInput = panelInputs.filter(':eq('+index+'), :lt(' + index + ')').not(':hidden, :disabled').last();
    }

    if (index < 0 || index > panelInputs.length || lastInput.length == 0) {
      if(forward){
        index = 0
        lastInput = panelInputs.filter(':eq('+index+'), :gt(' + index + ')').not(':hidden, :disabled').first();
      } else {
        index = panelInputs.length -1;
        lastInput = panelInputs.filter(':eq('+index+'), :lt(' + index + ')').not(':hidden, :disabled').last();
      }
    }
    if (lastInput.length > 0) {
      //IE7 disabled element focus hack
      $(lastInput[0]).show();
      lastInput[0].focus();

      saveButtonFocussed = lastInput.is('#done-button');
      nextButtonFocussed = lastInput.is('.next');
      focusI = panelInputs.index(lastInput);
    }
  }

  function focusInput(input){
    $('.focus').removeClass('focus');
    focusI = panelInputs.index(input);
    if(focusI == -1 && $(input).is("[type=radio]")){
      input = $(input).closest('.fields').find('[type=radio]:first');
      focusI = panelInputs.index(input);
    }
    if($(input).is("[type='submit']")){
      $('.buttons').addClass('focus');
    } else if ($(input).is("[type='checkbox']")) {
      $(input).closest('.option').addClass('focus');
    } else {
      var focus = $(input).closest('.item:not(.table)');
      if (focus.length == 0) {
        var qname = $(input).closest('td.option').data('for');
        curPanel.find('td.option[data-for="' + qname + '"]').addClass('focus');
      } else {
        focus.addClass('focus');
      }
    }
    lastInput = $(input);
  }

  function getValidInputs(){
    var inputs = curPanel.find('input:not([id^="abortButton"]), textarea, select');
    var hadRadioQ = [];
    inputs = inputs.filter(function (index){
      if (this.type == "radio") {
        var valid = $.inArray(this.name, hadRadioQ) == -1;
        hadRadioQ.push(this.name);
        return valid;
      }
      return true;
    });

    var backI = inputs.index(inputs.filter('#back, [id^="prevButton"]').not(':hidden'));
    if(backI != -1){
      inputs = inputs.toArray();
      inputs.unshift(inputs.splice(backI, 1)[0]);
      inputs = $(inputs);
    }

    return inputs;
  }

  function focusNextInput(){
    lastInput.blur();
    setTimeout(function() { focusInputIndex(focusI+1, true);}, 50);
  }
  function focusPrevInput(){
    lastInput.blur();
    setTimeout(function() { focusInputIndex(focusI-1, false);}, 50);
  }

  function selectInput(value){
    var lastFocus = $('.focus');
    var values = lastFocus.find(".value");
    var selectedInput = $([]);
    values.each(function(index, element){
       if(parseInt(element.textContent || element.innerHTML) == value){
         selectedInput = $(element).closest(".option").find("input[type='radio'][name='"+lastInput[0].name+"']:not(.subinput, :hidden, :disabled)");
       }
    });

    if(selectedInput.length == 0){
      selectedInput = lastFocus.find("input[type='radio'][name='"+lastInput[0].name+"']:not(.subinput, :hidden, :disabled)").eq(value-1);
    }
    if(selectedInput.length > 0) {
      selectedInput.attr('checked', 'checked');
      radioCheckboxEvents(selectedInput[0]);
      focusNextInput();
    }
  }

  function selectFocusedInput(){
    var el = $(document.activeElement);
    el.attr('checked', 'checked');
    radioCheckboxEvents(el);
    focusNextInput();
  }

  window.hotkeyDialog = function(){;
    $(".hotkeyDialog").last().dialog({
      draggable : false, resizable : false, modal : true, width : 550,
      buttons: {
        "Sluiten": function(){
          $(this).dialog("close");
        }
      }
    });
  }


  function handleDownHotKeys(event){
    event.which = event.charCode || event.which || event.keyCode;
    if ($(lastInput).is("textarea") || $(lastInput).is("input[type=submit]") && (event.which == 32 || event.which == 13)) {
      return;
    }

    switch (event.which) {
    //enter
    case 13:
      if (!(nextButtonFocussed || saveButtonFocussed)) {
        preventDefault(event);
        focusNextInput();
      }
      break;
    //pg up, up arrow
    case 33:
    case 38:
      if (!$(lastInput).is("select")) {
        preventDefault(event);
        focusPrevInput();
      }
      break;
    case 37: // left arrow
      if (!$(lastInput).is("input[type=text]") && !$(lastInput).is("input[type=range]")) {
        preventDefault(event);
        focusPrevInput();
      }
      break;
    //pg dwn, down arrow
    case 34:
    case 40:
      if (!$(lastInput).is("select")) {
        preventDefault(event);
        focusNextInput();
      }
      break;
    case 39: //right arrow
      if (!$(lastInput).is("input[type=text]") && !$(lastInput).is("input[type=range]")) {
        preventDefault(event);
        focusNextInput();
      }
      break;
    //space
    case 32:
      if(!$(lastInput).is("input[type=text], select")){
        preventDefault(event);
      }
      break;
    }
  }
  function handleUpHotKeys(event){
    event.which = event.which || event.keyCode;
    if ($(lastInput).is("input[type=submit]") && (event.which == 32 || event.which == 13)){
        event.target.click();
        return;
    } else if($(lastInput).is("textarea, input[type=text]")){
        return;
    }

    if ($(lastInput).is("[type='radio']")) {
      switch (event.which) {
      //0
      case 48:
      case 96:
        selectInput(0);
        break;
      //1
      case 49:
      case 97:
        selectInput(1);
        break;
      //2
      case 50:
      case 98:
        selectInput(2);
        break;
      //3
      case 51:
      case 99:
        selectInput(3);
        break;
      //4
      case 52:
      case 100:
        selectInput(4);
        break;
      //5
      case 53:
      case 101:
        selectInput(5);
        break;
      //6
      case 54:
      case 102:
        selectInput(6);
        break;
      //7
      case 55:
      case 103:
        selectInput(7);
        break;
      //8
      case 56:
      case 104:
        selectInput(8);
        break;
      //9
      case 57:
      case 105:
        selectInput(9);
        break;
      }
    }
    //space
    if(event.which == 32){
      preventDefault(event);
      selectFocusedInput();
    }
  }



})();
