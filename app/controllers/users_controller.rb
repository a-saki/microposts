class UsersController < ApplicationController
  before_action :check_login, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.order(created_at: :desc)
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "welcom to my app"
      redirect_to @user
    else
      render "new"
    end
  end
  
  
  def edit
    @user = User.find(params[:id])
    # ユーザーを比較するプライベートメソッドを作成し、befroe_actionでeditとupdateに適用させる。
    # @user = User.find(params[:id])
    # if current_user != @user
    # redirect_to root_url
    # end
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: '会員情報を更新しました。'
    else
      render 'edit'
    end
  end
  
  def followings
    @user = User.find(params[:id])
    @followings = @user.following_users
  end
  
  def followers
    @user = User.find(params[:id])
    @followings = @user.follower_users
  end
  
  private 
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :location, :introduce, :homepage, :birthday)
  end
  
  def check_login
    @user = User.find(params[:id])
    if current_user != @user
    redirect_to root_url
    end
  end

end
