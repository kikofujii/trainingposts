class ToppagesController < ApplicationController
  def index
    @trainingposts = Trainingpost.all.order(id: :desc).page(params[:page]).per(5)
  end
end
