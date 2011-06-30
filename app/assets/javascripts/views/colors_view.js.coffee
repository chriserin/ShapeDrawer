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
      color.view.render()
    selectColor: (e) ->
      cid = e.target.attributes[1].value
      app.shapeManView.model?.setColor(cid)
    removeColor: (e) ->
      cid = e.currentTarget.attributes[1].value
      color = @model.getByCid(cid)
      alternateColor = @getColorOtherThan(color)
      color.trigger("removeColor", color, alternateColor)
      color.confirmationPresented = false
      if color.confirmedDelete
        app.colorsList.remove(color)
        $(".#{cid}").remove()
    getColorOtherThan: (color) ->
      for i in [2...@model.length]
        if color isnt @model.at(i)
          return @model.at(i)
    changeOpacity: (e) ->
      cid = e.target.attributes[1].value
      colorModel = @model.getByCid(cid)
      colorModel.set({alpha: e.target.value * .01}) unless colorModel is @model.getTransparent()
      color = colorModel.to_s()
      $("##{cid}").css('background-color', color)
      @model.getByCid(cid).set({alpha: e.target.value * .01})
