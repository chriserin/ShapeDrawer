jQuery ->
  class app.models.Triangle extends app.models.Shape
    defaults: { shape_type: 'triangle' }
    initialize: ->
      $().extend(@attributes, @super_defaults)
    getColor: ->
      colors = @attributes.colors
      firstColor = colors[0]
      if typeof firstColor is 'number'
        app.colorsList.at(firstColor)
      else
        app.colorsList.getByCid(firstColor)
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
      @attributes.width + @attributes.squares[0] + @attributes.squares[2]
    generalHeight: ->
      @attributes.height + @attributes.squares[3]
