class UsersController < ApplicationController
  before_action :set_users, only: [:show, :edit, :update, :followings, :followers, :like]
  before_action :authenticate, only: [:edit, :update]

  def show
    #@users = User.page(params[:page])
    @microposts = @user.microposts.order(created_at: :desc).page(params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "登録が完了しました。"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      # 変更に成功した場合は、idページへリダイレクト
      redirect_to user_path, notice: "プロフィールを変更しました。"
    else
      # 変更に失敗した場合は編集画面へ戻す
      render 'edit'
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @users = @user.following_users.page(params[:page])
  end
  
  def followers
    @user = User.find(params[:id])
    @users = @user.follower_users.page(params[:page])
  end
  
  def like
    @title = 'いいね一覧'
    @micropost = current_user.microposts.build
    @feed_microposts = current_user.like_microposts
  end
  
  private
  
  def set_users
    @user = User.find(params[:id])
  end

  def authenticate
    redirect_to root_url unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction, :birthday)
  end
end
