jQuery ->
  class app.views.RoundToolsView extends Backbone.View
    initialize: ->
    events:
      'click .rCorner': 'roundCorner'
      'click .rAll':  'roundAllCorners'
      'click .urCorner': 'unroundCorner'
      'click .urAll': 'unroundAllCorners'
      'click .rCorner,.rAll,.urCorner,.urAll': 'resetZIndex'
    roundCorner: (e) =>
      cornerId = @getCornerId(e)
      @model.roundCorner(cornerId, 1)
    roundAllCorners: =>
      @model.roundCorners()
    unroundCorner: (e) =>
      cornerId = @getCornerId(e)
      @model.roundCorner(cornerId, -1)
    unroundAllCorners: =>
      @model.roundCorners(-1)
    roundTopLeft: =>
      @model.roundCorner(0, 1)
    roundTopRight: =>
      @model.roundCorner(1, 1)
    roundBottomLeft: =>
      @model.roundCorner(3, 1)
    roundBottomRight: =>
      @model.roundCorner(2, 1)
    resetZIndex: =>
      $(".#{@model.cid}").css('z-index', 86)
    render: (htmlElement) =>
      $(".rMenu").remove()
      $(htmlElement).append("<div class='rMenu'><div class='rCorner'>+corner</div><div class='rAll'>+all</div><div class='urCorner'>-corner</div><div class='urAll'>-all</div></div>")
      if htmlElement.className.indexOf('Left') > 0
        $(".rMenu").css('left', 'auto').css('right', '20px')
    getCornerId: (e) ->
      parseInt(e.target.parentNode.parentNode.id.replace('r_', ''))
