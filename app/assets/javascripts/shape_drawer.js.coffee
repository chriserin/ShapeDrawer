#setup all the events for the application

jQuery ->
  #INIT
  app.grid = new app.models.Grid()
  app.gridView = new app.views.GridView({model: app.grid})
  app.gridControlsView = new app.views.GridControlsView({model: app.grid})
  app.gridView.render()
  app.shapeManView = new app.views.ShapeManipulationView()
  #app.shapes = new app.models.ShapesList()
  app.letterCommandsView = new app.views.LetterCommandsView()
  app.shapeChooserView = new app.views.ShapesChooserView({model: app.shapes})
  app.colorsList = new app.models.ColorsList()
  app.colorsView = new app.views.ColorsView({model: app.colorsList})
  app.colorsView.render()
  app.word = new app.models.Word()
  app.wordView = new app.views.WordView({model: app.word})
  app.wordCommandsView = new app.views.WordControlsView()
  app.appView = new app.views.AppView()
  app.wordCommandsView.addLetter()
  #app.word.fetch({success: app.appView.renderPallette, silent: true})
  app.wordView.render()

  $('#paste_selected_shapes').click -> paste_selected_shapes() draw_letter()
  $('#clear_buffer').click -> clear_buffer()
	
  $('#switch_color_side').click ->
    color_side += 1
    color_side = color_side % 4
	
  $('#add_color').ColorPicker({
    color: '#0000ff',
    onShow: (colpkr) ->
      $(colpkr).fadeIn(500)
      false
    ,
    onHide: (colpkr) ->
      $(colpkr).fadeOut(500)
      false
    ,
    onChange: (hsb, hex, rgb) ->
    ,
    onSubmit: (hsb, hex, rgb) ->
      rgb.alpha = .8
      app.colorsList.add(rgb)
  })
  
  #load()

create_grid = ->
  for i in [0..399]
    $(".graph_paper").append("<div class='grid_square'/>")

add_letter = ->
  FB.currentWord.NewLetter()
  add_letter_to_display 6, FB.currentWord.currentLetter.id
  do clear_shape_chooser

create_color_chooser = ->
  $('.color_selector').remove()
  for i in [0..(FB.currentWord.colors.length - 1)]
    color = FB.currentWord.colors[i]
    color_string = make_color_string color
    $("#colors_chooser").append("<div class='color_selector' id='color_#{i}' style='background-color:#{color_string}'></div>")
    $("#color_#{i}").click -> change_color(@)
    $("#color_#{i}").click -> increment_alpha(@)
    $("#color_#{i}").click -> draw_shapes()
  $("#colors_chooser").append('<div class="color_selector" id="color_transparent" style="background-color: transparent"></div>')
  $('#color_transparent').click -> change_color(@)
  $('#color_transparent').click -> draw_shapes()


paste_selected_shapes = -> FB.currentWord.currentLetter.AddShapes(FB.buffer.GetCopies())

k=for x in [0...3] 
   {
   foo:
     bar:x
     baz:3
   qux:5
   }

clear_shape_chooser = ->
	$("#shapes_chooser .shape_selector").remove()
