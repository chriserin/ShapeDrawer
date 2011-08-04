jQuery ->
  class app.views.AppView extends Backbone.View
    initialize: ->
    renderPallette: ->
      cid = app.word.get('letters').first()
      app.wordView.selectLetterWithCid(cid)
      app.wordView.render()
      app.colorsView.render()
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
      app.colorsView ||= new app.views.ColorsView()
      app.colorsView.setModel(word.get('colors'))
      @renderPallette()
    displayWords: ->
      @hidePalletteControls()
      app.words = new app.models.WordList([], {group: 'allButSession'} )
      app.sessionWords = new app.models.WordList([], {group: 'session'} )
      app.views.WordListView::timeoutAmount = 100
      app.words.fetch({success: @renderWordRepresentations})
      app.sessionWords.fetch({success: @renderSessionWords})
    renderWordRepresentations: (words) ->
      app.wordListView ||= new app.views.WordListView()
      app.wordListView.model = words
      app.wordListView.render()
    renderSessionWords: (words) ->
      app.sessionWordListView ||= new app.views.WordListView({el: "#session_words_list"})
      app.sessionWordListView.model = words
      app.sessionWordListView.render()
    hidePalletteControls: ->
      $("#letter_commands").hide()
      $("#shapes_chooser").hide()
      $("#colors_chooser").hide()
      $("#grid_view").hide()
      $("#grid_controls_view").hide()
      $("#word_view").hide()
      $("#app_menu_view").hide()
      $("#words_display").show()
    displayPallette: ->
      $("#letter_commands").show()
      $("#shapes_chooser").show()
      $("#colors_chooser").show()
      $("#grid_view").show()
      $("#grid_controls_view").show()
      $("#word_view").show()
      $("#app_menu_view").show()
      $("#words_display").hide()
    selectWord: (cid) ->
      word = app.words.getByCid(cid)
      word = app.sessionWords.getByCid(cid) unless word
      @switchWord(word)
      @displayPallette()
