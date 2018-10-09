(function() {
  window.skipValidations = false;
  var validationI = 0;
  var fail_vals = new Array();

  window.validatePanel = function(panel) {
    if(skipValidations){
        return true;
    }
    var failed = false;
    validationI = 0;
    panel.find(".error").addClass("hidden");
    panel.find(".errors").removeClass("errors");
    if (panel_validations[panel.attr("id")]) {
      var validations = panel_validations[panel.attr("id")];

      for (var question_key in validations) {
        if(validations[question_key].length == 0){
            continue;
        }

        var question_item = $("#answer_" + question_key + "_input").closest('.item');

        var depends_on = eval(question_item.attr("data-depends-on"));
        if(depends_on){
          var dep_inputs = $($.map(depends_on, function(key){
              // select options always count as hidden in chrome
              // so they would be excluded here without the extra add
              return $("#answer_"+key).not(":disabled, :hidden").add("option.select#answer_"+key).not(":disabled");
          }));
          if(!is_answered(dep_inputs) || dep_inputs.length == 0){
              continue;
          }
        }

        if(question_item.length == 0){
            question_item = panel.find("[data-for=" + question_key + "]");
        }

        var inputs = question_item.find("input, textarea, select");
        if (question_item.is('.slider')) {
            if (question_item.is('.hide'))
                continue;
            inputs = inputs.not(":disabled");
        } else {
            inputs = inputs.not(":disabled, :hidden")
        }


        var values = $.map(inputs, function(e) {
          return $(e).val()
        });

        fail_vals = new Array();

        for (var i in validations[question_key]) {
          var validation = validations[question_key][i];
          switch(validation.type) {
              case "requires_answer":
                  if (!is_answered(inputs)) {
                    pushFailVal(validation.type);
                  }
                  break;
              case "minimum":
                  if ($(inputs[0]).attr('class') === 'date') {
                    try {
                      if(allDateFieldsFilledIn(inputs)) {
                        var enteredDate = parsePartialDate(inputs);
                        var minimumDate = new Date(validation.value);
                        if(enteredDate < minimumDate) {
                          pushFailVal(validation.type);
                        }
                      }
                    } catch(e) {} // errors in date parsing are handled by valid_date
                  } else if (inputs.length == 1) {
                      var value = values[0];
                      if(value === undefined || value == ""){
                          continue;
                      }
                      if(parseFloat(value) < validation.value){
                          pushFailVal(validation.type);
                      }
                  }
                  break;
              case "maximum":
                  if ($(inputs[0]).attr('class') === 'date') {
                    try {
                      if(allDateFieldsFilledIn(inputs)) {
                        var enteredDate = parsePartialDate(inputs);
                        var maximumDate = new Date(validation.value)
                        if(enteredDate > maximumDate) {
                          pushFailVal(validation.type);
                        }
                      }
                    } catch(e) {}
                  } else if (inputs.length == 1) {
                      var value = values[0];
                      if(value === undefined || value == ""){
                          continue;
                      }
                      if(parseFloat(value) > validation.value){
                          pushFailVal(validation.type);
                      }
                  }
                  break;
              case "regexp":
                  //super dirty regex replace /A to ^ and /Z to $
                  var jsregex = validation.matcher.replace("\\A", "^").replace("\\Z", "$")
                  var regex = new RegExp(jsregex);
                  var value = undefined;
                  if (inputs.length == 3 && (values[0] != "" || values[1] != "" || values[2] != "")) {
                      value = values.join("-");
                  } else if (inputs.length == 1){
                      value = values[0];
                  }
                  if(value == undefined || value == ""){
                      continue;
                  }
                  var result = regex.exec(value);
                  if(result === null || result[0] != value){
                      pushFailVal(validation.type);
                  }
                  break;
              case "valid_integer":
                  var value = values[0];
                  if(value === undefined || value == ""){
                      continue;
                  }
                  var rgx = /(\s*-?[1-9]+[0-9]+\s*|\s*-?[0-9]\s*)/;
                  var result = rgx.exec(value);
                  if(result == null || result[0] != value){
                      pushFailVal(validation.type);
                  }
                  break;
              case "valid_float":
                  var value = values[0];
                  if(value === undefined || value == ""){
                      continue;
                  }
                  var isNumber = !isNaN(parseFloat(value)) && isFinite(value);
                  if(!isNumber){
                    pushFailVal(validation.type);
                  }
                  break;
              case "valid_date":
                try {
                  fieldsEmpty = numberOfEmptyDateFields(inputs);
                  if(fieldsEmpty > 0 && fieldsEmpty < $(inputs).size()) {
                    throw "invalidDate";
                  }

                  var date = parsePartialDate(inputs);
                }
                catch(e) {
                  pushFailVal(validation.type);
                }
                break;
              case "answer_group_minimum":
                  var count = calculateAnswerGroup(validation.group, panel);
                  if(count.visible > 0 && count.answered < validation.value){
                      pushFailVal(validation.type);
                  }
                  break;
              case "answer_group_maximum":
                  var count = calculateAnswerGroup(validation.group, panel);
                  if(count.visible > 0 && count.answered > validation.value){
                      pushFailVal(validation.type);
                  }
                  break;
              case "maximum_checked_allowed":
                  var checkboxes = question_item.find('input[type=checkbox]:checked');
                  if (checkboxes.length > validation.maximum_checked_value) {
                      pushFailVal(validation.type);
                  }
                  break;
              case "minimum_checked_required":
                  var checkboxes = question_item.find('input[type=checkbox]:checked');
                  if (checkboxes.length < validation.minimum_checked_value) {
                    pushFailVal(validation.type);
                  }
                  break;
              //These validations would only come into play if the javascript that makes it impossible
              //to check an invalid combination of checkboxes fails.
              case "too_many_checked":
                  break;
              case "not_all_checked":
                  break;
              }
        }
        if (fail_vals.length != 0) {
            var item = question_item.addClass('errors');
            $(fail_vals).each(function(index, ele){
                item.find(".error." + ele).first().removeClass("hidden");
            });
            failed = true;
        }
      }
    }

    // Scroll the first element that has validation errors into view
    if(failed){
        var first_error = $('.error').not('.hidden')[0];
        if( first_error != undefined) {
          // Prevent horizontal scrolling (on mobile devices)
          $('html, body').animate({scrollTop: first_error.offsetTop}, 0);
        }
    }
    return !failed;
  };

  function parsePartialDate(inputs) {
    var values = dateValuesWithDefaults(inputs)
    if(!dateValuesValid(values)) {
      throw "invalidDate";
    }
    // NB: month is already substracted by 1 by dateValuesWithDefaults to account for js date months starting on 0
    return new Date(Date.UTC(values.year, values.month, values.day, values.hour, values.minute));
  }

  function dateValuesValid(values) {
    return values['year']   >= 1900 && values['year']   <= 2100 &&
           values['month']  >= 0    && values['month']  <= 11   &&
           values['day']    >= 1    && values['day']    <= 31   &&
           values['hour']   >= 0    && values['hour']   <= 23   &&
           values['minute'] >= 0    && values['minute'] <= 59;
  }

  function dateValuesWithDefaults(inputs) {
    var valueWithDefault = function(default_date_key, default_value) {
      var val = $.trim(inputs.filter("[data-default-date-key='" + default_date_key + "']").first().val());
      if (val === undefined || val == "") {
        return default_value;
      }

      if (!/^\d+$/.test(val)) {
        throw "invalidDate";
      }

      var intVal = parseInt(val, 10);
      if (!intVal && intVal !== 0) {
        throw "invalidDate";
      }

      return intVal;
    };

    return {
      year:   valueWithDefault('yyyy', 2000),
      month:  valueWithDefault('mm', 1) - 1, // JS months range from 0-11 instead of 1-12
      day:    valueWithDefault('dd', 1),
      hour:   valueWithDefault('hh', 0),
      minute: valueWithDefault('ii', 0)
    }
  }

  function numberOfEmptyDateFields(inputs) {
    return inputs.toArray().reduce(function(fieldsEmpty, field) {
      if($(field).val() == '' && $(field).data('required') == true) {
        return ++fieldsEmpty;
      }
      return fieldsEmpty;
    }, 0);
  }

  function allDateFieldsFilledIn(inputs) {
    return numberOfEmptyDateFields(inputs) == 0;
  }

  function pushFailVal(val){
    fail_vals[validationI] = val;
    validationI++;
  }

  function is_answered(inputs){
    for (var j = 0; j < inputs.length; j++){
      var input = $(inputs[j]);
      if(input.is("[type=text], [type=range], textarea")){ // test for slider, since ie8- can't update type
        if (/\S/.test($(input).val())) {
          return true;
        }
      }
      if(input.is("[type=radio]:checked") || input.is("[type=checkbox]:checked")){
        return true;
      }
      if(input.is("select")){
        return input.find("option:selected:not(.placeholder)").length > 0;
      }
      if(input.is("option:selected:not(.placeholder)")) {
        return true;
      }
    }
    return inputs.length == 0;
  }

  function calculateAnswerGroup(groupkey, panel){
    var groupItems = panel.find(".item." + groupkey + ", .option." + groupkey);

    var answered = 0;
    var visible = 0;
    var hidden = 0;

    for(var i = 0; i < groupItems.length; i++){
      var inputs = $(groupItems[i]).find("input, textarea, select").not(":disabled, :hidden");
      if (inputs.length == 0) {
        hidden++;
      } else {
        visible++;

        if (is_answered(inputs)) {
          answered++;
        }
      }
    }
    return {total: groupItems.length, visible: visible, hidden: hidden, answered: answered};
  }

})();
