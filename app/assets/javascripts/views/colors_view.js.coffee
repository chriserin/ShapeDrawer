jQuery ->
  class app.views.ColorsView extends Backbone.View
    initialize: ->
      @model.bind('add', @render)
      @model.bind('remove', @render)
      @colorSideSwitcherView = new app.views.ColorSideSwitcherView()
    el: '#colors_chooser'
    events: {
      'click .color_selector': 'selectColor',
      'click .color_remover': 'removeColor',
      'change .opacity_slider': 'changeOpacity'
    }
    render: =>
      $('#colors_chooser .color_selector').remove()
      $('#colors_chooser .color_remover').remove()
      $('#colors_chooser .color_wrapper').remove()
      @model.each(@renderColorSelector, @)
      @colorSideSwitcherView.render()
    renderColorSelector: (color)->
      colorContainer = @getColorContainer(color)
      whiteBackgroundDiv = $("<div class='white_background'></div>")
      slider = $("<input type='range' name='#{color.cid}' min='0' max='100' step='5' value='80' class='opacity_slider'></input>")
      colorDiv = $("<div class='color_selector color_chooser' id='#{color.cid}'></div>")
        .css('background-color', color.to_s())
      colorDiv.append(slider)
      wholeColorDiv = $("<div class='color_wrapper'></div>").append(colorDiv).append("<div class='color_remover' name='#{color.cid}'><div class='del_shape_sign'></div><div class='del_shape_sign_vert'></div></div>")
      wholeColorDiv.append(whiteBackgroundDiv)
      colorContainer.append(wholeColorDiv)
    selectColor: (e) ->
      cid = e.target.attributes[1].value
      app.shapeManView.model?.setColor(cid)
    removeColor: (e) ->
      cid = e.currentTarget.attributes[1].value
      app.colorsList.remove(@model.getByCid(cid))
      $(".#{cid}").remove()
    changeOpacity: (e) ->
      cid = e.target.attributes[1].value
      colorModel = @model.getByCid(cid)
      colorModel.set({alpha: e.target.value * .01}) unless colorModel is @model.getTransparent()
      color = colorModel.to_s()
      $("##{cid}").css('background-color', color)
      @model.getByCid(cid).set({alpha: e.target.value * .01})
    getColorContainer: (color) ->
      color = color.attributes
      if color.r > color.g and color.r  > color.b
        $(".reds_container")
      else if color.g > color.r and color.g > color.b
        $(".greens_container")
      else if color.b > color.r and color.b > color.g
        $(".blues_container")
      else
        $(".grays_container")
