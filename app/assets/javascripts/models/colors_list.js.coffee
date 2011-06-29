jQuery ->
  class app.models.ColorsList extends Backbone.Collection
    model: app.models.Color
    initialize: ->
      @add(new app.models.Color({r: 200, g: 0, b: 0, alpha: .8}))
      @add(new app.models.Color({r: 0, g: 200, b: 0, alpha: .8}))
      @add(new app.models.Color({r: 0, g: 0, b: 200, alpha: .8}))
      @add(new app.models.Color({r: 200, g: 200, b: 200, alpha: .8}))
      transparent = new app.models.Color({r: 0, g: 0, b: 0, alpha: .0})
      @transparentCid = transparent.cid
      @add(transparent)
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
