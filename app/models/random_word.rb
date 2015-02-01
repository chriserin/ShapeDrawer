class RandomWord
  attr_reader :id

  def self.create
    RandomWord.new
  end

  def initialize
    word_base = Word.find(2)
    new_word = word_base.dup
    colors = new_word.colors_json["colors"].map {|color| color["colid"]}
    new_word.word_definition = randomize(new_word.word_json, colors).to_json
    new_word.save
    @id = new_word.id
  end

  private
  def randomize(json, colors)
    letter = json["letters"][0]

    letter["shapes"].each do |shape|
      shape_type = shape["shape_type"] = (%w[triangle rectangle trectangle]).sample

      shape["squares"] = [random(10), random(10), random(10), random(10)]

      if shape_type == 'triangle'
        shape["height"] = random(20)
        shape["width"] = random(20)
      end

      shape["position"]["top"] = random(10) + 10 - (shape["height"] + shape["squares"].inject(&:+)) / 2
      shape["position"]["left"] = random(10) + 10 - (shape["width"] + shape["squares"].inject(&:+)) / 2

      shape["corner_depths"] = [random(10), random(10), random(10), random(10)]
      shape["corner_depths"] = [random(10), random(10), random(10), random(10)]

      shape["skew"]["x"] = random(40) - random(40)
      shape["skew"]["y"] = random(40) - random(40)

      shape["translate"]["x"] = random(10)
      shape["translate"]["y"] = random(10)

      shape["rotation"] = random(360)


      shape["colors"] = [colors.sample, colors.sample, colors.sample, colors.sample]
      without_transparent = shape["colors"] - ["transparent"]
      if shape_type == 'triangle'
        shape["colors"] = without_transparent[0...1].fill("transparent", 1, 3)
      else
        shape["colors"] = without_transparent.fill(without_transparent.first, without_transparent.length, 4 - without_transparent.length)
      end
    end

    json
  end

  def random(max)
    (rand * max).to_i
  end
end
