jQuery ->
  class app.views.TrectangleView extends app.views.ShapeView

    initialize: ->
      @model.bind('change', _.bind(@render, @))
      @model.view = @
      super()

    tagName: 'div'

    el: '.size_'

    renderShape: (shape, size, color, m_attr) ->
      shape.set_trectangle_shape_color(m_attr.orientation, @model.getColor(0).to_s(), @model.getColor(1).to_s(), @model.getColor(2).to_s(), @model.getColor(3).to_s())
      shape.move_to(m_attr.position.left * size, m_attr.position.top * size)
      shape.clear_border_sizes()
      shape.set_a_size(m_attr.orientation, m_attr.squares[0] * size)
      shape.set_b_size(m_attr.orientation, m_attr.squares[1] * size)
      shape.set_c_size(m_attr.orientation, m_attr.squares[2] * size)
      shape.set_d_size(m_attr.orientation, m_attr.squares[3] * size)
      shape.round_corners(m_attr.corner_depths, size, m_attr.orientation)
      shape.set_a_size_rectangle(m_attr.orientation, m_attr.width * size)
      shape.set_b_size_rectangle(m_attr.orientation, m_attr.height * size)
      app.views.ShapeView::transform(shape, m_attr)
