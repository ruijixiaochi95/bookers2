# frozen_string_literal: true

class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @book = Book.new
    @books = Book.all
    @user = @book.user
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:notice] = "You have updated book successfully"
      redirect_to book_path(book.id)
    else
      @book = Book.find(params[:id])
      @book.update(book_params)
      render :edit
    end
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "You have created book successfully"
      redirect_to book_path(@book.id)
    else
      @books = Book.all
      render :index
    end
    @book.user_id = current_user.id
  end

  def show
    @book = Book.find(params[:id])
    @books = Book.new
    @user = @book.user
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title, :body).merge(user_id: current_user.id)
    end

    def is_matching_login_user
      book = Book.find(params[:id])
      unless book.user == current_user
        redirect_to books_path
      end
    end
end
