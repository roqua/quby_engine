describe "ajax error callbacks", ->
  beforeEach ->
    $('body').prepend('<form action="foobar" id="rails_ajax_form" data-remote="true">link</a>')
    $('body').prepend('<div class="flash" style="display: none"></div')
    this.xhr = sinon.useFakeXMLHttpRequest()
    requests = this.requests = []

    @xhr.onCreate =  (xhr)  ->
        requests.push(xhr)
  afterEach ->
    @xhr.restore();
    $('#rails_ajax_form').remove()
    $('.flash').remove()

  describe ".ajax:error with server error", ->
    it 'shows the flash block with a div with the error', ->
      expect($('.flash')).not.toBeVisible()
      $('#rails_ajax_form').trigger('submit')
      @requests[0].respond(500, { "Content-Type": "text/html" }, '<b class="error">error</b>')
      expect($('.flash')).toBeVisible()
      expect($('.flash .error-details')).toBeVisible()
      expect($('.flash .error-details')).toHaveText('error')

  describe ".ajax:error with server timeout", ->
    it 'shows the flash block with an iframe', ->
      expect($('.flash')).not.toBeVisible()
      $('#rails_ajax_form').trigger('submit')
      @requests[0].respond(0, {}, '')
      expect($('.flash')).toBeVisible()
      expect($('.flash')).toContainHtml('Controleer je internetverbinding en probeer het nogmaals')
