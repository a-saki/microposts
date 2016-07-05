module SessionsHelper
    # current_userの返り値はuserモデルのインスタンス
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    # current_userに値が入っていればtrueを返す
    def logged_in?
       !!current_user
    end
    
    def store_location
        session[:forwarding_url] = request.url if request.get?
    end
end