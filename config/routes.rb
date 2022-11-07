Rails.application.routes.draw do
  get 'relationships/followings'
  get 'relationships/followers'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "homes#top"
  get "home/about"=>"homes#about"

  devise_for :users
  # booksにいいねをつける。つまりbooksの下にfavoriteがつく do,end追加
  # 作成、削除のみなのでonly:[:create,:destroy]作成
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update]do
    # ネストする
    resources :book_comments, only: [:create,:destroy]
    # resourceはそれ自身のidがわからなくても、関連する他のモデルのidから特定できる場合に使用
    # 今回は一人一回であるためuser_idとbook_idから指定できる
    resource :favorites, only: [:create, :destroy]
  end
  resources :users, only: [:index,:show,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
# endなし！
end

# name test1
# pass 111111
# test2
# 222222