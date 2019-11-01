import React from "react";
import ReactDOM from "react-dom";
import { Textvar } from "../components/Textvar";

export function initTextvars(textvars) {
  Quby.textvars = new Quby.Collections.Textvars(textvars);

  // Convert textvars to React components
  $("span[textvar]").each((idx, elm) => {
    console.log(elm);
    const textvar = elm.getAttribute("textvar");

    if (textvar) {
      ReactDOM.render(<Textvar textvar={textvar} />, elm);
    }
  });

  // Listen to changes of textvar inputs
  $(document).on("change", "input[sets_textvar]", function() {
    Quby.textvars.set(this.getAttribute("sets_textvar"), this.value);
  });

  // Initialize textvars from inputs once
  $('input[sets_textvar][value][value!=""]').trigger("change");
}
