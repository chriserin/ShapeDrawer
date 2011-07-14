jQuery ->
  class app.models.Word extends Backbone.Model
    initialize: (attributes) ->
      if !(attributes.letters)
        @set({'letters': new app.models.LettersList()})
      else
        @parse(attributes)
    toJSON: ->
      lettersArray = @get('letters').map((model) -> model.toJSON())
      json = {"word": JSON.stringify({"letters": lettersArray })}
    url: ->
      base = 'words'
      if @isNew()
        base
      else
        slash = if base.charAt(base.length - 1) is '/' then '' else '/'
        base + slash + @id
    parse: (resp, xhr) ->
      @set({'letters': new app.models.LettersList(resp.letters)}, {'silent': true})
      @id = resp.id
