/*-------------------------------------------------------------------- 
 * jQuery plugin: customInput()
 * by Maggie Wachs and Scott Jehl, http://www.filamentgroup.com
 * Copyright (c) 2009 Filament Group
 * Dual licensed under the MIT (filamentgroup.com/examples/mit-license.txt) and GPL (filamentgroup.com/examples/gpl-license.txt) licenses.
 * Article: http://www.filamentgroup.com/lab/accessible_custom_designed_checkbox_radio_button_inputs_styled_css_jquery/  
 * Usage example below (see comment "Run the script...").
--------------------------------------------------------------------*/


jQuery.fn.customInput = function(){
	$(this).each(function(i){	
		if($(this).is('[type=checkbox],[type=radio]')){
			var input = $(this);
			
			// get the associated label using the input's id
			var label = $('label[for='+input.attr('id')+']');
			
			//get type, for classname suffix 
			var inputType = (input.is('[type=checkbox]')) ? 'checkbox' : 'radio';
			
			// wrap the input + label in a div 
			//$('<div class="custom-'+ inputType +'"></div>').insertBefore(input).append(input, label);
			input.parents('.radiocheckwrapper').addClass('custom-' + inputType);
			
			// find all inputs in this set using the shared name attribute
			var allInputs = $('input[name='+input.attr('name')+']');
			
			// necessary for browsers that don't support the :hover pseudo class on labels
			label.hover(
				function(){ 
					$(this).parents('.option').find('.radiocheckwrapper').addClass('hover'); 
					if(inputType == 'checkbox' && input.is(':checked')){ 
						$(this).parents('.option').find('.radiocheckwrapper').addClass('checkedHover'); 
					} 
				},
				function(){ $(this).parents('.option').find('.radiocheckwrapper').removeClass('hover checkedHover'); }
			);
			
			//bind custom event, trigger it, bind click,focus,blur events
			input.bind('updateState', function(){	
				if (input.is(':checked')) {
					if (input.is(':radio')) {
						allInputs.each(function(){
							$('label[for='+$(this).attr('id')+']').parents('.option').find('.radiocheckwrapper').removeClass('checked');
						});		
					};
					label.parents('.option').find('.radiocheckwrapper').addClass('checked');
				}
				else { label.removeClass('checked checkedHover checkedFocus'); }
			
			})
			.trigger('updateState')
			.click(function(){ 
				$(this).trigger('updateState'); 
			})
			.focus(function(){ 
				label.addClass('focus'); 
				if(inputType == 'checkbox' && input.is(':checked')){ 
					$(this).addClass('checkedFocus'); 
				} 
			})
			.blur(function(){ label.removeClass('focus checkedFocus'); });
			
			input.parents(".radiocheckwrapper").click(function() {
			  selectedInput = $(this).find("input");
        
			  setCurrent(selectedInput[0]);

        $(this).closest(".fields").find("input[value=DESELECTED_RADIO_VALUE]").attr('checked', false);
        $(this).attr('checked', true);

        radioEvents(selectedInput[0]);
			})
		}
	});
};

	
	
