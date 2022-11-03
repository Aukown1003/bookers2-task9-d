class Favorite < ApplicationRecord
  # アソシエーションの設定
  # user bookに対して1対1
  belongs_to :user
  belongs_to :book
end
