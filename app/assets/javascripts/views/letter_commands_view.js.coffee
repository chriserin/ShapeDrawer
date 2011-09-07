jQuery ->
  class app.views.LetterCommandsView extends Backbone.View
    el: $('#letter_commands')
    events: {
      'click #triangle_adder': 'addTriangle',
      'click #rectangle_adder': 'addRectangle',
      'click #trectangle_adder': 'addTrectangle',
      'click #child_triangle_adder': 'addChildTriangle',
      'click #child_rectangle_adder': 'addChildRectangle',
      'click #child_trectangle_adder': 'addChildTrectangle'
    }
    instantiate: ->
      @showChildShapeControls()
    addTriangle: ->
      triangle = new app.models.Triangle()
      triangleView = new app.views.TriangleView({model: triangle})
      @renderShape(triangleView)
    addRectangle: ->
      rectangle = new app.models.Square()
      squareView = new app.views.SquareView({model: rectangle})
      @renderShape(squareView)
    addTrectangle: ->
      trectangle = new app.models.Trectangle()
      trectangleView = new app.views.TrectangleView({model: trectangle})
      @renderShape(trectangleView)
    renderShape: (view) ->
      app.shapes.add(view.model)
      view.model.set({zindex: app.shapes.length + 10}, {silent: true})
      view.render(view.model)
      view.render(view.model, 6)
      app.shapeChooserView.selectShapeWithModel(view.model)
      toolsView = new app.views.ShapeToolsView({model: view.model})
    addChildTriangle: ->
      triangle = new app.models.Triangle()
      triangleView = new app.views.TriangleView({model: triangle})
      @renderChildShape(triangleView)
    addChildRectangle: ->
      rectangle = new app.models.Square()
      rectangleView = new app.views.SquareView({model: rectangle})
      @renderChildShape(rectangleView)
    addChildTrectangle: ->
      trectangle = new app.models.Trectangle()
      trectangleView = new app.views.TrectangleView({model: trectangle})
      @renderChildShape(trectangleView)
    renderChildShape: (view) ->
      app.shapes.add(view.model)
      parent = app.shapeManView.model
      app.shapeChooserView.removeShapeWithCid(parent.child.cid) if parent.child
      parent.child = view.model
      view.model.parent = parent.cid
      view.model.set({zindex: 20}, {silent: true})
      app.shapeChooserView.selectShapeWithModel(view.model)
      toolsView = new app.views.ShapeToolsView({model: view.model})
      parent.view.render(app.shapeManView.model)
      parent.view.render(app.shapeManView.model, 6)
    showChildShapeControls: ->
      if app.shapeManView.model?.get('shape_type') is 'trectangle'
        $(".child_shape_mechanism").show()
      else
        $(".child_shape_mechanism").hide()
        
