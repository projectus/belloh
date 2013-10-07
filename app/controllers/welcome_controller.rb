class WelcomeController < ApplicationController
  def index
	  @post = Post.new
	  
	  #respond_to do |format|
	  #  if session[:coords].nil?
	  #    format.js
	  #  else
		#    format.html
		#  end
  end
end
