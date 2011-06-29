jQuery ->
  class app.models.ShapesList extends Backbone.Collection
    model: app.models.Shape
    comparator: (shape) ->
      shape.get("zindex")
