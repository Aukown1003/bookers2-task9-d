class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 # belongs_toでなくhas many
 # hasumany時は複数形、注意！
  # default:class_name:"favorite" forein_key: "User.id"
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  has_many :books, dependent: :destroy
  # "#{Model names}s"を探しに行く。class_nameはRelationshipとする。規約から外れるから指定
  has_many :active_relationships,  class_name: "Relationship", foreign_key: "follwer_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id",dependent: :destroy
  # followingメソッドを生成する active_relationships userクラスのインスタンスにactive_relationshipsを実行し
  # followedメソッドを実行する。その結果をfollowingメソッドに入れる
  # 見たいのはuserのフォローしているuserの集合 ↓ 
  # active_relationships 自分のフォローしているuserのidを取得
  # followed idを参照してそれぞれのuserの情報を持ってくる
  # @user.active_relationships.map($:followed)である
  # フォロー一個ずつfollowedをかける
  has_many :following, through: :active_relationships,  source: :followed
  # フォロワー一個ずつfollowerをかける
  has_many :followers, through: :passive_relationships, source: :follower
  
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50 }
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  # ユーザーをフォローする
  def follow(other_user)
    following << other_user
  end

  # ユーザーをフォロー解除する
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 現在のユーザーがフォローしてたらtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
  
end