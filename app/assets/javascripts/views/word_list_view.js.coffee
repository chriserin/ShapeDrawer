
jQuery ->
  class app.views.WordListView extends Backbone.View
    el: '#words_list'
    events:
      'click #add_word': 'addWord'
      'click .letter_glass_top': 'selectWord'
    addWord: =>
      app.appView.displayBlankWord()
    selectWord: (e) ->
      app.appView.selectWord(e.target.parentNode.parentNode.classList[1])
    render: =>
      $(@el).find('.word_choice').remove()
      $(@el).find('#add_word').remove()
      @renderAddWord() unless @el.id is "words_list"
      @model.each((word) =>
        setTimeout( (=> @renderWordChoice(word)), WordListView::timeoutAmount)
        WordListView::timeoutAmount = 50 +  WordListView::timeoutAmount
        )
    renderWordChoice: (word) =>
      app.word = word
      wordChoice = $("<div class='word_choice #{word.cid}'></div>")
      $(@el).append(wordChoice)
      if word.get('letters').length > 0
        firstLetterView = new app.views.LetterView({model: word.get('letters').first(), el: wordChoice})
        firstLetterView.render()
        wordChoice.append("<div class='and_more'>+#{word.get('letters').length - 1}</div>")
    renderAddWord: ->
      letterDisplay = $("<div class='letter_display size_6' id='add_word'></div>")
      letterDisplay.append("<div class='add_letter_sign_horiz'></div><div class='add_letter_sign'></div>")
      $(@el).append(letterDisplay)
