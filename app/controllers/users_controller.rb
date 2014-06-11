class UsersController < ApplicationController
  before_action :admin_user, only: [:index, :show]
  before_action :signed_in_user, only: [:profile, :activate]
  before_action :not_signed_in_user, only: [:new, :create]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def profile
    @user = current_user
    render 'show.html.erb'
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "회원가입이 정상적으로 처리되었습니다."
      redirect_to @user
      sign_in @user
      UserMailer.activation_email(@user).deliver
    else
      render 'new'
    end
  end

  def activate
    @user = User.find_by(activation_token: params[:activation_token])
    if @user && @user.update_attribute(:active, true)
      # Success
      flash[:success] = "이메일 인증이 성공적으로 되었습니다."
      redirect_to user_path(id: @user.id)
    else
      # Failed
      redirect_to root_path
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
