$(function() {
  var scrollToNextQuestion = $("form").hasClass("scroll_to_next_question");

  if(scrollToNextQuestion){
    var questionInputs = $("input[name][type!='hidden'], select").filter(function(index){
      var element = $(this);
      return element.is($("[name='"+ element.attr('name') +"'][type!='hidden']:first")) || element.is('[name="commit"]');
    });
    var curQuestionInputIndex = 0;
    var scrollToHandler = function(event){
        var iname = $(event.target).attr('name');
        curQuestionInputIndex = questionInputs.index($("[name='"+ iname + "'][type!='hidden']"));
        curQuestionInputIndex += 1;
        var nextQuestionInput = questionInputs[curQuestionInputIndex];
        $.scrollTo(nextQuestionInput, 200, {offset: -50});
    };
    $(".item input[type=radio]").on("click", scrollToHandler);
    $(".item select").on("change", scrollToHandler);
  }
});
