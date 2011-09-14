jQuery ->
  class app.views.ShapeToolsView extends app.views.ShapeManipulationView
    initialize: ->
      @model.toolsView = @
      $(@el).find(".#{@model.cid}").live('mouseover', @displayTools)
      $(".shape_tools_#{@model.cid}").live('mouseleave', @removeTools)
      $(".shape_tools_#{@model.cid} .rounder").live('click', @displayRoundTools)
      $(".shape_tools_#{@model.cid} #rotate").live('click', @rotate)
      $(".shape_tools_#{@model.cid} #fineRotate").live('click', @fineRotate)
      $(".shape_tools_#{@model.cid} #removeShape").live('click', @removeShape)
      $(".shape_tools_#{@model.cid} #showTransformTools").live('click', @displayTransformTools)
    el: '.graph_paper'
    setHoverRemove: (flag) ->
      @hoverRemove = flag
    displayRoundTools: (e) =>
      if($(".rMenu").length is 0)
        app.roundTools = new app.views.RoundToolsView({model: @model, el: $(e.target)})
        app.roundTools.render(e.target)
        return false
    displayTransformTools: (e) =>
      if($(".tMenu").length is 0)
        app.transformTools = new app.views.TransformToolsView({model: @model, el: $(e.target)})
        app.transformTools.render(e.target)
    displayTools: =>
      if @.__proto__.preventToolsDisplayFlag is true or @hoverRemove is false then return false 
      ShapeToolsView::currentToolsModel = @model
      @.__proto__.preventToolsDisplayFlag = true
      @setHoverRemove(true)
      @shape = $(@el).find(".#{@model.cid}")
      tempZIndex =  parseInt(@shape.css('z-index'))
      if tempZIndex < 80 
        @model.previousZIndex = tempZIndex
      @operatingZIndex = @model.previousZIndex + 80 + @getParentZIndex(@shape)
      @shape.css('z-index', @operatingZIndex)
      @shape.after("<div class='shape_tools_#{@model.cid} shape_tools'>")
      if @altToolsFlag
        do @displayAltTools
      else
        do @displayGrowRoundTools
      m_attr = @model.attributes
      scaleUnitY = @model.generalHeight() / 2
      scaleUnitX = @model.generalWidth() / 2
      toolsHeight = (@model.generalHeight()) * 20 * @model.get('scale')
      toolsWidth = (@model.generalWidth()) * 20 * @model.get('scale')
      scaleDifferenceWidth = (scaleUnitX * @model.get('scale')) - scaleUnitX
      scaleDifferenceHeight = (scaleUnitY * @model.get('scale')) - scaleUnitY
      tools = $(".shape_tools_#{@model.cid}")
        .move_to((m_attr.position.left - 1) * 20 - scaleDifferenceWidth * 20, (m_attr.position.top - 1) * 20 - scaleDifferenceHeight * 20)
        .set_a_size_rectangle(0, toolsWidth + 40)
        .set_b_size_rectangle(0, toolsHeight + 40)
        .css("z-index", @operatingZIndex - 1)
      app.views.ShapeView::transform(tools, @model.attributes)
      $(".graph_paper .#{@model.cid}").bind('click', @toggleAltTools)
      $(".rounder").css("z-index", @operatingZIndex + 1)
    getParentZIndex: (shape) ->
      zIndex = @shape.parent().css("z-index")
      if(isNaN(zIndex))
        10
      else
        parseInt(zIndex)
    displayAltTools: ->
      tools = $(".shape_tools_#{@model.cid} ")
        .append("<div class='topBar'><div class='growUp innergrower'></div><div class='rTopLeft' id='showTransformTools'>T</div></div>")
        .append("<div class='bottomBar'><div class='growDown innergrower'></div><div class='rounder rBottomRight' id='fineRotate'>&#8593;</div></div>")
        .append("<div class='leftBar'><div class='growLeft innergrower'></div><div class='rBottomLeft' id='removeShape'>X</div></div>")
        .append("<div class='rightBar'><div class='growRight innergrower'></div><div class='rTopRight' id='rotate'>&#8592;</div></div>")
      
      if(@model.get('shape_type') in ['triangle', 'rectangle'])
        $(".innergrower").removeClass("innergrower").addClass("grower")
        @addGrowerDrags()
      else
        @addInnerGrowerDrags()
      app.views.ShapeView::transform(tools, @model.attributes)
    addInnerGrowerDrags: ->
      dragOptions =
        grid: [20, 20]
        start: @dragStart
        axis: 'y'
        stop: @dragInnerGrowUp
      $(".growUp").draggable(dragOptions)
      dragOptions.stop = @dragInnerGrowDown
      $(".growDown").draggable(dragOptions)
      dragOptions.stop = @dragInnerGrowLeft
      dragOptions.axis = 'x'
      $(".growLeft").draggable(dragOptions)
      dragOptions.stop = @dragInnerGrowRight
      $(".growRight").draggable(dragOptions)
    removeTools: =>
      if @hoverRemove
        $(".shape_tools").remove()
        model = ShapeToolsView::currentToolsModel
        shape = $(@el).find(".#{model.cid}")
        .css('z-index', model.previousZIndex)
        @allowToolsDisplay()
        $(".graph_paper .#{model.cid}").unbind('click', model.toolsView.toggleAltTools)
    toggleAltTools: =>
      @altToolsFlag = ! @altToolsFlag
      do @removeTools
      do @displayTools
    displayGrowRoundTools: ->
      tools = $(".shape_tools_#{@model.cid} ")
        .append("<div class='topBar'><div class='growUp grower'></div><div class='rounder rTopLeft' id='r_0'>R</div></div>")
        .append("<div class='bottomBar'><div class='growDown grower'></div><div class='rounder rBottomRight' id='r_2'>R</div></div>")
        .append("<div class='leftBar'><div class='growLeft grower'></div><div class='rounder rBottomLeft' id='r_3'>R</div></div>")
        .append("<div class='rightBar'><div class='growRight grower'></div><div class='rounder rTopRight' id='r_1'>R</div></div>")
      @addGrowerDrags()
      tools.css("-webkit-transform", "rotate(#{@model.get('rotation')}deg)")
    addGrowerDrags: ->
      dragOptions =
        grid: [20, 20, 20 * Math.cos(@model.get('rotation') * Math.PI/180)]
        start: @dragStart
        stop: @dragGrowUp
        axis: 'y'
      $(".growUp").draggable(dragOptions)
      dragOptions.stop = @dragGrowDown
      $(".growDown").draggable(dragOptions)
      dragOptions.stop = @dragGrowLeft
      dragOptions.axis = 'x'
      $(".growLeft").draggable(dragOptions)
      dragOptions.stop = @dragGrowRight
      $(".growRight").draggable(dragOptions)
    dragStart: (e) =>
      @offsetStartY = e.pageY
      @offsetStartX = e.pageX
      @setHoverRemove(false)
      @preventToolsDisplay()
      return true
    getSpacesMovedY: (e) =>
      Math.round((e.pageY - @offsetStartY) / (Math.cos(@model.get('rotation') * Math.PI/180)  * 20) )
    getSpacesMovedX: (e) =>
      Math.round((e.pageX - @offsetStartX) / (Math.cos(@model.get('rotation') * Math.PI/180)  * 20) )
    dragGrowY: (e, callback) =>
      spacesMoved = @getSpacesMovedY(e)
      callback.call(this, spacesMoved)
      @setHoverRemove(true)
      @removeTools()
    dragGrowX: (e, callback) =>
      spacesMoved = @getSpacesMovedX(e)
      callback.call(this, spacesMoved)
      @setHoverRemove(true)
      @removeTools()
    dragInnerGrowDown: (e) =>
      @dragGrowY e, (spacesMoved) -> @model.growInnerVertical(spacesMoved)
    dragInnerGrowUp: (e) =>
      @dragGrowY e, (spacesMoved) ->
        @model.growInnerVertical(-spacesMoved)
        @model.moveVertical(spacesMoved)
    dragInnerGrowLeft: (e) =>
      @dragGrowX e, (spacesMoved) ->
        @model.growInnerHoriz(-spacesMoved)
        @model.moveHoriz(spacesMoved)
    dragInnerGrowRight: (e) =>
      @dragGrowX e, (spacesMoved) -> @model.growInnerHoriz(spacesMoved)
    dragGrowDown: (e) =>
      @dragGrowY e, (spacesMoved) -> @model.growDown(spacesMoved)
    dragGrowUp: (e) =>
      @dragGrowY e, (spacesMoved) ->
        @model.growUp(-spacesMoved)
        @model.moveVertical(spacesMoved)
    dragGrowLeft: (e) =>
      @dragGrowX e, (spacesMoved) ->
        @model.growLeft(-spacesMoved)
        @model.moveHoriz(spacesMoved)
    dragGrowRight: (e) =>
      @dragGrowX e, (spacesMoved) -> @model.growRight(spacesMoved)
    rotate: =>
      @model.rotate()
      @removeTools()
    fineRotate: =>
      @model.fineRotate()
      @removeTools()
    removeShape: =>
      app.shapeChooserView.removeShapeWithCid(@model.cid)
    preventToolsDisplay: ->
      @removeTools()
      @.__proto__.preventToolsDisplayFlag = true
    allowToolsDisplay: ->
      @.__proto__.preventToolsDisplayFlag = false
