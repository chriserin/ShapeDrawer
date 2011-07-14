class WordsController < ApplicationController

	def index
		@words = Word.all
                respond_to do |format|
                  format.json do
                    result = ""
                    @words.each {|x| result += getDefinitionWithAddedId(x) + "," }
                    result = result.slice(0, result.length - 1)
                    render :json => "[" + result  + "]" 
                  end
                end
	end
	
        def getDefinitionWithAddedId(word)
          result = word.word_definition
          result = result.insert(1, "\"id\": #{word.id},")
          return result 
        end
        
	def create
		@word = Word.create!(:word_definition => params['word'])
		render :layout => false
	end
		
	def update
		@word = Word.find(params[:id])
		@word[:word_definition] = params['word']
		@word.save
		respond_to do |format|
			format.json {render :json => @word.word_definition}
			format.html {render 'fonts/index'}
		end
	end
	
	def show
		respond_to do |format|
			@word = Word.find(params[:id])
			format.json {render :json => @word.word_definition}
			format.html {render 'fonts/index'}
		end
	end
end
