# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]
  before_action :ensure_guest_user, only: [:edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books # .page(params[:page])
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully"
      redirect_to user_path
    else
      @user = User.find(params[:id])
      @user.update(user_params)
      render :edit
    end
  end

  def index
    @users = User.all
    @book = Book.new
  end

  private
    def user_params
      params.require(:user).permit(:name, :profile_image, :introduction)
    end

    def book_params
      params.require(:book).permit(:title, :body).merge(user_id: current_user.id)
    end

    def is_matching_login_user
      user = User.find(params[:id])
      unless user.id == current_user.id
        redirect_to user_path(current_user)
      end
    end

    def ensure_guest_user
      @user = User.find(params[:id])
      if @user.name == "guestuser"
        redirect_to user_path(current_user), notice: "ゲストユーザーはプロフィール編集画面へ遷移できません"
      end
    end
end
