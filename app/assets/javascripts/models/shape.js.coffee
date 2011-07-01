jQuery ->
  class app.models.Shape extends Backbone.Model
    constructor: ->
      @super_defaults = {
        colors: [2, 'transparent', 'transparent', 'transparent'],
        backgound_color: 'transparent',
        squares: [2, 2, 2, 2],
        position: {top: 0, left: 0},
        corner_depths: [0, 0, 0, 0],
        height: 0,
        width: 0,
        orientation: 0
      }
      super()
      @setColor(app.colorsList.last().cid)
    getColor: (side = 0) ->
      colors = @attributes.colors
      firstColor = colors[side]
      if typeof firstColor is 'number'
        app.colorsList.at(firstColor)
      else if (firstColor is 'transparent')
        app.colorsList.getTransparent()
      else
        app.colorsList.getByCid(firstColor)
    setColor: (colorId) ->
      colors = @get 'colors'
      previousColor = app.colorsList.getByCid(colors[0])
      previousColor?.unbind("removeColor", @processRemoveColor)
      previousColor?.unbind("change:alpha", @viewRender)
      colors[0] = colorId
      @set {'colors': colors}
      color = app.colorsList.getByCid(colorId)
      color.bind("removeColor", @processRemoveColor)
      color.bind("change:alpha", @viewRender)
      do @change
    viewRender: => 
      @view.render()
      do @change
    processRemoveColor: (color, alternateColor) =>
      color.noShapesAreUsingThis = false
      if(color.confirmedDelete)
        @setColor(alternateColor)
      else if ! color.confirmationPresented
        result = confirm('This color is used by a shape, do you still want to remove it?')
        color.confirmedDelete = result
        color.confirmationPresented = true
        if result then @setColor(alternateColor)
    moveVertical: (num) ->
      pos = @get 'position'
      pos.top += num
      @set {'position': pos}
      do @change
    moveHoriz: (num) ->
      pos = @get 'position'
      pos.left += num
      @set {'position': pos}
      do @change
    growSide: (side, num) ->
      sides =  @get 'squares'
      orientedSide = (side + @attributes.orientation) % 4
      if sides[orientedSide] + num > 0
        sides[orientedSide] += num
      else
        sides[orientedSide] = 0
      @set {'squares': sides}
      do @change
    roundCorners: (num=1)->
      corner_depths = @get 'corner_depths'
      corner_depths = for x in corner_depths
        if x + num < 0 then x else x + num
      @set {'corner_depths': corner_depths}
    roundCorner: (corner, num)->
      corner_depths = @get 'corner_depths'
      corner = (corner + @get('orientation')) % 4
      corner_depths[corner] += num unless corner_depths[corner] + num < 0
      @set {'corner_depths': corner_depths}
      do @change
    growInnerVertical: (num)->
      if @attributes.orientation in [0,2]
        @growHeight(num)
      else
        @growWidth(num)
    growInnerHoriz: (num)->
      if @attributes.orientation in [0,2]
        @growWidth(num)
      else
        @growHeight(num)
    growHeight: (num) ->
      h = @get 'height'
      if h + num > 0
        h += num
      else
        h = 0
      @set {'height': h}
    growWidth: (num) ->
      w = @get 'width'
      if w + num > 0
        w += num
      else
        w = 0
      @set {'width': w}
    rotate: ->
      o = @get 'orientation'
      o = (o + 1) % 4
      @set {'orientation': o}
    growLeft: (spaces = 1) ->
      @growSide(0, spaces)
    growUp: (spaces = 1) ->
      @growSide(1, spaces)
    growRight: (spaces = 1) ->
      @growSide(2, spaces)
    growDown: (spaces = 1) ->
      @growSide(3, spaces)
    shrinkUp: ->
      @growSide(2, -1)
    shrinkDown: ->
      @growSide(3, -1)
    shrinkRight: ->
      @growSide(1, -1)
    shrinkLeft: ->
      @growSide(0, -1)
