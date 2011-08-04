jQuery ->
  class app.models.Square extends app.models.Shape
    defaults: { shape_type: 'rectangle' }
    initialize: (attributes) ->
      if not attributes.colors
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
    generalWidth: ->
      if @attributes.orientation in [0, 2] then @attributes.width else @attributes.height
    generalHeight: ->
      if @attributes.orientation in [0, 2] then @attributes.height else @attributes.width
