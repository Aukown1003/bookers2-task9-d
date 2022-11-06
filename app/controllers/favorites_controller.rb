class FavoritesController < ApplicationController
  def create
    # paramsとはRailsで送られてきた値を受け取るためのメソッド、params[:カラム名]で受け取り
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: book.id)
    favorite.save
    
    # request.refererで直前のページに戻る
    redirect_to request.referer
    # if request.referer&.include?("/books/#{book.id}")
    #   redirect_to book_path(book.id)
    # else
    #   redirect_to books_path
    # end
  end
  
  
  
  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    redirect_to request.referer
    # if request.referer&.include?("/books/#{book.id}")
    #   redirect_to book_path(book.id)
    # else
    #   redirect_to books_path
    # end
  end
  
#   private
#   def book_favorite_params
#     params.require(:favorite).permit(:favorite)
#   end
end
