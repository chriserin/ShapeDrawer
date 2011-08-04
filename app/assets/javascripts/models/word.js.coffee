jQuery ->
  class app.models.Word extends Backbone.Model
    initialize: (attributes) ->
      if !(attributes.letters)
        @set({'letters': new app.models.LettersList()})
        @set({'colors': new app.models.ColorsList()})
      else
        @parse(attributes)
    toJSON: ->
      lettersArray = @get('letters').map((model) -> model.toJSON())
      colorsArray = @get('colors').map((model) -> model.toJSON())
      json = {
        "word": JSON.stringify({"letters": lettersArray }),
        "colors": JSON.stringify({"colors": colorsArray })
        }
    url: ->
      base = 'words'
      if @isNew()
        base
      else
        slash = if base.charAt(base.length - 1) is '/' then '' else '/'
        base + slash + @id
    parse: (resp, xhr) ->
      @set({'colors': new app.models.ColorsList(resp.colors.colors)}) if resp.colors
      @set({'letters': new app.models.LettersList(resp.letters)}, {'silent': true}) if resp.letters
      if resp.id then @id = resp.id else @id = resp 
