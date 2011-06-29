jQuery ->
  class app.models.Letter extends Backbone.Model
    initialize: ->
      @set {'shapes': new app.models.ShapesList}
      @get('shapes').letterId = @cid
    removeShape: (shapeModel) ->
      @get('shapes').remove(shapeModel)

