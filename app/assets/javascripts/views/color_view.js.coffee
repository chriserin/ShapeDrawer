
jQuery ->
  class app.views.ColorView extends Backbone.View
    initialize: ->
    el: '#colors_chooser'
    render: ->
      colorContainer = @getColorContainer()
      whiteBackgroundDiv = $("<div class='white_background'></div>")
      slider = $("<input type='range' name='#{@model.cid}' min='0' max='100' step='5' value='80' class='opacity_slider'></input>")
      colorDiv = $("<div class='color_selector color_chooser' id='#{@model.cid}'></div>")
        .css('background-color', @model.to_s())
        .append(slider)
      wholeColorDiv = $("<div class='color_wrapper'></div>")
        .append(colorDiv)
        .append("<div class='color_remover' name='#{@model.cid}'><div class='del_shape_sign'></div><div class='del_shape_sign_vert'></div></div>")
        .append(whiteBackgroundDiv)
      colorContainer.append(wholeColorDiv)
    getColorContainer: ->
      color = @model.attributes
      if color.r > color.g and color.r  > color.b
        $(".reds_container")
      else if color.g > color.r and color.g > color.b
        $(".greens_container")
      else if color.b > color.r and color.b > color.g
        $(".blues_container")
      else
        $(".grays_container")
