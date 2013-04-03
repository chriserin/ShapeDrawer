jQuery ->
  class app.views.ShapeManipulationView extends Backbone.View

    el: $('#shape_man_commands')

    events: {
          'click #grow_inner_height': "growInnerHeight",
          'click #shrink_inner_height': "shrinkInnerHeight",
          'click #grow_inner_width': "growInnerWidth",
          'click #shrink_inner_width': "shrinkInnerWidth"
      }

    initialize: ->
      #_.bindAll(this, 'moveDown')

    moveDown: ->
      @model.moveVertical(1)

    moveUp: ->
      @model.moveVertical(-1)

    moveLeft: ->
      @model.moveHoriz(-1)

    moveRight: ->
      @model.moveHoriz(1)

    rotate: ->
      @model.rotate()

    growUp: ->
      @model.growUp()
      @moveUp()

    growDown: ->
      @model.growDown()

    growRight: ->
      @model.growRight()

    growLeft: ->
      @model.growLeft()
      @moveLeft()

    shrinkUp: ->
      @model.shrinkUp()

    shrinkDown: ->
      @model.shrinkDown()
      @moveDown()

    shrinkRight: ->
      @model.shrinkRight()

    shrinkLeft: ->
      @model.shrinkLeft()
      @moveRight()

    roundCorners: ->
      @model.roundCorners(1)

    unroundCorners: ->
      @model.roundCorners(-1)

    roundTopLeft: ->
      @model.roundCorner(0, 1)

    roundTopRight: ->
      @model.roundCorner(1, 1)

    roundBottomLeft: ->
      @model.roundCorner(2, 1)

    roundBottomRight: ->
      @model.roundCorner(3, 1)

    growInnerHeight: ->
      @model.growInnerVertical(1)

    shrinkInnerHeight: ->
      @model.growInnerVertical(-1)

    growInnerWidth: ->
      @model.growInnerHoriz(1)

    shrinkInnerWidth: ->
      @model.growInnerHoriz(-1)
        
 
