jQuery ->
  class app.models.ColorsList extends Backbone.Collection
    model: app.models.Color
    initialize: ->
      @bind('add', @addColId)
      @bind('remove', @removeColId)
      @bind('reset', @resetColId)
      @resetColId()
      if(@models.length > 0)
        @_byColid = {}
        @.each(@attachColId)
      else
        @add(new app.models.Color({r: 200, g: 0, b: 0, alpha: .8}))
        @add(new app.models.Color({r: 0, g: 200, b: 0, alpha: .8}))
        @add(new app.models.Color({r: 0, g: 0, b: 200, alpha: .8}))
        @add(new app.models.Color({r: 200, g: 200, b: 200, alpha: .8}))
        transparent = new app.models.Color({r: 0, g: 0, b: 0, alpha: .0})
        @transparentCid = transparent.cid
        @add(transparent)
    attachColId: (model) =>
      @_byColid[model.get('colid')] = model
    addColId: (model) ->
      @_byColid[model.get('colid')] = model
    removeColId: (model) ->
      delete @_byColid[model.get('colid')]
    resetColId: (model) ->
      @_byColid = {}
    getByColid: (colid) ->
      @_byColid[colid]
    getTransparent: ->
      @getByCid(@transparentCid)
    comparator: (color) ->
      color = color.attributes
      if color.r > color.g and color.r  > color.b
        color.r
      else if color.g > color.r and color.g > color.b
        color.g
      else if color.b > color.r and color.b > color.g
        color.b
      else
        color.r
