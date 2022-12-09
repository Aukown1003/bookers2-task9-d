class TagSearchesController < ApplicationController
  def search
    binding.pry
    @model = Book
    @word = params[:word]
    @books = Book.where("tag LIKE?","%#{@word}%")
    render "searches/result"
  end
end
