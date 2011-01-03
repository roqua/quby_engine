// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//


// Fix HTML5 <input placeholder="foo"/> feature for older browsers

function placeholder(){
	var toPlaceHold = $('input[placeholder],textarea[placeholder]');
	if (toPlaceHold.length != 0){
		
	}
    //Hack to reposition the placeholders correctly on every call to this function
    //used at the end of validatePanel
    //toPlaceHold.trigger('focusout');
}

$(function(){
    //placeholder();
        
    //$.hint({attr:'placeholder'})
});
