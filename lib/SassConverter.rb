require 'sass/engine'

class SassConverter
  def self.convert_to_css()
    css = Sass::Engine.new(f.read).to_css
    return css
  end
end
