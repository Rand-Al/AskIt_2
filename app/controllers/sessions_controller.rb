# frozen_string_literal: true

class SessionsController < ApplicationController # rubocop:todo Style/Documentation
  before_action :require_no_authenticate,  only: %i[new create]
  before_action :require_authenticate, only: %i[destroy]

  def new; end

  def create # rubocop:todo Metrics/AbcSize
    user = User.find_by email: params[:email]
    if user&.authenticate(params[:password])
      sign_in(user)
      remeber(user) if params[:remember_me] == '1'
      flash[:succsess] = "Welcome back, #{current_user.name_or_email}"
      redirect_to root_path
    else
      flash.now[:error] = 'Incorect email/or password'
      render :new
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
