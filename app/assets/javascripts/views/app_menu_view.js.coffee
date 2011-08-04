jQuery ->
  class app.views.AppMenuView extends Backbone.View
    el: "#app_menu_view"
    events:
      'click #save_word': 'saveWord'
      'click #view_words': 'viewWords'
      'click #output_word': 'outputWord'
    saveWord: ->
      app.word.save({}, {success: @saveSuccess})
    saveSuccess: =>
    viewWords: ->
      app.appView.displayWords()
    outputWord: =>
      if app.word.id
        window.open("/words/#{app.word.id}/output")
