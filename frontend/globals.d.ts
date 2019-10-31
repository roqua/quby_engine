import Backbone from "backbone";

declare namespace Quby {
  type QuestionKey = string;

  interface IFlag {
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

  interface IPanel {
    panelId: string;
    questions: Collections.Questions;
  }

  interface IQuestionOption {
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

  interface IQuestion {
    key: string;
    viewSelector: string;
    options: Quby.Collections.QuestionOptions;
    type: string;
    defaultInvisible: boolean;
    parentQuestion: Quby.Models.Question;
    parentOption: Quby.Models.QuestionOption;
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

  interface RequiresAnswerValidation {
    type: "requires_answer";
    explanation: string | null;
  }

  interface ValidIntegerValidation {
    type: "valid_integer";
    explanation: string | null;
  }

  interface MinimumValidation {
    type: "minimum";
    value: number;
    subtype: string;
  }

  interface MaximumValidation {
    type: "maximum";
    value: number;
    subtype: string;
  }

  interface ITextvar { }

  namespace Models {
    type Field = any;

    class Answer {
      constructor(fields: any);

      getField(key: string): Field;
      setField(key: string, value: Field): void;
    }

    class Flag extends Backbone.Model<IFlag> {
      defaults(): Partial<IFlag>;
      initShowsHides(allQuestions: any): void;
      doHiding(): void;
      hideQuestions(): void;
      showQuestions(): void;
    }

    class Panel extends Backbone.Model<IPanel> {
      defaults(): Partial<IPanel>;
      initialize(): void;
      initShowsHides(allQuestions: any): void;
      hidePanelCheck(): void;
      hidden(): boolean;
    }

    class QuestionOption extends Backbone.Model<IQuestionOption> {
      defaults(): Partial<IQuestionOption>;
      initialize(): void;
      addedToCollection(): void;
      initShowsHides(allQuestions: any): void;
      checkChosen(): void;
      hideQuestions(): void;
      unhideQuestions(): void;
      showQuestions(): void;
      unshowQuestions(): void;
    }

    class Question extends Backbone.Model<IQuestion> {
      defaults(): Partial<IQuestion>;
      initialize(): void;
      isVisible(): void;
      optionClicked(optionModel: QuestionOption): void;
      setLastClickedOption(optionModel: QuestionOption): void;
      unchecksLastClicked(): boolean;
      hide(hidingOption: QuestionOption): void;
      unhide(hidingOption: QuestionOption): void;
      show(showingOption: QuestionOption): void;
      unshow(showingOption: QuestionOption): void;
    }
  }

  namespace Collections {
    class Flags extends Backbone.Collection<Models.Flag> {
      initShowsHides: (allQuestions: any) => void;
      addFlags: (flagDefinitions: FlagDefinitions, flagValues: FlagValues) => void;
    }

    class Panels extends Backbone.Collection<Models.Panel> {
    }

    class QuestionOptions extends Backbone.Collection<Models.QuestionOption> {
    }

    class Questions extends Backbone.Collection<Models.Question> {
      noneVisible: () => boolean;
      addQuestions: (questions: any) => void;
    }

    class Textvars {
      constructor(initial: TextvarValues);

      get(key: string): string;
      set(key: string, value: string): void;
    }
  }

  namespace Logic {
    interface QuestionAttributes {
      key: string;
      viewSelector: string;
      options: OptionAttributes[];
      type: string;
      default_invisible: boolean;
      parentKey: string | null;
      parentOptionKey: string | null;
      deselectable: boolean;
    }
    
    interface OptionAttributes {
      key: string;
      shows_questions: QuestionKey[];
      hides_questions: QuestionKey[];
      start_chosen: boolean;
    }

    class InitQuestions {
      constructor(questions: IQuestion[]);
      initializeQuestions(): Quby.Collections.Questions;

      private initializeOptions(optionAttributes: OptionAttributes[]): Quby.Collections.QuestionOptions;
      private initializeQuestion(questionAttributes: QuestionAttributes, options: Quby.Collections.QuestionOptions)
    }
  }

  interface Textvar {
    key: string;
    description: string;
    default: string | null;
    depends_on_flag: boolean;
  }

  interface FlagDefinitions {
    [key: string]: IFlag;
  }

  interface FlagValues {
    [key: string]: boolean | null;
  }

  interface TextvarValues {
    [key: string]: string | null;
  }

  interface AnswerValue {
    [key: string]: any;
  }

  interface InitOptions {
    questionnaire_key: string;
    answer_value: AnswerValue;
    flag_definitions: FlagDefinitions;
    flag_values: FlagValues;
    textvars: TextvarValues;
  }
}

interface Quby {
  init: (options: Quby.InitOptions) => void;
  initTextVars: (textvars: Quby.Textvar[]) => void;
  initShowsHides: () => void;
  initFieldListeners: () => void;

  questionnaire_key: string;
  flags: Quby.Collections.Flags;
  questions: Quby.Collections.Questions;
  panels: Quby.Collections.Panels;
  answer: Quby.Models.Answer;
  textVars: Quby.Collections.Textvars;

  currentPanelQuestions: Quby.Collections.Questions;
}

declare global {
  const Quby: Quby;

  let displayMode: string;
  let isBulkOrSinglePage: boolean;
  let shownFlash: boolean;
}

export {};