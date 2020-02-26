class UsersController < ApplicationController
  # ログインしているユーザーのみ・・・意図的に
  before_action :authenticate_user! 
  before_action :correct_user, only: [:edit, :update]
  # 予備：正しいユーザーのみが編集、アップデートできる


  def index
    @user = current_user
    # この考えめっちゃ大事
    @users = User.all
    @book = Book.new
    @books = Book.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    # urlをもとにユーザーをとってくる
    @book = Book.new
    @books = @user.books
    # 自分の投稿が羅列されるように(ユーザーに関連している本)
  end

  def update
    @user = User.find(params[:id])

  if @user.update(user_params)
    flash[:success] = "User was successfully updated."
    redirect_to user_path(@user.id)
  else
    render action: :edit
  end
  end
  # elseの下に入れると二重になる


  def create
  end

  private 
  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
    @user = User.find(params[:id])
    if current_user != @user
       redirect_to user_path(current_user.id)
       # 考える!!userのshow（自分）に行けない、一覧じゃない！
       #paramsだと結局前のやつを参照しちゃう
       #正しい人のIDだからこういう表現になるのだと思う、Railsのメソッド。
    end
  end
end
