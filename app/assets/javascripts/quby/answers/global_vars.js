var curPanel;
var panelInputs;
var focusI = 0;

var hashChangeEnabled;
var lastInput;
var nextButtonFocussed = false;
var saveButtonFocussed = false;
var isBulk;
var fail_vals = new Array();
var validationI = 0;
var hotkeysEnabled;
var skipValidations = false;
var shownFlash = false;
var inIframe = self != top;

var scrollToNextQuestion = false;
var curQuestionInputIndex;
var questionInputs;
var nextQuestionInput;
