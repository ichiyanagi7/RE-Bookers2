class BooksController < ApplicationController

  def index
    @user=current_user
    @books=Book.all
    @book_ranks=Book.find(Favorite.group(:book_id).order("count(book_id) desc").limit(10).pluck(:book_id))
        # Favorite.group(:book_id) :Bookの番号(book_id)が同じものにグループを分ける（1つの本にたくさんのfavoriteがある状態）
        # order("count(book_id) desc") ：それを番号の多い順に並び替える
        # limit(10) :表示する最大数を決める。ここでは10
        # pluck(:book_id) : :book_idカラムのみを数字で取り出すように指定
        # Book.find() :最終的にpluckで取り出す数字をBookのIDとすることでいいね順にBookを取り出す
    @book=Book.new
  end

  def create
    @book=Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book),notice:"You have created book successfully."
    else
      @user=current_user
      @books=Book.all
      render:index
    end
  end

  def show
    @books=Book.find(params[:id])
    @user=@books.user
    @book=Book.new
    @book_comments=@books.book_comments
    @book_comment=BookComment.new
  end

  def edit
    @book=Book.find(params[:id])
    if @book.user == current_user
      render:edit
    else
      redirect_to books_path
    end
  end

  def update
   @book=Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book),notice:"You have updated book successfully."
    else
      render:edit
    end
  end

  def destroy
    book=Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end


  private

  def book_params
    params.require(:book).permit(:title,:body)
  end

end
