jQuery.fn.move_to = function(left, top) {
   var left = left || 0;
   var top = top || 0;
   
   $(this).css('left', left + 'px');
   $(this).css('top', top + 'px');
   return this;

};

jQuery.fn.move_down = function(number_of_squares){

	var current_pos = $(this).position();
	$(this).move_to(current_pos.left, current_pos.top + 20);
};

jQuery.fn.move_up = function(number_of_squares){

	var current_pos = $(this).position();
	$(this).move_to(current_pos.left, current_pos.top - 20);
};

jQuery.fn.move_left = function(number_of_squares){

	var current_pos = $(this).position();
	$(this).move_to(current_pos.left - 20, current_pos.top);
};

jQuery.fn.move_right = function(number_of_squares){

	var current_pos = $(this).position();
	$(this).move_to(current_pos.left + 20, current_pos.top);
};

jQuery.fn.set_trectangle_shape_color = function(orientation, a_color, b_color, c_color, d_color)
{
	var b_color = b_color || 'transparent';
	var c_color = c_color || 'transparent';

	if(orientation == 0)
	{
		$(this).css('border-left-color', a_color);	
		$(this).css('border-top-color', b_color);					
		$(this).css('border-right-color', c_color);
		$(this).css('border-bottom-color', d_color);	
	}
	else if(orientation == 1)
	{
		$(this).css('border-left-color', d_color);	
		$(this).css('border-top-color', a_color);		
		$(this).css('border-right-color', b_color);				
		$(this).css('border-bottom-color', c_color);
	}
	else if(orientation == 2)
	{
		$(this).css('border-left-color', c_color);
		$(this).css('border-top-color', d_color);
		$(this).css('border-right-color', a_color);
		$(this).css('border-bottom-color', b_color);
	}
	else if(orientation == 3)	
	{
		$(this).css('border-left-color', b_color);
		$(this).css('border-top-color', c_color);	
		$(this).css('border-right-color', d_color);
		$(this).css('border-bottom-color', a_color);	
	}		
}

jQuery.fn.set_triangle_shape_color = function(orientation, c_color, a_color, b_color)
{
        var borders = ['border-bottom-color', 'border-right-color', 'border-top-color', 'border-left-color']
        $(this).css('border-color', 'transparent').css(borders[orientation], c_color)
}

jQuery.fn.set_rectangle_shape_color = function(orientation, color)
{
	$(this).css('background-color', color);
}

jQuery.fn.clear_border_sizes = function(orientation, size)
{
	$(this).css('border-width', 0);	
}

jQuery.fn.set_a_size = function(orientation, size)
{
	if(orientation == 0)
		$(this).css('border-left-width', size);
	else if(orientation == 1)
		$(this).css('border-bottom-width', size);
	else if(orientation == 2)
		$(this).css('border-right-width', size);	
	else if(orientation == 3)	
		$(this).css('border-top-width', size);	
        return this;
}

jQuery.fn.set_b_size = function(orientation, size)
{
	if(orientation == 0)
		$(this).css('border-top-width', size);	
	else if(orientation == 1)
		$(this).css('border-left-width', size);		
	else if(orientation == 2)
		$(this).css('border-bottom-width', size);	
	else if(orientation == 3)
		$(this).css('border-right-width', size);	
}

jQuery.fn.set_c_size = function(orientation, size)
{
	if(orientation == 0)
		$(this).css('border-right-width', size);	
	else if(orientation == 1)
		$(this).css('border-top-width', size);		
	else if(orientation == 2)
		$(this).css('border-left-width', size);	
	else if(orientation == 3)	
		$(this).css('border-bottom-width', size);	
        return this;
}

jQuery.fn.set_d_size = function(orientation, size)
{
	if(orientation == 0)
		$(this).css('border-bottom-width', size);	
	else if(orientation == 1)
		$(this).css('border-right-width', size);		
	else if(orientation == 2)
		$(this).css('border-top-width', size);	
	else if(orientation == 3)
		$(this).css('border-left-width', size);	
}

jQuery.fn.set_a_size_rectangle = function(orientation, size)
{
	if(orientation == 0)
		$(this).css('width', size);
	else if(orientation == 1)
		$(this).css('height', size);
	else if(orientation == 2)
		$(this).css('width', size);
	else if(orientation == 3)
		$(this).css('height', size);	
        return this;
}

