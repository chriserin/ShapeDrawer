/// FIXME: Tell people that this is a manifest file, real code should go into discrete files
// FIXME: Tell people how Sprockets and CoffeeScript works
//
//= require jquery
//= require underscore
//= require backbone 
//= require colorpicker
//= require eye
//= require layout
//= require namespaces
//= require_tree ./models
//= require_tree ./views
//= require_tree .
//= require shape_drawer

function clear_buffer()
{
	FB.buffer.Clear();
}

/************************* OUTPUT FUNCTIONS ****************************/
function display_output_with_size(clicked_control)
{
	var id = $(clicked_control).attr('id');
	var removed_id = id.replace('output_displayer_', '');
	var square_size = parseInt(removed_id);
	display_output(square_size);
}

function display_output(square_size)
{
	display_letters(square_size);
	var shapes_html = output_shapes_html();
	var shapes_css = output_shapes_css(square_size);
	$('#output').text(shapes_css + '<div id="WordA">' + shapes_html + '</div>');
}

function output_shapes_css(square_size)
{
	var letter_size = square_size * GRID_SIZE;
	var return_string = '<style>.shape{border-style: solid;position: absolute; z-index: 10;}.Letter{height: ' + letter_size + 'px;width:' + letter_size + 'px;background-color: white;margin-left: auto;margin-right: auto;text-align: center;margin-top: 100px;float: none!important;display: block!important;border: 1px solid black;position:relative}';
	
	for(var j = 0; j < FB.currentWord.letters.length; j++)
	{
		switch_current_letter_by_index(j);
		var letter = FB.currentWord.currentLetter;
		for(var i = 0; i < letter.shapes.length; i++)
		{
			var shape_id = 'LETTER_' + letter.id + '_SHAPE_' + i;
			return_string += '#' + shape_id + '{';
			return_string += get_shape_style(shape_id, square_size);
			return_string += '}';
		}
	}
	
	return return_string + '</style>';
}

function get_shape_style(shape_id, square_size)
{
	return $('.' + shape_id + '_SIZE_' + square_size).attr('style');
}

function output_shapes_html()
{
	var return_string = '';
 
	for(var j = 0; j < FB.currentWord.letters.length; j++)
	{
		FB.currentWord.SwitchLetter(j);
		var letter = FB.currentWord.currentLetter;		
		return_string += '<div id="LETTER_' + letter.id + '" class="Letter">';
		for(var i = 0; i < letter.shapes.length; i++)
		{
			return_string += '<div id="LETTER_' + letter.id + '_SHAPE_' + i + '" class="shape"></div>';
		}
		return_string += '</div>';
	}
	
	return return_string;
}

function load()
{
	var loaded_word;
	var word_id = parseInt($('#word_id').text());
	$.get("/words/" + word_id, function(data){
		loaded_word = data;
		loaded_word.__proto__ = FB.currentWord.__proto__;
		loaded_word.id = word_id;
		
		FB.currentWord = loaded_word; 
		create_color_chooser();
		
		display_letters(6);
	});
}

function save()
{
	json_data = JSON.stringify(FB.currentWord, json_white_list);
	if(FB.currentWord.id)
	{
		$.ajax({
			type: "PUT",
			url: '/words/' + FB.currentWord.id,
			data: "xxx=" + json_data,
			success: function(data){ alert('update success ' + data);}
		});
	}
	else
	{
		$.post('/words', "xxx=" + json_data, function(data, textStatus, xhr){FB.currentWord.id = parseInt(data)});		
	}
}

function assign_prototype(shape_type)
{
	if(shape_type == 'triangle')
		return Triangle.prototype;
	else if(shape_type == 'rectangle')
		return Rectangle.prototype;
	else if(shape_type == 'trectangle')
		return Trectangle.prototype;		
}

function add_child_triangle()
{
	var shape_id = 'SHAPE_' + FB.currentWord.currentLetter.shapes.length;
	FB.AddTriangle(FB.GetCurrentShape().id);
	add_shape_to_shapes_chooser(shape_id);
}

function add_child_rectangle()
{
	var shape_id = 'SHAPE_' + FB.currentWord.currentLetter.shapes.length;
	FB.AddRectangle(FB.GetCurrentShape().id);
	add_shape_to_shapes_chooser(shape_id);
}

function add_child_trectangle()
{
	var shape_id = 'SHAPE_' + FB.currentWord.currentLetter.shapes.length;
	FB.AddTrectangle(FB.GetCurrentShape().id);
	add_shape_to_shapes_chooser(shape_id);
}
function delete_letter()
{
	$('#CHOOSE_LETTER_' + FB.currentWord.currentLetter.id).remove();
	FB.currentWord.DeleteLetter();
	switch_current_letter_by_index(0);
}

function draw_children()
{
	var children = FB.currentWord.currentLetter.get_all_children_of(FB.GetCurrentShape().id);
	for(var i = 0; i < children.length; i++)
	{
		FB.currentWord.currentLetter.SelectShape(children[i]);
		draw_shapes();
	}
}
