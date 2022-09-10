module Authentication
  extend ActiveSupport::Concern

  included do

    def current_user
      @current_user ||= User.find(session[:user_id]).decorate if session[:user_id].present?
      
    end

    def user_signed_in?
      current_user.present?
    end

    def sign_in(user)
      session[:user_id] = user.id
    end

    def sign_out 
      session.delete(:user_id)
    end

    def require_no_authenticate
      return if !user_signed_in?
      flash[:error] = "You are already signed in!"
      redirect_to root_path
    end

    def require_authenticate
      return if user_signed_in?
      flash[:error] = 'You must to be signed in!'
      redirect_to root_path
    end
    
    helper_method :current_user, :user_signed_in?

  end
end