jQuery.fn.set_b_size_rectangle = function(orientation, size)
{
	if(orientation == 0)
		$(this).css('height', size);
	else if(orientation == 1)
		$(this).css('width', size);
	else if(orientation == 2)
		$(this).css('height', size);
	else if(orientation == 3)
		$(this).css('width', size);		
        return this;
}

jQuery.fn.grow_up = function(){ $(this).grow("UP")}
jQuery.fn.grow_down = function(){ $(this).grow("DOWN")}
jQuery.fn.grow_left = function(){ $(this).grow("LEFT")}
jQuery.fn.grow_right = function(){ $(this).grow("RIGHT")}

jQuery.fn.shrink_up = function(){ $(this).grow("UP", -20)}
jQuery.fn.shrink_down = function(){ $(this).grow("DOWN", -20)}
jQuery.fn.shrink_left = function(){ $(this).grow("LEFT", -20)}
jQuery.fn.shrink_right = function(){ $(this).grow("RIGHT", -20)}

jQuery.fn.grow = function(direction, square_size, number_of_squares){

	var square_size = square_size || 20;
	var number_of_squares = number_of_squares || 1;

	var left = $(this).css_no_px('border-left-width');
	var top = $(this).css_no_px('border-top-width');
	var right = $(this).css_no_px('border-right-width');
	var bottom = $(this).css_no_px('border-bottom-width');
	
	if(direction == "DOWN" && bottom == 0)
	{
		direction = "UP";
		$(this).move_down();
	}
	else if(direction == "LEFT" && left == 0)
	{
		direction = "RIGHT";
		$(this).move_left();
	}	
	else if(direction == "RIGHT" && right == 0)
	{
		direction = "LEFT";
		$(this).move_right();
	}	
	else if(direction == "UP" && top == 0)	
	{
		direction = "DOWN";
		$(this).move_up();
	}

	
	if(direction == "UP")
	{
		$(this).css('border-top-width', top + square_size);
		if(square_size < 0) ; else $(this).move_up();
	}
	else if(direction == "DOWN")
	{	
		$(this).css('border-bottom-width', bottom + square_size);
		if(square_size < 0) $(this).move_down();
	}
	else if(direction == "LEFT")
	{
		$(this).css('border-left-width', left + square_size);
		if(square_size < 0) ; else $(this).move_left();
	}
	else if(direction == "RIGHT")
	{
		$(this).css('border-right-width', right + square_size);
		
	}
};

jQuery.fn.css_no_px = function(css_attr)
{
	var pixel_value = $(this).css(css_attr);
	return parseInt(pixel_value.replace('px', ''));
}

jQuery.fn.rotate = function()
{
	var left = $(this).css_no_px('border-left-width');
	var top = $(this).css_no_px('border-top-width');
	var right = $(this).css_no_px('border-right-width');
	var bottom = $(this).css_no_px('border-bottom-width');

	$(this).css('border-left-width', bottom);
	$(this).css('border-top-width', left);
	$(this).css('border-right-width', top);
	$(this).css('border-bottom-width', right);	
	
	var left_color = $(this).css('border-left-color');
	var top_color = $(this).css('border-top-color');
	var right_color = $(this).css('border-right-color');
	var bottom_color = $(this).css('border-bottom-color');

	$(this).css('border-left-color', bottom_color);
	$(this).css('border-top-color', left_color);
	$(this).css('border-right-color', top_color);
	$(this).css('border-bottom-color', right_color);	
}

jQuery.fn.round_corners = function(depths, square_size, orientation)
{
	if($.isArray(depths))
	{
		$(this).css('border-top-left-radius', depths[(0 + orientation) % 4] * square_size);
		$(this).css('border-top-right-radius', depths[(1 + orientation) % 4] * square_size);
		$(this).css('border-bottom-right-radius', depths[(2 + orientation) % 4] * square_size);
		$(this).css('border-bottom-left-radius', depths[(3 + orientation) % 4] * square_size);		
	}
	else
	{
		$(this).css('border-radius', depths * square_size);	
	}
};
