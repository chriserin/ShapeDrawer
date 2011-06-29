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
      colors[0] = colorId
      @set {'colors': colors}
      do @change
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
      sides[orientedSide] += num
      @set {'squares': sides}
      do @change
    roundCorners: (num=1)->
      corner_depths = @get 'corner_depths'
      corner_depths = for x in corner_depths
        x + num
      @set {'corner_depths': corner_depths}
    roundCorner: (corner, num)->
      corner_depths = @get 'corner_depths'
      corner_depths[corner] += num
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
      h += num
      @set {'height': h}
    growWidth: (num) ->
      w = @get 'width'
      w += num
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
