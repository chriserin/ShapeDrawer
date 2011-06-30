jQuery ->
  class app.views.ShapeToolsView extends app.views.ShapeManipulationView
    initialize: ->
      @model.toolsView = @
      $("#{@el} .#{@model.cid}").live('mouseover', @displayTools)
      $(".shape_tools_#{@model.cid}").live('mouseleave', @removeTools)
      $(".shape_tools_#{@model.cid} .rounder").live('click', @displayRoundTools)
      $(".shape_tools_#{@model.cid} #rotate").live('click', @rotate)
      $(".shape_tools_#{@model.cid} #removeShape").live('click', @removeShape)
    el: '.graph_paper'
    setHoverRemove: (flag) ->
      @hoverRemove = flag
    displayRoundTools: (e) =>
      if($(".rMenu").length is 0)
        app.roundTools = new app.views.RoundToolsView({model: @model, el: $(e.target)})
        app.roundTools.render(e.target)
        return false
    displayTools: =>
      if @.__proto__.preventToolsDisplayFlag is true or @hoverRemove is false then return false 
      ShapeToolsView::currentToolsModel = @model
      @.__proto__.preventToolsDisplayFlag = true
      @setHoverRemove(true)
      @shape = $("#{@el} .#{@model.cid}")
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
      tools = $(".shape_tools_#{@model.cid} ")
        .move_to((m_attr.position.left - 1) * 20, (m_attr.position.top - 1) * 20)
        .set_a_size_rectangle(0, (@model.generalWidth() + 2) * 20)
        .set_b_size_rectangle(0, (@model.generalHeight() + 2) * 20)
        .css("z-index", @operatingZIndex - 1)
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
        .append("<div class='topBar'><div class='growUp innergrower'></div><div class='rounder rTopLeft' id='r_0'></div></div>")
        .append("<div class='bottomBar'><div class='growDown innergrower'></div><div class='rounder rBottomRight' id='r_2'></div></div>")
        .append("<div class='leftBar'><div class='growLeft innergrower'></div><div class='rBottomLeft' id='removeShape'>X</div></div>")
        .append("<div class='rightBar'><div class='growRight innergrower'></div><div class='rTopRight' id='rotate'>&#8592;</div></div>")

      $(".growUp").draggable(
        grid: [20, 20]
        start: @dragStart
        stop: @dragInnerGrowUp
        axis: 'y'
      )
      $(".growLeft").draggable(
        grid: [20, 20]
        start: @dragStart
        stop: @dragInnerGrowLeft
        axis: 'x'
      )
      $(".growRight").draggable(
        grid: [20, 20]
        start: @dragStart
        stop: @dragInnerGrowRight
        axis: 'x'
      )
      $(".growDown").draggable(
        grid: [20, 20]
        start: @dragStart
        stop: @dragInnerGrowDown
        axis: 'y'
      )

    removeTools: =>
      if @hoverRemove
        $(".shape_tools").remove()
        model = ShapeToolsView::currentToolsModel
        shape = $("#{@el} .#{model.cid}")
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
      $(".growUp").draggable(
        grid: [20, 20]
        start: @dragStart
        stop: @dragGrowUp
        axis: 'y'
      )
      $(".growLeft").draggable(
        grid: [20, 20]
        start: @dragStart
        stop: @dragGrowLeft
        axis: 'x'
      )
      $(".growRight").draggable(
        grid: [20, 20]
        start: @dragStart
        stop: @dragGrowRight
        axis: 'x'
      )
      $(".growDown").draggable(
        grid: [20, 20]
        start: @dragStart
        stop: @dragGrowDown
        axis: 'y'
      )

    dragStart: (e) =>
      @offsetStartY = e.pageY
      @offsetStartX = e.pageX
      @setHoverRemove(false)
      @preventToolsDisplay()
      return true
    dragInnerGrowDown: (e) =>
      spacesMoved = Math.round((e.pageY - @offsetStartY) / 20 )
      @model.growInnerVertical(spacesMoved)
      @setHoverRemove(true)
      @removeTools()
    dragInnerGrowUp: (e) =>
      spacesMoved = - Math.round((e.pageY - @offsetStartY) / 20 )
      @model.growInnerVertical(spacesMoved)
      @setHoverRemove(true)
      @removeTools()
      @model.moveVertical( - spacesMoved)
    dragInnerGrowLeft: (e) =>
      spacesMoved = - Math.round((e.pageX - @offsetStartX) / 20 )
      @model.growInnerHoriz(spacesMoved)
      @setHoverRemove(true)
      @removeTools()
      @model.moveHoriz( - spacesMoved)
    dragInnerGrowRight: (e) =>
      spacesMoved = Math.round((e.pageX - @offsetStartX) / 20 )
      @model.growInnerHoriz(spacesMoved)
      @setHoverRemove(true)
      @removeTools()
    dragGrowDown: (e) =>
      spacesMoved = Math.round((e.pageY - @offsetStartY) / 20 )
      @model.growDown(spacesMoved)
      @setHoverRemove(true)
      @removeTools()
    dragGrowUp: (e) =>
      spacesMoved = - Math.round((e.pageY - @offsetStartY) / 20 )
      @model.growUp(spacesMoved)
      @setHoverRemove(true)
      @removeTools()
      @model.moveVertical( - spacesMoved)
    dragGrowLeft: (e) =>
      spacesMoved = - Math.round((e.pageX - @offsetStartX) / 20 )
      @model.growLeft(spacesMoved)
      @setHoverRemove(true)
      @removeTools()
      @model.moveHoriz( - spacesMoved)
    dragGrowRight: (e) =>
      spacesMoved = Math.round((e.pageX - @offsetStartX) / 20 )
      @model.growRight(spacesMoved)
      @setHoverRemove(true)
      @removeTools()
    rotate: =>
      @model.rotate()
      @removeTools()
    removeShape: =>
      app.shapeChooserView.removeShapeWithCid(@model.cid)
    preventToolsDisplay: ->
      @removeTools()
      @.__proto__.preventToolsDisplayFlag = true
    allowToolsDisplay: ->
      @.__proto__.preventToolsDisplayFlag = false
