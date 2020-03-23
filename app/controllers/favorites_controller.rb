class FavoritesController < ApplicationController
  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.build(book_id: @book.id)
    # current_userのfavoriteテーブルの
    # 'book_id'というカラムに'@book.id'という値を入れて生成する。
    favorite.save
    redirect_to request.referer
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    # current_userのfavoriteテーブルから
    # 'book_id'というカラムの'@book.id'という値を探してくる。
    favorite.destroy
    redirect_to request.referer
  end
end
