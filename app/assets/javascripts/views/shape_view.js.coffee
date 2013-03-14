jQuery ->
  class app.views.ShapeView extends Backbone.View
    elFrag: ".size_"
    initialize: ->
      $(".#{@model.cid}").on('click', @selectShape)
    render: (shape, options, size = 20, letterId) ->
      letterId = @model.collection.letterId
      if not @model.parent
        parent = $("#{@elFrag}#{size}.#{letterId}")
      else
        parent = $("#{@elFrag}#{size} .#{@model.parent}")

      m_attr = @model.attributes
      color = @model.getColor()

      if(letterId is app.shapes.letterId or size < 20)
        $("#{@elFrag}#{size} .#{@model.cid}").remove()
        parent.append("<div class='#{m_attr.shape_type} preview_shape #{@model.cid}'/>")
        shape = $("#{@elFrag}#{size} .#{@model.cid}")
        shape.css('z-index', @model.get('zindex'))
        shape.scale(m_attr.scale)
        @renderShape(shape, size, color, m_attr)
        shape.draggable(
          grid: [20, 20]
          start: @dragStart
          stop: @stop
        )
        if @model.child?
          childShape = @model.child
          childShape.view.render(childShape, {}, size, letterId)
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
  app.views.ShapeView::transform = (shape, m_attr) ->
    shape.rotate(m_attr.rotation)
    shape.skew(m_attr.skew.x, m_attr.skew.y)
    shape.translate(m_attr.translate.x, m_attr.translate.y)
