class BooksController < ApplicationController
  before_action :authenticate_user! 
  # ログインユーザーのみに許可という動作
  before_action :correct_user, only: [:edit, :update]
  # 正しいユーザーのみ、編集とupdateができるということ
  # correct_userは下に定義


  def new
  end
  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    # 意味：user_idがnilのままだと、子モデルのbookの方が保存できない
    if @book.save
     flash[:success] = "Book was successfully created."
     redirect_to book_path(@book.id)
   else
    @books = Book.all
    @user = current_user
    render action: :index
    # indexのアクションを無視してインデックスに行く（再定義した理由）／renderの上に書くこと/newもコピペするとミスデータが上書きされる
    end

  end

  def index
    @user = current_user
    # この考えめっちゃ大事(今ログインしているユーザー)
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id]) 
    # このままだと@bookに前のデータが入ってしまう
    @books = Book.all
    # Aさんの全部の本という記述にしたい。自分の投稿一覧の章を見直す

    @user = @book.user
    # 本の投稿者が誰か、本に関連して出す
    @booknew = Book.new
  end

  def edit
    @book = Book.find(params[:id]) 
    # 仮で入力
    render layout: false 
    #application.html.erbを適用したくないときにこの用に書く

    # @book = Book.find(params[:id])
    # データは入っているからいらない
  end

  def update
    @book = Book.find(params[:id])
    # @book.update(book_params)

  if @book.update(book_params)
    flash[:success] = "Book was successfully updated."
    # 成功したらこのメッセージを[:success]のところに出力する
    redirect_to book_path(@book.id)
  else
    render action: :edit
    # updateにはviewがなく,editに書かずここに書いて良い（そのままの画面位もどす）
  end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  # 一覧画面へリダイレクトしたい
  # 文字の表示をインデックスでリダイレクトした後に行いたい 
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
    #データベースからとってくる
  end

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end

  def correct_user
    @book = Book.find(params[:id])
    # まず本を取り出した 重要
    @user = @book.user
    # 本に結びついたユーザーを取り出す
    if current_user != @user
      redirect_to books_path
    # 正しいユーザーではない場合本一覧に戻す
    end
  end

end