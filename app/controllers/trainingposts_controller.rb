class TrainingpostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :training_part_array, only: [:create]
  def index
    @trainingposts = Trainingpost.all
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
    @trainingpost = Trainingpost.find(params[:id])
    @trainingpost.destroy
    flash[:success] = "投稿を削除しました"
    redirect_to trainingposts_path
  end
  
  private
  def trainingpost_params
    params.require(:trainingpost).permit(:title, :content, :training_part, {post_img:[]})
  end
  def training_part_array
    params[:trainingpost][:training_part] = params[:trainingpost][:training_part].join("/")
  end
 
end
