class SlackController < ApplicationController
  def respond
    render json: {text: "http://198.74.55.253/image/random.png"}
  end
end
