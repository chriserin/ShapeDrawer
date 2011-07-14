jQuery ->
  class app.models.Trectangle extends app.models.Shape
    defaults: { shape_type: 'trectangle' }
    initialize: (attributes) ->
      if not attributes.colors
        @super_defaults.colors = [2, 2, 2, 2]
        $().extend(@attributes, @super_defaults)
        @attributes.height = 1
        @attributes.width = 1
    getColors: ->
      colors = for i in [0..3]
        @getColor i
    generalWidth: ->
      if(@attributes.orientation in [0, 2])
        @attributes.width + @getSideSize(0) + @getSideSize(2)
      else
        @attributes.height + @getSideSize(1) + @getSideSize(3)
    generalHeight: ->
      if(@attributes.orientation in [0, 2])
        @attributes.height + @getSideSize(1) + @getSideSize(3)
      else
        @attributes.width + @getSideSize(0) + @getSideSize(2)
    getSideSize: (side) ->
      if @attributes.squares[side] > 0 then @attributes.squares[side] else 0
    setColor: (colorId) ->
      colors = @get 'colors'
      side = app.colorsView.colorSideSwitcherView.side
      previousColor = app.colorsList.getByCid(colors[side]) || app.colorsList.getByCid(colors[0])
      previousColor?.unbind("removeColor", @processRemoveColor)
      previousColor?.unbind("change:alpha", @viewRender)
      if side is 4
        colors[0] = colors[1] = colors[2] = colors[3] = colorId
      else
        side = (side - @attributes.orientation + 4) % 4
        colors[side] = colorId
      @set {'colors': colors}
      do @change
      color = app.colorsList.getByCid(colorId)
      color.bind("removeColor", @processRemoveColor)
      color.bind("change:alpha", @viewRender)
