module ApplicationHelper
  def getColorFromColorsJSON(colorsJSON, colorId)
    color = colorsJSON["colors"].find {|color| color["colid"] == colorId }
    if (color.nil?)
      return "transparent"
    else
      return get_color_string(color)
    end
  end

  def get_color_string(color)
      return "rgba(#{color['r']}, #{color['g']}, #{color['b']}, #{color['alpha']})"
  end

  def orient(index, shape)
    (index + shape['orientation']) % 4
  end
end

