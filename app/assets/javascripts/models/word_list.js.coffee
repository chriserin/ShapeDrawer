jQuery ->
  class app.models.WordList extends Backbone.Collection
    model: app.models.Word
    url: '/words'

