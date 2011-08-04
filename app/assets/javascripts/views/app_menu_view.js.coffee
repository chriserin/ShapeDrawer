jQuery ->
  class app.views.AppMenuView extends Backbone.View
    el: "#app_menu_view"
    events:
      'click #save_word': 'saveWord'
      'click #view_words': 'viewWords'
      'click #output_word': 'outputWord'
      'click .number_up.size': 'sizeUp'
      'click .number_down.size': 'sizeDown'
    saveWord: ->
      app.word.save({}, {success: @saveSuccess})
    saveSuccess: =>
    viewWords: ->
      app.appView.displayWords()
    outputWord: =>
      if app.word.id
        window.open("/words/#{app.word.id}/output/#{$("#grid_dimension_size").text()}")
    sizeUp: =>
      size = $("#grid_dimension_size").text()
      size++
      $("#grid_dimension_size").text(size)
    sizeDown: =>
      size = $("#grid_dimension_size").text()
      size--
      $("#grid_dimension_size").text(size)
