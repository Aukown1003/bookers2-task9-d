class PostCommentsController < ApplicationController
  def create
    # params[:id]だとコメントのidを探してしまうので親のIDを探すためにbook_idとしている
    # book = Book.find(params[:book_id])
    # comment = current_user.post_comments.new(post_comment_params)
    # comment.book_id = book.id
    # comment.save
    # redirect_to books_path
    @book = Book.find(params[:book_id])
    @post_comment = current_user.post_comments.new(post_comment_params)
    @post_comment.book_id = @book.id
    @post_comment.save
    redirect_to book_path(@book)
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to book_path(params[:book_id])
  end

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
end
