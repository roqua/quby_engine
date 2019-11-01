import { IQuestion } from "./models";

export class InitQuestions {
  questions: QubyNS.Collections.Questions;
  questionAttributes: QubyNS.Logic.QuestionAttributes[];

  constructor(questionAttributes: QubyNS.Logic.QuestionAttributes[]) {
    this.questions = new Quby.Collections.Questions();
    this.questionAttributes = questionAttributes;
  }

  initializeQuestions(): QubyNS.Collections.Questions {
    this.questionAttributes.forEach((attributes) => {
      this.questions.add(this.initializeQuestion(attributes));
    });

    return this.questions;
  }

  private initializeQuestion(attributes: QubyNS.Logic.QuestionAttributes) {
    const parentQuestion = this.questions.findWhere({key: attributes.parentKey});
    let parentOption: QubyNS.Models.QuestionOption | undefined;

    if (parentQuestion) {
      parentOption = parentQuestion.get("options").findWhere({key: attributes.parentOptionKey});
    }

    return new Quby.Models.Question({
      key: attributes.key,
      viewSelector: attributes.viewSelector,
      options: this.initializeOptions(attributes.options),
      type: attributes.type,
      defaultInvisible: attributes.default_invisible,
      parentQuestion: parentQuestion,
      parentOption: parentOption,
      deselectable: attributes.deselectable
    })
  }

  private initializeOptions(optionAttributes: QubyNS.Logic.OptionAttributes[]): QubyNS.Collections.QuestionOptions {
    const options = new Quby.Collections.QuestionOptions();

    optionAttributes && optionAttributes.forEach((attrs) => {
      const option = new Quby.Models.QuestionOption({
        key: attrs.key,
        showsQuestionsKeys: attrs.shows_questions,
        hidesQuestionsKeys: attrs.hides_questions,
        startChosen: attrs.start_chosen
      });
      const element = this.initializeOptionViewElement(attrs.view_id);
      new Quby.Views.QuestionOptionView({model: option, el: element});
      options.add(option);
    });
    return options;
  }

  private initializeOptionViewElement(viewId: string) {
    return $("#" + viewId)[0];
  }

}