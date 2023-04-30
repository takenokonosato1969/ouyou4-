class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update ,:edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @today_book = @books.created_today
    @yesterday_book = @books.created_yesterday
    @this_week_book = @books.created_this_week
    @last_week_book = @books.created_last_week
    @book = Book.new
    @this_week_book_counts = []
    # ここでは空の配列を定義しています。この配列には投稿された本の数を１日ずつ追加します。
    6.downto(0) do |n|
      @this_week_book_counts.push(@books.where(created_at: n.day.ago.all_day).count)
    end
    # downtoメソッドは初期値から１ずつ減らしながら引数の値になるまで処理
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user.id), notice: "You have updated user successfully."
    else
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end

end
