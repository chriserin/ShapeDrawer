jQuery ->
  class app.views.AppView extends Backbone.View
    initialize: ->
    renderPallette: ->
      cid = app.word.get('letters').first()
      app.wordView.selectLetterWithCid(cid)
      app.wordView.render()
    displayBlankWord: ->
      @createWord()
      @displayPallette()
    createWord: ->
      word = new app.models.Word()
      app.word = word
      app.wordCommandsView.addLetter()
      @switchWord(word)
    switchWord: (word) ->
      app.word = word
      app.wordView ||= new app.views.WordView()
      app.wordView.setModel(app.word)
      app.wordCommandsView = new app.views.WordControlsView()
      app.appView = new app.views.AppView()
      @renderPallette()
    displayWords: ->
      @hidePalletteControls()
      app.words = new app.models.WordList()
      app.words.fetch({success: @renderWordRepresentations})
    renderWordRepresentations: (words) ->
      app.wordListView = new app.views.WordListView({model: words})
      app.wordListView.render()
    hidePalletteControls: ->
      $("#letter_commands").hide()
      $("#shapes_chooser").hide()
      $("#colors_chooser").hide()
      $("#grid_view").hide()
      $("#grid_controls_view").hide()
      $("#word_view").hide()
      $("#words_list").show()
    displayPallette: ->
      $("#letter_commands").show()
      $("#shapes_chooser").show()
      $("#colors_chooser").show()
      $("#grid_view").show()
      $("#grid_controls_view").show()
      $("#word_view").show()
      $("#words_list").hide()
    selectWord: (cid) ->
      word = app.words.getByCid(cid)
      @switchWord(word)
      @displayPallette()
