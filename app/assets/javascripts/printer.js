(function($) {

  isPrinting = false
  
  var defaults = { print_container: 'x_print_container'},
      settings = {}
      
  jQuery.fn.outer = function() {
    return $($('<div></div>').html(this.clone().removeClass(this.attr("class")).addClass("x_print_container"))).html();
  }

  $.fn.print_area = function(options){
    
    $.extend(settings, defaults, options);
    
    var doc = document,
        win = window,
        container = $(this),
        old_parent = container.parent(),
        origDisplay = [],
        NONE = 'none',
        body = doc.body,
        childNodes = body.childNodes;      
    
    if (isPrinting) { // block the button while in printing mode
      return;
    }
    
    isPrinting = true;
    
    // iframe approach => not used because slow
    // var $iframe = $("<iframe  />")
    // 
    // $iframe.css({ position: "absolute", width: "0px", height: "0px", left: "-600px", top: "-600px" })
    // 
    // $iframe.appendTo("body")
    // 
    // var doc = $iframe[0].contentWindow.document
    // 
    // doc.write("<link type='text/css' rel='stylesheet' href='/stylesheets/layouts/div_print_layout.css' media='print' />");
    // 
    // doc.write(container.outer())
    // 
    // doc.close();
    // 
    // $iframe[0].contentWindow.focus();
    // 
    // setTimeout( function() { $iframe[0].contentWindow.print(); isPrinting = false }, 1000);

    // hide all body content
        
    // extract print content
    $(body).append(container);
    
    // run before_filter if present
    if (settings.beforeFilter)
      settings.beforeFilter()
    
    // print
    win.print();
    
    // allow the browser to prepare before reverting
    setTimeout(function() {
      // put back print content
      old_parent.prepend(container)
        
      // run after_filter if present
      if (settings.afterFilter){
        settings.afterFilter();        
      }
      isPrinting = false;
    
    }, 1000);

  }

})(jQuery);
