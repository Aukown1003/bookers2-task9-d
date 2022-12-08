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
  # レビュー用バリデーション
   validates :rating, numericality: {
    less_than_or_equal_to: 5,
    greater_than_or_equal_to: 1
  }, presence: true
  
  scope :sort_rate, ->{order(rating: :desc)}
  scope :sort_new, ->{order(created_at: :desc)}
  scope :sort_old, ->{order(created_at: :asc)}
  
   # 検索メソッド作成
  def self.search_for(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end

end
