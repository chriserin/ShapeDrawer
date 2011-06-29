jQuery ->
  class app.models.Grid extends Backbone.Model
    defaults: {
      grid_size:  20,
      grid_height: 20,
      grid_width: 20
    }

  class app.views.GridView extends Backbone.View
    initialize: ->
      @model.bind('change', _.bind(@.render, @))
    tagName: 'div'
    el: '.graph_paper'
    render: ->
      $("#{@el} .grid_square").remove('')
      g_height = @model.get('grid_height')
      g_width = @model.get('grid_width')
      g_size = @model.get('grid_size')
      for i in [0...(g_height * g_width)]
        $(@el).append("<div class='grid_square'/>")
      $(@el).height(g_size * g_height)
      $(@el).width(g_size * g_width)
      $('.grid_square').height(g_size - 2)
      $('.grid_square').width(g_size - 2)
