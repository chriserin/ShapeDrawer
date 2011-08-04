class FontsController < ApplicationController

  def index
    puts "session value" + cookies[:_ShapeDrawer_session].to_s
    puts y cookies        
  end
end
