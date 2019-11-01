/// <reference types="jquery" />

import { IFlag, IPanel, IQuestion, IQuestionOption, QuestionKey } from "./lib/models";
import { InitQuestions } from "./lib/init_questions";
import { Textvar } from "components/Textvar";

declare module Backbone {
  interface ModelFetchOptions {
    success: () => void;
    error: () => void;
  }

  interface EventHandler {
    (...args: any[]): void;
  }

  class Events {
    on(event: string, callback: EventHandler, context?: any);
    off(event: string, callback: EventHandler, context?: any);
  }

  class Model<T> extends Events {
    get<K extends keyof T>(attributeName: K): T[K];
    set(attributes: Partial<T>): void;
    fetch(options?: ModelFetchOptions): JQueryXHR;
  }

  class Collection<T> extends Events {
    models: T[];
    length: number;
    add(models: T | T[]): void;
    fetch(): void;
    findWhere(attributes: object): T | undefined;
  }
}

declare global {
  namespace QubyNS {
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

      class Panels extends Backbone.Collection<Models.Panel> {}

      class QuestionOptions extends Backbone.Collection<Models.QuestionOption> {}

      class Questions extends Backbone.Collection<Models.Question> {
        noneVisible: () => boolean;
        addQuestions: (questions: any) => void;
      }

      class Textvars extends Backbone.Events {
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
        view_id: string;
      }

      class InitQuestions {
        constructor(questions: IQuestion[]);
        initializeQuestions(): QubyNS.Collections.Questions;

        private initializeOptions(optionAttributes: OptionAttributes[]): QubyNS.Collections.QuestionOptions;
        private initializeQuestion(questionAttributes: QuestionAttributes, options: QubyNS.Collections.QuestionOptions);
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

  interface QubyGlobalCollections {
    Flags: typeof QubyNS.Collections.Flags;
    Panels: typeof QubyNS.Collections.Panels;
    QuestionOptions: typeof QubyNS.Collections.QuestionOptions;
    Questions: typeof QubyNS.Collections.Questions;
    Textvars: typeof QubyNS.Collections.Textvars;
  }

  interface QubyGlobalModels {
    Answer: typeof QubyNS.Models.Answer;
    Flag: typeof QubyNS.Models.Flag;
    Panel: typeof QubyNS.Models.Panel;
    QuestionOption: typeof QubyNS.Models.QuestionOption;
    Question: typeof QubyNS.Models.Question;
  }

  interface QubyGlobalLogic {
    InitQuestions: typeof InitQuestions;
  }

  interface QubyGlobalComponents {
    Textvar: typeof Textvar;
  }

  interface QubyGlobal {
    Models: any;
    Collections: QubyGlobalCollections;
    Views: any;
    Logic: QubyGlobalLogic;
    Components: QubyGlobalComponents;

    init: (options: QubyNS.InitOptions) => void;
    initTextvars: (textvars: QubyNS.Textvar[]) => void;
    initShowsHides: () => void;
    initFieldListeners: () => void;

    questionnaire_key: string;
    flags: QubyNS.Collections.Flags;
    questions: QubyNS.Collections.Questions;
    panels: QubyNS.Collections.Panels;
    answer: QubyNS.Models.Answer;
    textvars: QubyNS.Collections.Textvars;

    currentPanelQuestions: QubyNS.Collections.Questions;
  }

  const Quby: QubyGlobal;

  let displayMode: string;
  let isBulkOrSinglePage: boolean;
  let shownFlash: boolean;
}

export {};
