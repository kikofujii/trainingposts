class FavoritesController < ApplicationController
  before_action :require_user_logged_in
  def create
    trainingpost = Trainingpost.find(params[:trainingpost_id])
    current_user.like(trainingpost)
    flash[:success] = 'いいねしました！'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    trainingpost = Trainingpost.find(params[:trainingpost_id])
    current_user.unlike(trainingpost)
    flash[:success] = 'いいねを外しました'
    redirect_back(fallback_location: root_path)
  end
end
