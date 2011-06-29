jQuery ->
  class app.models.Color extends Backbone.Model
    defaults: {
      r: 200,
      g: 50,
      b: 50,
      alpha: .5
    }
    to_s: =>
      if(app.colorsList.getTransparent() is @)
        'transparent'
      else
        "rgba(#{@.get('r')}, #{@.get('g')}, #{@.get('b')}, #{@.get('alpha')})"
