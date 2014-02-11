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

        var depends_on = eval(question_item.attr("data-depends_on"));
        if(depends_on){
          var dep_inputs = $($.map(depends_on, function(key){
              return $("#answer_"+key).not(":disabled, :hidden");
          }));
          if(!is_answered(dep_inputs, question_item) || dep_inputs.length == 0){
              continue;
          }
        }

        if(question_item.length == 0){
            question_item = panel.find("[data-for=" + question_key + "]");
        }

        var inputs = question_item.find("input, textarea, select")
        if (!question_item.is('.slider'))
            inputs = inputs.not(":disabled, :hidden")
        var values = $.map(inputs, function(e) {
          return $(e).val()
        });

        fail_vals = new Array();

        for (var i in validations[question_key]) {
          var validation = validations[question_key][i];
          switch(validation.type) {
              case "requires_answer":
                  if (!is_answered(inputs, question_item)) {
                    pushFailVal(validation.type);
                  }
                  break;
              case "minimum":
                  if (inputs.length == 3 && (values[0] != "" && values[1] != "" && values[2] != "")) {
                      var enteredDate = new Date(values[2], values[1], values[0])
                      var minimumDate = Date.parse(validation.value)

                      if(enteredDate < minimumDate) {
                          pushFailVal(validation.type);
                      }
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
                  if (inputs.length == 3 && (values[0] != "" && values[1] != "" && values[2] != "")) {
                      var enteredDate = new Date(values[2], parseInt(values[1]) - 1, values[0])
                      var maximumDate = Date.parse(validation.value)

                      if(enteredDate > maximumDate) {
                          pushFailVal(validation.type);
                      }
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
                  var regex = eval(jsregex);
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
                  var rgx = /(\s*-?[1-9]+[0-9]*\s*|\s*-?[0-9]?\s*)/;
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
                  var rgx = /(\s*-?[1-9]+[0-9]*\.[0-9]+\s*|\s*-?[1-9]+[0-9]*\s*|\s*-?[0-9]\.[0-9]+\s*|\s*-?[0-9]?\s*)/;
                  var result = rgx.exec(value);
                  if(result === null || result[0] != value){
                      pushFailVal(validation.type);
                  }
                  break;
              case "answer_group_minimum":
                  var count = get_answer_count(validation.group, panel);
                  if(count < validation.value){
                      pushFailVal(validation.type);
                  }
                  break;
              case "answer_group_maximum":
                  var count = get_answer_count(validation.group, panel);
                  if(count > validation.value){
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
    //To correctly reposition the placeholders
    //placeholder();
    return !failed;
  }

  function pushFailVal(val){
    fail_vals[validationI] = val;
    validationI++;
  }

  function is_answered(inputs, item){
    for (var j = 0; j < inputs.length; j++){
      var input = $(inputs[j]);
      if(input.is("[type=text], [type=range], textarea")){ // test for slider, since ie8- can't update type
        if (/\S/.test($(input).val())) {
          return true;
        }
      }
      if(input.is("[type=radio]") || input.is("[type=checkbox]")){
        if (input.attr("checked")) {
          return true;
        }
      }
      if(input.is("select")){
        if (item.data('placeholder') != input[0].value){
          return true;
        }
      }
      if(input.is("option:selected")){
        return true;
      }
    }
    return inputs.length == 0;
  }

  function get_answer_count(groupkey, panel){
    var answered = 0;

    var quest_items = panel.find(".item."+ groupkey);
    for(var i = 0; i < quest_items.length; i++){
      var inputs = $(quest_items[i]).find(" input, textarea").not(":disabled, :hidden")
      if (is_answered(inputs, quest_items.eq(i))) {
        answered++;
      }
    }
    return answered;
  }

})();
