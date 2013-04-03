jQuery ->
  class app.views.LetterView extends Backbone.View

    el: '#word_view'

    render: =>
      $(".letter_selector.#{@model.cid}").remove()
      $(@el).append("<div class='letter_display letter_selector size_6 #{@model.cid}' id='#{@model.cid}'><div class='letter_glass_top'></div></div>")
      @renderLetterAspects()

    renderLetterAspects: =>
      @dimensionsChange(@model.get('grid'), {}, @model.letter)
      @model.get('grid').view.render()
      @model.get('shapes')?.each( (shape) -> shape.view.render())

    dimensionsChange: (grid, options, letter=app.letter) ->
      $(".size_6.#{@model.cid}").height(grid.get("grid_height") * 6)
      $(".size_6.#{@model.cid}").width(grid.get("grid_width") * 6)
