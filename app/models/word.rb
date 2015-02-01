class Word < ActiveRecord::Base
  def word_json
    JSON.parse(word_definition)
  end

  def colors_json
    JSON.parse(colors)
  end
end
