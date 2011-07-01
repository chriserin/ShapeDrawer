jQuery ->
  class app.views.WordView extends Backbone.View
    initialize: ->
      @model.bind('add', @render)
      @model.bind('remove', @render)
    el: '#word_view'
    events: {
      'click .letter_selector': 'selectLetter',
      'click #add_letter': 'addLetter'
    }
    render: =>
      $('.letter_selector, #add_letter').remove()
      @model.each(@renderLetter)
      do @renderAddLetter
    renderLetter: (letter) =>
      $(".letter_selector.#{letter.cid}").remove()
      $('#word_view').append("<div class='letter_display letter_selector size_6 #{letter.cid}' id='#{letter.cid}'><div class='letter_glass_top'></div></div>")
      @renderLetterAspects(letter)
    renderLetterAspects: (letter) =>
      @dimensionsChange(letter.get('grid'), {}, letter)
      letter.get('grid').view.render()
      letter.get('shapes')?.each( (x) -> x.view.render())
    renderAddLetter: ->
      $('#word_view').append("<div class='letter_display size_6' id='add_letter'><div class='add_letter_sign_horiz'></div><div class='add_letter_sign'></div><div class='letter_glass_top'></div></div>")
    dimensionsChange: (grid, options, letter=app.letter) ->
      $(".size_6.#{letter.cid}").height(grid.get("grid_height") * 6)
      $(".size_6.#{letter.cid}").width(grid.get("grid_width") * 6)
    selectLetter: (e) ->
      do app.wordCommandsView.clearGraphPaper
      app.letter?.get('grid').unbind("change", @dimensionsChange)
      app.letter = app.word.getByCid(e.target.parentNode.id)
      letter = app.letter
      shapes = letter.get('shapes')
      $('.graph_paper').removeClass(app.shapes.letterId)
      app.shapeChooserView.changeModel(shapes)
      $('.graph_paper').addClass(shapes.letterId)
      app.shapes = shapes
      @renderLetterAspects(letter)
      app.shapeChooserView.selectShapeWithModel(shapes.first(), false)
      app.letter.get('grid').bind("change", @dimensionsChange)
    addLetter: ->
      do app.wordCommandsView.addLetter
