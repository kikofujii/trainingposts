class SessionsController < ApplicationController
  def new
  end

  def create
    email = params[:session][:email].downcase
    password = params[:session][:password]
    if login(email, password)
      @post_ago = @user.trainingposts.where(created_at: 3.day.ago.all_day).last
      if @post_ago
        flash[:success] = ["ログインできました！\n", "#{@post_ago.training_part}をトレーニングしませんか？"]
      else
        flash[:success] = 'ログインしました！'
      end
      redirect_to @user
    else
      flash.now[:danger] = 'ログインできていません！'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました'
    redirect_to root_url
  end
  
  private
  def login(email, password)
    @user = User.find_by(email: email)
    if @user && @user.authenticate(password)
      session[:user_id] = @user.id
      return true
    else
      return false
    end
  end
end
