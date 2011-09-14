jQuery.fn.move_to = (left = 0, top = 0) ->
  $(this).css('left', left + 'px')
  $(this).css('top', top + 'px')
  return this
jQuery.fn.set_trectangle_shape_color = (orientation, colors...) ->
  $(this).css('border-left-color', colors[(orientation + 0) % 4])
  $(this).css('border-top-color', colors[(orientation + 1) % 4])
  $(this).css('border-right-color', colors[(orientation + 2) % 4])
  $(this).css('border-bottom-color', colors[(orientation + 3) % 4])
jQuery.fn.set_triangle_shape_color = (orientation, color) ->
  borders = ['border-bottom-color', 'border-right-color', 'border-top-color', 'border-left-color']
  $(this).css('border-color', 'transparent').css(borders[orientation], color)
jQuery.fn.set_rectangle_shape_color = (orientation, color) ->
  $(this).css('background-color', color)
jQuery.fn.clear_border_sizes = (orientation, size) ->
  $(this).css('border-width', 0)
border_widths = ['border-right-width', 'border-top-width', 'border-left-width', 'border-bottom-width']
jQuery.fn.set_a_size = (orientation, size) ->
  $(this).css(border_widths[(0 + orientation) % 4], size)
jQuery.fn.set_b_size = (orientation, size) ->
  $(this).css(border_widths[(1 + orientation) % 4], size)
jQuery.fn.set_c_size = (orientation, size) ->
  $(this).css(border_widths[(2 + orientation) % 4], size)
jQuery.fn.set_d_size = (orientation, size) ->
  $(this).css(border_widths[(3 + orientation) % 4], size)
jQuery.fn.set_a_size_rectangle = (orientation, size) ->
  if(orientation in [0, 2])
    $(this).css('width', size)
  else
    $(this).css('height', size)
jQuery.fn.set_b_size_rectangle = (orientation, size) ->
  if(orientation in [0, 2])
    $(this).css('height', size)
  else
    $(this).css('width', size)
jQuery.fn.round_corners = (depths, square_size, orientation) ->
  if($.isArray(depths))
    $(this).css('border-top-left-radius', depths[(0 + orientation) % 4] * square_size)
    $(this).css('border-top-right-radius', depths[(1 + orientation) % 4] * square_size)
    $(this).css('border-bottom-right-radius', depths[(2 + orientation) % 4] * square_size)
    $(this).css('border-bottom-left-radius', depths[(3 + orientation) % 4] * square_size)
  else
    $(this).css('border-radius', depths * square_size)
jQuery.fn.skew = (x=0, y=0) ->
  $(this).css('skewX', "#{x}deg")
  $(this).css('skewY', "#{y}deg")
jQuery.fn.translate = (x=0, y=0) ->
  $(this).css('translateX', "#{x}px")
  $(this).css('translateY', "#{y}px")
jQuery.fn.scale = (num=1) ->
  num = 1 if num is 0
  $(this).css('scale', num)
jQuery.fn.rotate = (num=0) ->
  $(this).css('rotate', "#{num}deg")
