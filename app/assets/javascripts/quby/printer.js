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
