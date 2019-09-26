class ApplicationController < ActionController::Base
    include SessionsHelper
    
    #ログイン認証のためのコード
    private
    def require_user_logged_in
        unless logged_in?
            redirect_to root_url
        end
    end
    
    #各種数の表示
    def counts(user)
        @count_trainingposts = user.trainingposts.count
        @count_followings = user.followings.count
        @count_likes = user.favorites.count
    end
end
