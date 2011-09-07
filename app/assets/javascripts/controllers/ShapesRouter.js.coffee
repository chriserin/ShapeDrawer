jQuery ->
  class app.routers.ShapesRouter extends Backbone.Router
    routes:
      "NewWord": "newWord"
      "ViewAll": "viewAll"
      "Edit/:id": "editWord"
      "": "showBlankPallette"
    newWord: ->
      app.appView.createWord()
    viewAll: ->
      app.appView.displayWords()
    editWord: (id) ->
      word = new app.models.Word({id: id})
      word.fetch({success: @switchWord})
    switchWord: (model) ->
      app.appView.switchWord(model)
      app.appView.displayPallette()
    showBlankPallette: () ->
      app.appView.displayPallette()
