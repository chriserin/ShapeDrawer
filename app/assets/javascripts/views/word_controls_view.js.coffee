jQuery ->
  class app.views.WordControlsView extends Backbone.View
    el: $('#word_controls')
    events: {
      'click #letter_adder': 'addLetter',
      'click #letter_deleter': 'deleteLetter',
      'click #view_switcher': 'switchView',
      'click #save': 'save',
      'click #load': 'load'
    }
    addLetter: ->
      letter = new app.models.Letter()
      app.word.get('letters').add(letter)
      app.shapes = letter.get('shapes')
      app.shapeChooserView.changeModel(app.shapes)
      $("#shapes_chooser .shape_selector").remove()
      do @clearGraphPaper
      app.wordView.selectLetter({ target: {parentNode: {id: letter.cid}}})
    deleteLetter: (e) ->
      app.word.get('letters').remove(app.letter)
      letter = app.word.get('letters').first()
      app.wordView.selectLetter({ target: {parentNode: {id: letter.cid}}})
    switchView: ->
    save: ->
    load: ->
    clearShapeChooser: ->
    clearGraphPaper: ->
      $(".graph_paper .preview_shape").remove()
