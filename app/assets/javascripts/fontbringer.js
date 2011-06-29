var json_white_list = ['id', 'letters', 'shapes', 'shape_type', 'a_squares', 'b_squares', 'c_squares', 'd_squares', 'orientation', 'squaresPosition', 'top', 'left', 'rounded_corners_depths', 'colors', 'a_color', 'b_color', 'c_color', 'd_color', 'r', 'g', 'b', 'alpha', 'height', 'width', 'parentId', 'lastShapeId'];


function ShapeBuffer()
{
	this.shapes = new Array();	
}

ShapeBuffer.prototype.AddShape = function(shape)
{
	if(! this.ShapeExists(shape))
		this.shapes[this.shapes.length] = shape;
}

ShapeBuffer.prototype.ShapeExists = function(shape)
{
	for(var i = 0; i < this.shapes.length; i++)
	{
		if(this.shapes[i] == shape) return true;
	}
	
	return false;
}

ShapeBuffer.prototype.Clear = function()
{
	this.shapes = new Array();
}

ShapeBuffer.prototype.GetCopies = function()
{
	var return_array = new Array();
	for(var i = 0; i < this.shapes.length; i++)
	{
		return_array[i] = $.extend(true, {}, this.shapes[i]);
	}
	
	return return_array;
};
