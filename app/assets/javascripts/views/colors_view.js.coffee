jQuery ->
  class app.views.ColorsView extends Backbone.View
    initialize: ->
      @setModel(@model)
      @colorSideSwitcherView = new app.views.ColorSideSwitcherView()
    setModel: (model) ->
      @model = model
      model.bind('add', @render)
      model.bind('remove', @render)
    el: '#colors_chooser'
    events: {
      'click .color_selector': 'selectColor'
      'click .color_remover': 'removeColor'
      'change .opacity_slider': 'changeOpacity'
      'click #random_pallate': 'createRandomColors'
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
      colid = @model.getByCid(cid).get('colid')
      app.shapeManView.model?.setColor(colid)
      @highliteSelectedColor(cid)
    removeColor: (e) ->
      cid = e.currentTarget.attributes[1].value
      color = @model.getByCid(cid)
      alternateColor = @getColorOtherThan(color)
      color.noShapesAreUsingThis = true
      color.trigger("removeColor", color, alternateColor.cid)
      color.confirmationPresented = false
      if color.confirmedDelete || color.noShapesAreUsingThis
        @model.remove(color)
        $(".#{cid}").remove()
        @highliteSelectedColor(alternateColor.cid)
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
    createRandomColors: =>
      for i in [0..30]
        rgb = {}
        rgb.r = Math.floor(Math.random() * 256)
        rgb.g = Math.floor(Math.random() * 256)
        rgb.b = Math.floor(Math.random() * 256)
        rgb.alpha = .8
        app.word.get('colors').add(rgb)
    highliteSelectedColor: (colorId='c3') ->
      $(".selected_color").removeClass("selected_color")
      $(".arrow").remove()
      $("##{colorId}").parent().addClass("selected_color")
      $(".selected_color").append("<div class='arrow'><div class='arrow_tip'></div><div class='arrow_shaft'></div></div>")
