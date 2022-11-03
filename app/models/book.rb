class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  
  # favoriteで使用するメソッドの定義
  def favorited_by(user)
    # favoritesが存在するか .exists?(カラム名: '田中'のような条件)
    # つまりuser.id を参照してあればtrue
    favorites.exists?(user_id: user.id)
  end
  
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
end
