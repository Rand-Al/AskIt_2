class SessionsController < ApplicationController
  before_action :require_no_authenticate,  only: %i[ new create ]
  before_action :require_authenticate,  only: %i[ destroy ]

  def new
    
  end
  
  def create
    user = User.find_by email: params[:email]
    if user&.authenticate(params[:password])
      sign_in(user)
      flash[:succsess] = "Welcome back, #{current_user.name_or_email}"
      redirect_to root_path
    else
      flash[:error] = 'Incorect email/or password'
      render :new
    end
  end

  def destroy
    sign_out 
    redirect_to root_path
  end
end