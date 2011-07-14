jQuery ->
  class app.views.WordView extends Backbone.View
    initialize: ->
      @setModel()
    el: '#word_view'
    events: {
      'click .letter_selector': 'selectLetter',
      'click #add_letter': 'addLetter'
      'click #save_word': 'saveWord'
      'click #view_words': 'viewWords'
    }
    setModel: (model) =>
      if (model) then @model = model
      @model.get('letters').bind('add', @render)
      @model.get('letters').bind('remove', @render)
      @model.bind('change', @render)
    render: =>
      $('.letter_selector, #add_letter').remove()
      @model.get('letters').each(@renderLetter)
      do @renderAddLetter
    renderLetter: (letter) =>
      letter.view.render()
    renderAddLetter: ->
      letterDisplay = $("<div class='letter_display size_6' id='add_letter'></div>")
      letterDisplay.append("<div class='add_letter_sign_horiz'></div><div class='add_letter_sign'></div><div class='letter_glass_top'></div>")
      $('#word_view').append(letterDisplay)
    selectLetter: (e) ->
      @selectLetterWithCid(e.target.parentNode.id)
    selectLetterWithCid: (cid) ->
      do app.wordCommandsView.clearGraphPaper
      app.letter?.get('grid').unbind("change", @dimensionsChange)
      app.letter = app.word.get('letters').getByCid(cid)
      letter = app.letter
      shapes = letter.get('shapes')
      if(app.shapes) then $('.graph_paper').removeClass(app.shapes.letterId)
      app.shapeChooserView.changeModel(shapes)
      $('.graph_paper').addClass(shapes.letterId)
      app.shapes = shapes
      letter.view.renderLetterAspects()
      app.shapeChooserView.selectShapeWithModel(shapes.first(), false)
      app.letter.get('grid').bind("change", @dimensionsChange)
    addLetter: ->
      do app.wordCommandsView.addLetter
    saveWord: ->
      app.word.save()
    viewWords: ->
      app.appView.displayWords()
