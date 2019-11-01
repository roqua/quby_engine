export type QuestionKey = string;

export interface IFlag {
  key: string;
  description_true: string;
  description_false: string;
  description: string | null;
  internal: boolean;
  trigger_on: boolean;
  shows_questions: QuestionKey[];
  hides_questions: QuestionKey[];
  depends_on: any;
  default_in_interface: any;
}

export interface IPanel {
  panelId: string;
  questions: QubyNS.Collections.Questions;
}

export interface IQuestionOption {
  key: string;
  showsQuestionsKeys: QuestionKey[];
  hidesQuestionsKeys: QuestionKey[];
  startChosen: boolean;

  // value: number;
  // description: string;
  // questions: any[];
  // inner_title: string | null;
  // hidden: boolean;
  // placeholder: boolean;
  // view_id: string;
}

export interface IQuestion {
  key: string;
  viewSelector: string;
  options: QubyNS.Collections.QuestionOptions;
  type: string;
  defaultInvisible: boolean;
  parentQuestion: QubyNS.Models.Question;
  parentOption: QubyNS.Models.QuestionOption;
  deselectable: boolean;

  // class: string;
  // title: string;
  // description: string | null;
  // validations: Validation[];
  // unit: string;
  // hidden: boolean | null;
  // display_modes: any[] | null;
}

type Validation = RequiresAnswerValidation | ValidIntegerValidation | MinimumValidation | MaximumValidation;

export interface RequiresAnswerValidation {
  type: "requires_answer";
  explanation: string | null;
}

export interface ValidIntegerValidation {
  type: "valid_integer";
  explanation: string | null;
}

export interface MinimumValidation {
  type: "minimum";
  value: number;
  subtype: string;
}

export interface MaximumValidation {
  type: "maximum";
  value: number;
  subtype: string;
}

export interface ITextvar {}
