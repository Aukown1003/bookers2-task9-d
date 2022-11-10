class SearchesController < ApplicationController
  before_action :authenticate_user!
  
  def search
    @model = params[:model]
    # pry-rails
    
    if @model == "User"
      @users = User.search_for(params[:search],params[:word])
    else
      @books = Book.search_for(params[:search],params[:word])
    end
  end
  
  def search
    @model = params[:model]
    @search = params[:search]
    @word = params[:word]
    if @model == "User"
      @users = User.search_for(@search,@word)
    else
      @books = Book.search_for(@search,@word)
    end
  end
  
end
