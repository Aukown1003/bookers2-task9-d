class SearchesController < ApplicationController
  
  before_action :authenticate_user!
  
  def search
    @model = params[:model]
    @word = params[:word]
    # pry-rails
    
    if @model == "User"
      @users = User.search_for(params[:search],params[:word])
      # pry-rails
      render "/searches/result"
    else
      @books = Book.search_for(params[:search],params[:word])
      # pry-rails
      render "/searches/result"
    end
  end
  
  # def search
  #   @model = params[:model]
  #   @search = params[:search]
  #   @word = params[:word]
  #   if @model == "User"
  #     @users = User.search_for(@search,@word)
  #   else
  #     @books = Book.search_for(@search,@word)
  #   end
    # redirect_to search_result_path
  # end
  
end
