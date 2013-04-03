jQuery ->
  class app.views.ColorSideSwitcherView extends Backbone.View

    initialize: ->
      @side = 4

    el: "#color_side_holder"

    events:
      'click .color_side_switcher': 'switchSide'

    render: ->
      $(".color_side_switcher").remove()
      if app.shapeManView.model?.get("shape_type") is 'trectangle'
        $(@el).append("<div class='color_side_switcher'></div>")
        if @side is 0
          $(".color_side_switcher").css("border-left-color", "blue")
        else if @side is 1
          $(".color_side_switcher").css("border-top-color", "blue")
        else if @side is 2
          $(".color_side_switcher").css("border-right-color", "blue")
        else if @side is 3
          $(".color_side_switcher").css("border-bottom-color", "blue")
        else if @side is 4
          $(".color_side_switcher").css("border-color", "blue")

    switchSide: ->
      @side = (@side + 1) % 5
      @render()
