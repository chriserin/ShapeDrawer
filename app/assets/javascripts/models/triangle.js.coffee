jQuery ->
  class app.models.Triangle extends app.models.Shape
    defaults: { shape_type: 'triangle' }
    initialize: (attributes, options) ->
      @super_defaults['squares'][1] = 0
      $().extend(@attributes, @super_defaults) unless attributes.colors
    growLeft: (spaces = 1) ->
      @growSide([0, 2, 0, 0][@get('orientation')], spaces)
    growRight: (spaces = 1) ->
      @growSide([2, 2, 2, 0][@get('orientation')], spaces)
    growUp: (spaces = 1) ->
      @growSide([3, 1, 1, 1][@get('orientation')], spaces)
    growDown: (spaces = 1) ->
      @growSide([3, 3, 1, 3][@get('orientation')], spaces)
    shrinkDown: ->
      @growSide(2, -1)
    generalWidth: ->
      if @attributes.orientation in [0, 2]
        @attributes.squares[0] + @attributes.squares[2]
      else
        @attributes.squares[3]
    generalHeight: ->
      if @attributes.orientation in [0, 2]
        @attributes.squares[3]
      else
        @attributes.squares[0] + @attributes.squares[2]
