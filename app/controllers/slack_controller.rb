class SlackController < ApplicationController
  def respond
    word = RandomWord.create(params[:text])
    render json: {text: "http://198.74.55.253/image/#{word.id}.png?size=10"}
  end
end
