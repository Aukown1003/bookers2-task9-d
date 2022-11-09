class Relationship < ApplicationRecord
  # メソッドを作るメソッド
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  # 規約  ☓ モデル名_id   => Follower_id <-> Follower
  # 規約　○ follower => Follwer_id <-> User
  #         follower => Follwed_id <-> User
end
