jQuery ->
  class app.views.TransformToolsView extends Backbone.View

    initialize: ->
    events:
      'click .plusSkewX': 'plusSkewX'
      'click .minusSkewX': 'minusSkewX'
      'click .plusSkewY': 'plusSkewY'
      'click .minusSkewY': 'minusSkewY'
      'click .plusTranslateX': 'plusTranslateX'
      'click .minusTranslateX': 'minusTranslateX'
      'click .plusTranslateY': 'plusTranslateY'
      'click .minusTranslateY': 'minusTranslateY'
      'click .plusScale': 'plusScale'
      'click .minusScale': 'minusScale'

    plusScale: (e) =>
      @model.scale(1)

    minusScale: (e) =>
      @model.scale(-1)

    plusTranslateX: (e) =>
      @model.translateX(1)

    minusTranslateX: (e) =>
      @model.translateX(-1)

    plusTranslateY: (e) =>
      @model.translateY(1)

    minusTranslateY: (e) =>
      @model.translateY(-1)

    plusSkewX: (e) =>
      @model.skewX(1)

    minusSkewX: (e) =>
      @model.skewX(-1)

    plusSkewY: (e) =>
      @model.skewY(1)

    minusSkewY: (e) =>
      @model.skewY(-1)
    resetZIndex: =>
      $(".#{@model.cid}").css('z-index', 86)

    render: (htmlElement) =>
      $(".tMenu").remove()
      $(htmlElement).append("<div class='tMenu'></div>")
      $(".tMenu").append("<div class='plusSkewX'>+skewX</div>")
        .append("<div class='minusSkewX'>-skewX</div>")
        .append("<div class='plusSkewY'>+skewY</div>")
        .append("<div class='minusSkewY'>-skewY</div>")
        .append("<div class='plusTranslateX'>+translateX</div>")
        .append("<div class='minusTranslateX'>-translateX</div>")
        .append("<div class='plusTranslateY'>+translateY</div>")
        .append("<div class='minusTranslateY'>-translateY</div>")
        .append("<div class='plusScale'>+scale</div>")
        .append("<div class='minusScale'>-scale</div>")
      if htmlElement.className.indexOf('Left') > 0
        $(".tMenu").css('left', 'auto').css('right', '20px')

    getCornerId: (e) ->
      parseInt(e.target.parentNode.parentNode.id.replace('r_', ''))
