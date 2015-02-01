class RandomWord
  attr_reader :id

  def self.create
    RandomWord.new
  end

  def initialize
    word_base = Word.find(2)
    new_word = word_base.dup
    new_word.word_json = randomize(new_word.word_json)
    #new_word.colors_json = randomize_colors(new_word.colors_json)
    new_word.save
    @id = new_word.id
  end

  private
  def randomize(json)
    letter = json["letters"][0]
    letter["shapes"].each do |shape|
      shape["height"] = 1
    end

    json
  end
end
