class ImageController < ApplicationController

  def show
    send_data Base64.decode64(ImageCapture.new(id).capture), type: 'image/png', disposition: 'inline'
  end

  def random
    word = RandomWord.create
    send_data Base64.decode64(ImageCapture.new(word.id).capture), type: 'image/png', disposition: 'inline'
  end

  private
  def id
    params[:id]
  end
end
