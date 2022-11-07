class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
  # 規約  ☓ モデル名_id   => Follower_id <-> Follower
  # 規約　○ Follwer_id <-> User
end
