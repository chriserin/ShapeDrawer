jQuery ->
  class app.views.GridControlsView extends Backbone.View

    el: '#grid_controls_view'

    events:
      'click .number_up.height': 'heightUp'
      'click .number_down.height': 'heightDown'
      'click .number_up.width': 'widthUp'
      'click .number_down.width': 'widthDown'

    heightUp: =>
      grid = app.letter.get('grid')
      height = grid.get('grid_height')
      height++
      grid.set({'grid_height': height})
      $("#grid_dimension_height").text(height)

    heightDown: =>
      grid = app.letter.get('grid')
      height = grid.get('grid_height')
      height--
      grid.set({'grid_height': height})
      $("#grid_dimension_height").text(height)

    widthUp: =>
      grid = app.letter.get('grid')
      width = grid.get('grid_width')
      width++
      grid.set({'grid_width': width})
      $("#grid_dimension_width").text(width)

    widthDown: =>
      grid = app.letter.get('grid')
      width = grid.get('grid_width')
      width--
      grid.set({'grid_width': width})
      $("#grid_dimension_width").text(width)
