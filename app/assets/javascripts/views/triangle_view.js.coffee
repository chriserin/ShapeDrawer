jQuery ->
  class app.views.TriangleView extends app.views.ShapeView

    initialize: ->
      @model.bind('change', _.bind(@.render, @))
      @model.view = @
      super()

    tagName: 'div'

    el: '.size_'

    renderShape: (shape, size, color, m_attr) ->
      shape.set_triangle_shape_color(m_attr.orientation, color.to_s())
      shape.move_to(m_attr.position.left * size, m_attr.position.top * size)
      shape.clear_border_sizes()
      shape.set_a_size(m_attr.orientation, m_attr.squares[0] * size)
      shape.set_d_size(m_attr.orientation, m_attr.squares[3] * size)
      shape.set_c_size(m_attr.orientation, m_attr.squares[2] * size)
      shape.round_corners(m_attr.corner_depths, size, m_attr.orientation)
      @transform(shape, m_attr)
