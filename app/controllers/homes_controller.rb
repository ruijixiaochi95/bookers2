class HomesController < ApplicationController
  
  def top
    @book = Book.find(current_user.id)
    @books = Book.new
    @user = @book.user
  end
  
  
  
  def about
  end
  
  private
  
  def book_params
    params.require(:book).permit(:title, :body).merge(user_id:current_user.id)
  end
end
