jQuery ->
  class app.models.Trectangle extends app.models.Shape
    defaults: { shape_type: 'trectangle' }
    initialize: ->
      @super_defaults.colors = [2, 2, 2, 2]
      $().extend(@attributes, @super_defaults)
      @attributes.height = 1
      @attributes.width = 1
    getColors: ->
      colors = for i in [0..3]
        @getColor i
    generalWidth: ->
      @attributes.width + @getSideSize(0) + @getSideSize(2)
    generalHeight: ->
      @attributes.height + @getSideSize(1) + @getSideSize(3)
    getSideSize: (side) ->
      if @attributes.squares[side] > 0 then @attributes.squares[side] else 0
    setColor: (colorId) ->
      colors = @get 'colors'
      side = app.colorsView.colorSideSwitcherView.side
      if side is 4
        colors[0] = colors[1] = colors[2] = colors[3] = colorId
      else
        side = (side - @attributes.orientation + 4) % 4
        colors[side] = colorId
      @set {'colors': colors}
      do @change
