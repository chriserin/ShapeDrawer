class ImageController < ApplicationController

  def show
    send_data Base64.decode64(ImageCapture.new(id).capture(size(10))), type: 'image/png', disposition: 'inline'
  end

  def random
    word = RandomWord.create(params["text"])
    send_data Base64.decode64(ImageCapture.new(word.id).capture(size(20))), type: 'image/png', disposition: 'inline'
  end

  private
  def id
    params[:id]
  end

  def size(default)
    params[:size]
  end
end
