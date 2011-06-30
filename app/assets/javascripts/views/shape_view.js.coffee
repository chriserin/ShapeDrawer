jQuery ->
  class app.views.ShapeView extends Backbone.View
    initialize: ->
      $(".#{@model.cid}").live('click', @selectShape)
    render: (shape, options, size = 20) ->
      if not @model.parent
        letterId = @model.collection.letterId
        parent = $("#{@el}#{size}.#{letterId}")
      else
        parent = $("#{@el}#{size} .#{@model.parent}")

      m_attr = @model.attributes
      color = @model.getColor()

      if(letterId is app.shapes.letterId or size < 20)
        $("#{@el}#{size} .#{@model.cid}").remove()
        parent.append("<div class='#{m_attr.shape_type} preview_shape #{@model.cid}'/>")
        shape = $("#{@el}#{size} .#{@model.cid}")
        shape.css('z-index', @model.get('zindex'))
        @renderShape(shape, size, color, m_attr)
        shape.draggable(
          grid: [20, 20]
          start: @dragStart
          stop: @stop
        )
        if @model.child?
          childShape = @model.child
          childShape.view.render(childShape, {}, size)
      if size isnt 6 then @render shape, options, 6
    dragStart: (e) =>
      @selectShape()
      @offsetStartY = e.pageY
      @offsetStartX = e.pageX
      @model.toolsView.preventToolsDisplay()
    stop: (e) =>
      ySpaces = Math.round((e.pageY - @offsetStartY) / 20)
      xSpaces = Math.round((e.pageX - @offsetStartX) / 20)
      @model.moveVertical(ySpaces)
      @model.moveHoriz(xSpaces)
      @model.toolsView.allowToolsDisplay()
      true
    selectShape: (e) =>
      console.log(e)
      app.shapeChooserView.selectShapeWithModel(@model)
      return true
