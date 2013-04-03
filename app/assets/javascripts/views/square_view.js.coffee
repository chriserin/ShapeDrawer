jQuery ->
  class app.views.SquareView extends app.views.ShapeView

    initialize: ->
      @model.bind('change', _.bind(@render, @))
      @model.view = @
      super()
    tagName: 'div'
    el: '.size_'

    renderShape: (shape, size = 20, color, m_attr) ->
      shape.set_rectangle_shape_color(m_attr.orientation, color.to_s)
      shape.clear_border_sizes()
      shape.move_to(m_attr.position.left * size, m_attr.position.top * size)
      shape.set_a_size_rectangle(m_attr.orientation, m_attr.width * size)
      shape.set_b_size_rectangle(m_attr.orientation, m_attr.height * size)
      shape.round_corners(m_attr.corner_depths, size, m_attr.orientation)
      app.views.ShapeView::transform(shape, m_attr)
