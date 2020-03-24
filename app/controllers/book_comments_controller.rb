class BookCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    @book_comment = BookComment.new(book_comment_params)
    @book_comment.user_id = current_user.id
    @book_comment.book_id = @book.id
    @book_comment.save
    if @book_comment.save
      flash[:notice] = "Comment was successfully created."
    end
  end

  def destroy
    @book_comment = BookComment.find(params[:book_id])
    @book = @book_comment.book
    if @book_comment.user != current_user
      redirect_to request.referer
    end
    @book_comment.destroy
    flash[:notice] = "Comment was successfully deleted."
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end
end
