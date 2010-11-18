// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
//


// Fix HTML5 <input placeholder="foo"/> feature for older browsers

function placeholder(){
	$('input[placeholder],textarea[placeholder]').placeholder();
}
$(placeholder);
