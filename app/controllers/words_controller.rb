class WordsController < ApplicationController

	def index
		@words = Word.all
	end	
	
	def create
		@word = Word.create!(:word_definition => params['xxx'])
		render :layout => false
	end
		
	def update
		@word = Word.find(params[:id])
		@word[:word_definition] = params['xxx']
		@word.save
		render :layout => false
	end
	
	def show
		respond_to do |format|
			@word = Word.find(params[:id])
			format.json {render :json => @word.word_definition}
			format.html {render 'fonts/index'}
		end
	end
end