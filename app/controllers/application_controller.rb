class ApplicationController < ActionController::Base
    include SessionsHelper
    
    #ログイン認証のためのコード
    private
    def require_user_logged_in
        unless logged_in?
            redirect_to root_url
        end
    end
end
