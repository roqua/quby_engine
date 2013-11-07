
/*
 * jQuery deselectable/decheckable radio button plugin
 * 
 * Copyright 2009 David Sanders
 * Released under the LGPL license
 *
 * Usage:
 *
 *  a.) Apply to all elements of a radio group:
 *
 *      $('input[name="test"]').deselectable();
 *
 *  b.) or apply to a subset of buttons within a group:
 *
 *      $('input[name="test"][value="c"]').deselectable();
 *
 */

(function($) {

    $.fn.deselectable = function() {

        var radio_values = {};
        var radio_groups = {};

        return $(this).each(function() {

            // Prevent this callback from being applied to non-radio buttons and
            // radio buttons that have already been enabled
            if ($(this).attr("type") !== "radio" || $(this).data("_isDeselectable")) {
                return;
            }

            $(this).data("_isDeselectable", true);

            // Test for initially checked radios
            if (this.checked) {
                radio_values[this.name] = this.value;
            }

            $(this).click(function() {

                if (this.value === radio_values[this.name]) {
                    this.checked = false;
                    $(this).change();
                    radio_values[this.name] = null;
                }

                // 
                // Record which button is currently checked.  
                //
                // a.) This value is recorded here (as opposed to adding to the else statement
                // in the above click callback) to allow subsets of buttons to set
                // up as deselectable.
                //
                // This would normally happen with a change event but IE6 has issues with
                // radios and change - only fire on blur.
                //
                // b.) Apply after the first click so that radio groups created before attaching
                // to the dom are looked after.
                //

                if (!$(this).data("_isRecorded")) {
                    $('input[type="radio"][name="' + this.name + '"]').each(function() {
                        $(this).data("_isRecorded", true);
                        var record_radio_value = function() {
                        };
                        // Record the radio value now and for further click events
                        if (this.checked) {
                            radio_values[this.name] = this.value;
                        }
                        $(this).click(function() {
                            if (this.checked) {
                                radio_values[this.name] = this.value;
                            }
                        });
                    });
                }

            });

            radio_groups[this.name] = true;
        });

    };

})(jQuery);
