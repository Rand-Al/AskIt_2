# frozen_string_literal: true

module Authentication # rubocop:todo Style/Documentation
  extend ActiveSupport::Concern

  included do # rubocop:todo Metrics/BlockLength
    def current_user # rubocop:todo Metrics/AbcSize
      if session[:user_id].present?
        @current_user ||= User.find(session[:user_id]).decorate
      elsif cookies.encrypted[:user_id].present?
        user = User.find_by(id: cookies.encrypted[:user_id])
        if user&.remember_token_authenticated?(cookies.encrypted[:remember_token])
          sign_in(user)
          @current_user ||= user.decorate
        end
      end
    end

    def remeber(user)
      user.remeber_me
      cookies.encrypted.permanent[:remember_token] = user.remember_token
      cookies.encrypted.permanent[:user_id] = user.id
    end

    def forget(user)
      user.forget_me
      cookies.delete :user_id
      cookies.delete :remember_token
    end

    def user_signed_in?
      current_user.present?
    end

    def sign_in(user)
      session[:user_id] = user.id
    end

    def sign_out
      forget current_user
      session.delete(:user_id)
      @current_user = nil
    end

    def require_no_authenticate
      return unless user_signed_in?

      flash[:error] = 'You are already signed in!' # rubocop:todo Rails/I18nLocaleTexts
      redirect_to root_path
    end

    def require_authenticate
      return if user_signed_in?

      flash[:error] = 'You must to be signed in!' # rubocop:todo Rails/I18nLocaleTexts
      redirect_to root_path
    end

    helper_method :current_user, :user_signed_in?
  end
end
