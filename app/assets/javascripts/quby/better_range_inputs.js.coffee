$(->
  $("input[type='range']").each(->
    new BetterSlider(this)
  )
)

class BetterSlider
  constructor: (el) ->
    @$el = $(el)
    @min = +@$el.attr('min') || 0
    @max = +@$el.attr('max') || 100
    @step = +@$el.attr('step') || 1
    @$slider = $('<div />')
    @$value_div = $('<div class="noUi-value" />')

    @init_slider()
    @start_invalid() unless el.attributes['value']
    @$el.watch 'disabled', {call_immediately: true}, @copy_disabled, true

  init_slider: ->
    @$el.after(@$slider)

    @set_slider
      range: [@min, @max],
      start: @$el.val() || (@max+@min)/2,
      handles: 1,
      step: @step,
      serialization:
        to: [[@$el, [@$value_div, 'html']]],
        resolution: Math.min [@step, 1]...

    @$el.hide() unless @$el.data('show-values')
    @$el.prop('type', 'text').removeClass('slider')

  set_slider: (options) ->
    initialized = @$slider.hasClass('noUi-target')
    @$slider.noUiSlider(options, initialized)
    @add_value_div() if @$el.data('value-tooltip')
    @add_keyboard_interaction()

  add_value_div: ->
    handle = @$slider.data('base').data('handles')[0]
    handle.append(@$value_div)

  start_invalid: ->
    @$el.addClass('invalid')
    @$slider.addClass('invalid')
    @$slider.one 'slide', =>
      @$el.removeClass('invalid')
    @$el.val('')

  copy_disabled: =>
    if @$el.prop('disabled')
      @$slider.attr('disabled', 'disabled')
    else
      @$slider.removeAttr('disabled')

  add_keyboard_interaction: ->
    @$slider.find('.noUi-handle').attr('tabindex', '0').on 'keydown', (e) =>
      return if @$el.prop('disabled')
      value = parseFloat( @$slider.val() );
      switch e.which
        # page-down, left-, up-arrow
        when 34, 37, 40 then @$slider.val( value - @keyboard_step(), true )
        # page-up, right-, down-arrow
        when 33, 39, 38 then @$slider.val( value + @keyboard_step(), true )
        when 36 then @$slider.val( @min, true ) # home
        when 35 then @$slider.val( @max, true ) # end
        when 27 then $(e.target).blur()   # escape
        else return
      e.preventDefault()

  # step size for keyboard interaction.
  keyboard_step: ->
    Math.max @step, (@max-@min)/100
