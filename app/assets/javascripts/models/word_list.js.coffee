jQuery ->
  class app.models.WordList extends Backbone.Collection
    model: app.models.Word
    url: ->
      "/words?group=#{@group}"
    initialize: (models, options) ->
      if(options.group)
        @group = options.group
