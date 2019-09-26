class TrainingpostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :training_part_array, only: [:create]
  def index
    @user = User.find(params[:id])
    @trainingposts = @user.trainingposts.order(id: :desc).page(params[:page]).per(5)
  end

  def show
    @trainingpost = Trainingpost.find(params[:id])
  end

  def new
    if logged_in?
      @trainingpost = current_user.trainingposts.build
    end
  end

  def create
    @trainingpost = current_user.trainingposts.build(trainingpost_params)
    if @trainingpost.save
      flash[:success] = '投稿できました！'
      redirect_to @trainingpost
    else
      flash.now[:danger] = '投稿できていません！'
      render :new
    end
  end

  def destroy
    @user = current_user
    @trainingpost = Trainingpost.find(params[:id])
    @trainingpost.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to @user
  end
  
  def search
    @trainingposts = Trainingpost.all.search(params[:search]).order(id: :desc).page(params[:page]).per(5)
  end
  
 
  
  private
  def trainingpost_params
    params.require(:trainingpost).permit(:title, :content, :training_part, :post_img)
  end
  
  def training_part_array
    if params[:trainingpost][:training_part]
      params[:trainingpost][:training_part] = params[:trainingpost][:training_part].join("/")
    end
  end
end
