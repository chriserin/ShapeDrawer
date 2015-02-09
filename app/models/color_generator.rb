class ColorGenerator
  HTML_COLORS = {
    'alice blue' => 'F0F8FF',
    'antique white' => 'FAEBD7',
    'aqua' => '00FFFF',
    'aquamarine' => '7FFFD4',
    'azure' => 'F0FFFF',
    'beige' => 'F5F5DC',
    'bisque' => 'FFE4C4',
    'black' => '000000',
    'blanched almond' => 'FFEBCD',
    'blue' => '0000FF',
    'blue violet' => '8A2BE2',
    'brown' => 'A52A2A',
    'burlywood' => 'DEB887',
    'cadet blue' => '5F9EA0',
    'chartreuse' => '7FFF00',
    'chocolate' => 'D2691E',
    'coral' => 'FF7F50',
    'cornflower' => '6495ED',
    'cornsilk' => 'FFF8DC',
    'crimson' => 'DC143C',
    'cyan' => '00FFFF',
    'dark blue' => '00008B',
    'dark cyan' => '008B8B',
    'dark goldenrod' => 'B8860B',
    'dark gray' => 'A9A9A9',
    'dark green' => '006400',
    'dark khaki' => 'BDB76B',
    'dark magenta' => '8B008B',
    'dark olive green' => '556B2F',
    'dark orange' => 'FF8C00',
    'dark orchid' => '9932CC',
    'dark red' => '8B0000',
    'dark salmon' => 'E9967A',
    'dark sea green' => '8FBC8F',
    'dark slate blue' => '483D8B',
    'dark slate gray' => '2F4F4F',
    'dark turquoise' => '00CED1',
    'dark violet' => '9400D3',
    'deep pink' => 'FF1493',
    'deep sky blue' => '00BFFF',
    'dim gray' => '696969',
    'dodger blue' => '1E90FF',
    'firebrick' => 'B22222',
    'floral white' => 'FFFAF0',
    'forest green' => '228B22',
    'fuchsia' => 'FF00FF',
    'gainsboro' => 'DCDCDC',
    'ghost white' => 'F8F8FF',
    'gold' => 'FFD700',
    'goldenrod' => 'DAA520',
    'gray' => 'BEBEBE',
    'web gray' => '808080',
    'green' => '00FF00',
    'web green' => '008000',
    'green yellow' => 'ADFF2F',
    'honeydew' => 'F0FFF0',
    'hot pink' => 'FF69B4',
    'indian red' => 'CD5C5C',
    'indigo' => '4B0082',
    'ivory' => 'FFFFF0',
    'khaki' => 'F0E68C',
    'lavender' => 'E6E6FA',
    'lavender blush' => 'FFF0F5',
    'lawn green' => '7CFC00',
    'lemon chiffon' => 'FFFACD',
    'light blue' => 'ADD8E6',
    'light coral' => 'F08080',
    'light cyan' => 'E0FFFF',
    'light goldenrod' => 'FAFAD2',
    'light gray' => 'D3D3D3',
    'light green' => '90EE90',
    'light pink' => 'FFB6C1',
    'light salmon' => 'FFA07A',
    'light sea green' => '20B2AA',
    'light sky blue' => '87CEFA',
    'light slate gray' => '778899',
    'light steel blue' => 'B0C4DE',
    'light yellow' => 'FFFFE0',
    'lime' => '00FF00',
    'lime green' => '32CD32',
    'linen' => 'FAF0E6',
    'magenta' => 'FF00FF',
    'maroon' => 'B03060',
    'web maroon' => '7F0000',
    'medium aquamarine' => '66CDAA',
    'medium blue' => '0000CD',
    'medium orchid' => 'BA55D3',
    'medium purple' => '9370DB',
    'medium sea green' => '3CB371',
    'medium slate blue' => '7B68EE',
    'medium spring green' => '00FA9A',
    'medium turquoise' => '48D1CC',
    'medium violet red' => 'C71585',
    'midnight blue' => '191970',
    'mint cream' => 'F5FFFA',
    'misty rose' => 'FFE4E1',
    'moccasin' => 'FFE4B5',
    'navajo white' => 'FFDEAD',
    'navy blue' => '000080',
    'old lace' => 'FDF5E6',
    'olive' => '808000',
    'olive drab' => '6B8E23',
    'orange' => 'FFA500',
    'orange red' => 'FF4500',
    'orchid' => 'DA70D6',
    'pale goldenrod' => 'EEE8AA',
    'pale green' => '98FB98',
    'pale turquoise' => 'AFEEEE',
    'pale violet red' => 'DB7093',
    'papaya whip' => 'FFEFD5',
    'peach puff' => 'FFDAB9',
    'peru' => 'CD853F',
    'pink' => 'FFC0CB',
    'plum' => 'DDA0DD',
    'powder blue' => 'B0E0E6',
    'purple' => 'A020F0',
    'web purple' => '7F007F',
    'rebecca purple' => '663399',
    'red' => 'FF0000',
    'rosy brown' => 'BC8F8F',
    'royal blue' => '4169E1',
    'saddle brown' => '8B4513',
    'salmon' => 'FA8072',
    'sandy brown' => 'F4A460',
    'sea green' => '2E8B57',
    'seashell' => 'FFF5EE',
    'sienna' => 'A0522D',
    'silver' => 'C0C0C0',
    'sky blue' => '87CEEB',
    'slate blue' => '6A5ACD',
    'slate gray' => '708090',
    'snow' => 'FFFAFA',
    'spring green' => '00FF7F',
    'steel blue' => '4682B4',
    'tan' => 'D2B48C',
    'teal' => '008080',
    'thistle' => 'D8BFD8',
    'tomato' => 'FF6347',
    'turquoise' => '40E0D0',
    'violet' => 'EE82EE',
    'wheat' => 'F5DEB3',
    'white' => 'FFFFFF',
    'white smoke' => 'F5F5F5',
    'yellow' => 'FFFF00',
    'yellow green' => '9ACD32'
  }

  def initialize(num)
    @num = num
    @closeness = 256
  end

  def generate(phrase="Nothing in here")
    colors = determine_anchor_color(phrase || "Nothing in here")
    if colors.present?
      colors.each_with_index.map {|color, index| random_colors(*color, index) }.flatten
    else
      hexes = HTML_COLORS.values

      colors = hexes.map do |hex|
        puts hex
        hex2rgb(hex)
      end

      colors.each_with_index.map {|color, index| random_colors(*color, index) }.flatten
    end
  end

  private

  def determine_anchor_color(phrase)
    matches = phrase.scan(/#{HTML_COLORS.keys.join(?|)}/i)

    hexes = matches.map {|key| HTML_COLORS[key.downcase] }

    hexes.map do |hex|
      hex2rgb(hex)
    end
  end

  def hex2rgb(hex)
    r, g, b = hex.scan /[\w\d]{2}/
    return r.to_i(16), g.to_i(16), b.to_i(16)
  end

  def random_colors(r=128, g=128, b=128, set_num=0)
    puts r, g, b, set_num
    @num.times.map do |i|
      {
        "r" => create_component(r),
        "g" => create_component(g),
        "b" => create_component(b),
        "alpha" => 0.7,
        "colid" => "col#{i + (set_num * @num)}"
      }
    end
  end

  def create_component(anchor_component)
    [[random(@closeness) - @closeness / 2 + anchor_component, 0].max, 255].min
  end

  def random(max)
    (rand * max).to_i
  end
end
