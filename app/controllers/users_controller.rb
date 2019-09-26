class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]
  def index
  end

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @trainingposts = @user.trainingposts.order(id: :desc).page(params[:page]).per(5)
    counts(@user)
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ユーザーの登録が完了しました！'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザーの登録が出来ていません！'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
    
  end

  def update
    @user = User.find(params[:id])
      if @user.update(user_params)
        flash[:success] = 'プロフィールを更新しました！'
        redirect_to @user
      else
        flash.now[:danger] = 'プロフィールを更新できていません！'
        render :edit
      end
      
  end
  
  def followings
    @user = User.find(params[:id])
    @followers = @user.followings.page(params[:page])
    counts(@user)
  end
  
  def likes
    @user = User.find(params[:id])
    @trainingposts = @user.favorite_trainingpost.order(id: :desc).page(params[:page]).per(5)
    counts(@user)
  end


  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :icon_img, :introduce)
  end
end
