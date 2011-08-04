jQuery ->
  class app.models.Color extends Backbone.Model
    initialize: (attributes) ->
      if attributes?.colid?
      else
        colid =  _.uniqueId('col')
        @set({'colid', colid})
      @view = new app.views.ColorView({model: @})
    defaults: {
      r: 200,
      g: 50,
      b: 50,
      alpha: .5
    }
    to_s: =>
      "rgba(#{@.get('r')}, #{@.get('g')}, #{@.get('b')}, #{@.get('alpha')})"
