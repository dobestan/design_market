class SessionsController < ApplicationController
  before_action :not_signed_in_user, only: [:new, :create]

  # Sign in = Login
  def new
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user && user.authenticate(session_params[:password])
      # Sign in Success
      sign_in user
      redirect_back_or profile_path
    else
      # Sign in Failed
      flash[:error] = "Invalid Email / Password Combination"
      render 'new'
    end
  end

  # Sign Out = Logout
  def destroy
    sign_out
    redirect_to root_path
  end

  private
    def session_params
      params.require(:session).permit(:email, :password)
    end
end
