class FavoritesController < ApplicationController
  def create
    # 選択した本を
    # paramsとはRailsで送られてきた値を受け取るためのメソッド、params[:カラム名]で受け取り
    # book = Book.find(params[:book_id])
    favorite = Postfavorite.new(book_favorite_params)
    favorite.user_id = current_user.id
    favorite.save
    redirect_to book_path
  end
  
  def destroy
    
  end
  
  private
  def book_favorite_params
    params.require(:favorite).permit(:favorite)
  end
end
