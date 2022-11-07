class BookCommentsController < ApplicationController
    # ここで止めたいときは下を使う
    #   # binding.pry
  def create
    book = Book.find(params[:book_id])
    
    # @bookにはコメントがない（当たり前）なのでネストしてコメントをつけなければならない
    # 変数@book_commentにカレントユーザーのbook_commentsを新たに作成。ユーザーIDとコメントをゲット
    book_comment = current_user.book_comments.new(book_comment_params)
    # 変数@book_commentのbook.idは@book(探してきたbook=投稿されている本)のIDとする。book.idゲット
    book_comment.book_id = book.id
    book_comment.save
    redirect_to request.referer
    # # こっちだとエラー→どうしてか？
    # １、保存しているものは　id: nil,comment: "test1", user_id: 3, book_id: 2でどちらも同じ
    # ２、idはsaveが実行されたときに初めて保存される。
    # ３、rederで飛ばされたときは作成されたここのデータは残っている
    # ４、showで@book.book_commentsを呼び出していて、かつIDがないのでエラーが起きる
    
    # 変数@book_commentに@book(探してきたbook=投稿されている本)のbook_commntsを新たに作成
    # book_idとコメントをゲット
    # @book_comment2 = @book.book_comments.new(book_comment_params)
    # 変数@book_commentのユーザーIDとしてカレントユーザのIDとする。ユーザーIDゲット
    # @book_comment2.user_id = current_user.id
    # 作成 = createに成功したらIDが振られる。という感じ
    # if @book_comment.save
    #   redirect_to book_path(@book)
    # else
   
    #   # redirect_to book_path(@book),notice: "You have created comment error."
    #   @user = @book.user
    #   render template: "books/show"
    # end
  end

  def destroy
    BookComment.find(params[:id]).destroy
    redirect_to request.referer
    # redirect_to book_path(params[:book_id])
  end

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
