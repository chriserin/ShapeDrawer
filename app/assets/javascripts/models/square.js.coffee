jQuery ->
  class app.models.Square extends app.models.Shape
    defaults: { shape_type: 'rectangle' }
    initialize: ->
      $().extend(@attributes, @super_defaults)
      @attributes.height = 2
      @attributes.width = 2
    growUp: (spaces=1) ->
      @growInnerVertical(spaces)
    growDown: (spaces=1) ->
      @growInnerVertical(spaces)
    growLeft: (spaces=1) ->
      @growInnerHoriz(spaces)
    growRight: (spaces=1) ->
      @growInnerHoriz(spaces)
    shrinkUp:  ->
      @growInnerVertical(-1)
    shrinkDown: ->
      @growInnerVertical(-1)
    shrinkLeft: ->
      @growInnerHoriz(-1)
    shrinkRight: ->
      @growInnerHoriz(-1)
    getColor: ->
      colors = @attributes.colors
      firstColor = colors[0]
      if typeof firstColor is 'number'
        app.colorsList.at(firstColor)
      else
        app.colorsList.getByCid(firstColor)
    generalWidth: ->
      @attributes.width
    generalHeight: ->
      @attributes.height
