jQuery ->
  class app.views.ShapesChooserView extends Backbone.View
    initialize: ->
      $(".shapes_wrapper").sortable(
        update: (event, ui) ->
          sortable_ids = $(this).sortable('toArray')
          z_index = 10
          for sort_id in sortable_ids
            cid = sort_id.replace(/sort_/, '')
            model = app.shapes.getByCid(cid)
            model.set({zindex: z_index++ }) unless model.parent
            model.child?.set({zindex: z_index++})
          app.shapeChooserView.render()
        axis: "x"
        helper: 'clone'
      )
      
      if @model? then do @bindMethods
    el: '#shapes_chooser .shapes_wrapper'
    events: {
      'click .shape_chooser': 'selectShape',
      'click .shape_remover': 'removeShape',
      'click .shape_bufferer': 'bufferShape'
    }
    render: =>
      @model.sort()
      $(".shapes_wrapper").width(120 * @model.length)
      $('#shapes_chooser .shape_selector').remove()
      @model.each(@renderShapeSelector, @)
    renderShapeSelector: (shape)->
      selector = $("<div class='shape_selector shape_chooser_display shape_chooser' id='sort_#{shape.cid}'><div class='shape_selector_glass_top' name='#{shape.cid}'></div><div class='#{shape.get('shape_type')} selectable_shape #{shape.cid}'></div></div>")
      $(@el).append(selector)
      if(shape is app.shapeManView.model) then selector.addClass("selected_shape")
      @applyCSSToShapeSelector(shape)
      shape.unbind("change", @applyCSSToShapeSelector)
      shape.bind("change", @applyCSSToShapeSelector)
    applyCSSToShapeSelector: (shape) =>
      shapeSize = @getShapeSize(shape)
      shape.view.renderShape($(".shape_selector .#{shape.cid}"), shapeSize, shape.getColor(), shape.attributes)
      $(".shape_selector .#{shape.cid}").css('top', 0).css('left', 0).css('margin-top', -Math.round((shape.generalHeight() * shapeSize) / 2))
    selectShape: (e) ->
      @selectShapeWithModel(@model.getByCid(e.target.attributes[1].value))
    selectShapeWithModel: (selectedModel, displayToolsFlag = true) ->
      app.shapeManView.model?.toolsView.removeTools()
      app.shapeManView.model = selectedModel
      if displayToolsFlag then app.shapeManView.model.toolsView?.displayTools()
      @render()
      app.colorsView.colorSideSwitcherView.render()
      app.letterCommandsView.showChildShapeControls()
      app.colorsView.highliteSelectedColor(selectedModel?.get('colors')[0])
    removeShape: (e) ->
      cid = e.target.attributes[1].value
      removeShapeWithCid(cid)
    removeShapeWithCid: (cid) ->
      app.shapes.remove(@model.getByCid(cid))
      $(".#{cid}").remove()
      @selectShapeWithModel(@model.first(), false)
    bufferShape: ->
    changeModel: (model) ->
      @model = model
      do @bindMethods
      do @render
    bindMethods: ->
      @model.bind('add', @render)
      @model.bind('remove', @render)
    getShapeSize: (shape) ->
      length = if shape.generalWidth() > shape.generalHeight() then shape.generalWidth() else shape.generalHeight()
      size = Math.round(100 / length)
