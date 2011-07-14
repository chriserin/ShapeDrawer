jQuery ->
  class app.models.ShapesList extends Backbone.Collection
    model: app.models.Shape
    comparator: (shape) ->
      shape.get("zindex")
    initialize: ->
    _prepareModel: (model, options) =>
      if not (model instanceof Backbone.Model)
        attrs = model
        model = @createModelWithAttrs(attrs, {collection: this})
        if(model.validate and ! model._performValidation(attrs, options)) then model = false
      else if(! model.collection)
        model.collection = @
      return model
    createModelWithAttrs: (attrs, additionalAttrs) ->
      if(attrs.shape_type is 'triangle')
        shape = new app.models.Triangle(attrs, additionalAttrs)
        new app.views.TriangleView({model: shape})
      else if(attrs.shape_type is 'trectangle')
        shape = new app.models.Trectangle(attrs, additionalAttrs)
        new app.views.TrectangleView({model: shape})
      else if(attrs.shape_type is 'rectangle')
        shape = new app.models.Square(attrs, additionalAttrs)
        new app.views.SquareView({model: shape})
      shape.collection = this
      shape.toolsView = new app.views.ShapeToolsView({model: shape})
      return shape

