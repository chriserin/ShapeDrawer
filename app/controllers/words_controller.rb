require 'sass/util'
require 'sass/engine'
require 'uuid'


class WordsController < ApplicationController

  respond_to :html, :css, :scss

  def index
    if(params['group'] == 'session')
      @words = Word.where("session_id = ?", cookies[:user_id].to_s)
    else
      @words = Word.all
    end
    respond_to do |format|
      format.json do
        result = ""
        @words.each {|x| result += getDefinitionWithAddedId(constructWordJson(x), x.id) + "," }
        result = result.slice(0, result.length - 1)
        result = result || ""
        render :json => "[" + result  + "]" 
      end
    end
  end
  
  def getDefinitionWithAddedId(wordJSON, id)
    result = wordJSON.insert(1, "\"id\": #{id},")
    return result 
  end
  
  def create
    if(cookies[:user_id].nil?)
      uuid = UUID.new.generate
      cookies[:user_id] = uuid
    end
    puts "uuid: " + cookies[:user_id].to_s
    @word = Word.create!(:word_definition => params['word'], :colors => params['colors'], :session_id => cookies[:user_id])
    render :layout => false
  end
          
  def update
    @word = Word.find(params[:id])
    @word[:word_definition] = params['word']
    @word[:colors] = params['colors']
    @word.save
    render :layout => false
  end
  
  def show
    respond_to do |format|
            @word = Word.find(params[:id])
            format.json {render :json => constructWordJson(@word)}
            format.html {render 'fonts/index'}
    end
  end

  def output
    @size = params[:size] || 20
    puts @size
    @word = Word.find(params[:id])
    @wordDefinitionJSON = ActiveSupport::JSON.decode(@word.word_definition)
    @colorsJSON = ActiveSupport::JSON.decode(@word.colors)
    respond_to do |format|
      format.html {
        render 'output', :layout => false
      }
      format.css {
        scss = render_to_string(:file => "#{Rails.root}/app/views/words/output.scss", :format => :scss)
        css = Sass::Engine.new(scss, :syntax => :scss).to_css
        render :inline => css, :layout => false
      }
    end
  end

  def constructWordJson(word)
    if word.colors
      return word.word_definition.insert(word.word_definition.length - 1, ", \"colors\": #{word.colors}") 
    else
      return word.word_definition
    end
  end
end
