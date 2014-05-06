
all_to_slider = ->
  $("input[type='range']").each ->
    new BetterSlider(this)

$ -> all_to_slider()
$(document).on 'ajax:error ajax:success', 'form', -> # complete doesn't always fire
  setTimeout ->
    all_to_slider()
  , 1

class BetterSlider
  constructor: (el) ->
    @$el = $(el)
    return if @$el.hasClass('made-slider')
    @$el.addClass('made-slider')

    @min = +@$el.attr('min') || 0
    @max = +@$el.attr('max') || 100
    @step = +@$el.attr('step') || 1
    @$slider = $('<div />')
    @$value_div = $('<div class="noUi-value" />')

    value = el.getAttribute('value') # in ie value is set on init.
    @init_slider()
    @start_invalid() unless value
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
    @add_wia_aria_support()
    @add_keyboard_interaction()

  add_value_div: ->
    handle = @$slider.data('base').data('handles')[0]
    handle.append(@$value_div)

  # Starts the slider as invalid, makes it valid on slide or click.
  start_invalid: ->
    @$el.addClass('invalid')
    @$slider.addClass('invalid')
    @$slider.one 'slide', =>
      @$el.removeClass('invalid')
    @$slider.data('base').data('handles')[0].one 'click', =>
      @$el.removeClass('invalid')
      @$el.val(@$slider.val())
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
  # keyboard_step = n * @step, with n∈ℕ, n>0
  keyboard_step: ->
    max_steps = 100
    min_keyboard_step = (@max-@min) / max_steps
    n = Math.ceil( min_keyboard_step / @step )
    n * @step

  add_wia_aria_support: ->
    @$slider.find('.noUi-handle')
      .attr('role', 'slider')
      .attr('aria-labelledby', @$slider.closest('.item').find('label').attr('for'))
      .attr('aria-valuemin', @min)
      .attr('aria-valuemax', @max)
      .attr('aria-valuenow', @$slider.val())
      .attr('aria-valuetext', @$slider.val())
    @$slider.on 'slide', =>
      @$slider.find('.noUi-handle').attr('aria-valuenow', @$slider.val())
      @$slider.find('.noUi-handle').attr('aria-valuetext', @$slider.val())
