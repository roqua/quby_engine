#_ = require('underscore')

invoke = (method_name, args...) ->
  compare: (actual, expected) ->
    if _.isFunction(actual[method_name])
      pass: actual[method_name].apply(actual, args)
    else
      args.unshift(actual)
      pass: _[method_name].apply(actual, args)

beforeEach ->
  jasmine.addMatchers
    toBeEmpty: ->
      invoke.call(this, 'isEmpty')

    toInclude: (items...) ->
      _(items).all (item) =>
        invoke.call(this, 'include', item)

    toIncludeAny: (items...) ->
      _(items).any (item) =>
        invoke.call(this, 'include', item)

    toBeCompact: ->
      elements = invoke.call(this, 'map', _.identity)
      _.isEqual elements, _.compact(elements)

    toBeUnique: ->
      elements = invoke.call(this, 'map', _.identity)
      _.isEqual elements, _.uniq(elements)

    toRespondTo: (methods...)->
      _.all methods, (method) =>
        _.isFunction(@actual[method])

    toRespondToAny: (methods...)->
      _.any methods, (method) =>
        _.isFunction(@actual[method])

    toHave: (attrs...) ->
      _.all attrs, (attr) =>
        invoke.call(this, 'has', attr)

    toHaveAny: (attrs...) ->
      _.any attrs, (attr) =>
        invoke.call(this, 'has', attr)

    toBeAnInstanceOf: ->
      compare: (actual, clazz) ->
        pass: actual instanceof clazz

    toBeA: ->
      compare: (actual, clazz) ->
        pass: actual instanceof clazz

    toBeAn: ->
      compare: (actual, clazz) ->
        pass: actual instanceof clazz
