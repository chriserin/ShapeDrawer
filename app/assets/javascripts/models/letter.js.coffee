jQuery ->
  class app.models.Letter extends Backbone.Model
    initialize: ->
      @view = new app.views.LetterView({model: @})
      @set({'shapes': new app.models.ShapesList(arguments[0]?.shapes)}, {silent: true})
      @get('shapes').letterId = @cid
      @set({'grid': new app.models.Grid(arguments[0]?.grid)}, {silent: true})
    removeShape: (shapeModel) ->
      @get('shapes').remove(shapeModel)
    toJSON: ->
      json = {grid: @attributes.grid.toJSON()}
      json = _.extend(json, {shapes: @attributes.shapes.toJSON()})
      return json
