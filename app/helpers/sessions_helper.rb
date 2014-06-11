module SessionsHelper
  # Sign In
  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
    self.current_user = user
  end

  # Sign Out
  def sign_out
    current_user.update_attribute(:remember_token, User.encrypt(User.new_remember_token))
    cookies.delete(:remember_token)
    self.current_user = nil
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user= (user)
    @current_user = user
  end

  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def current_user?(user)
    user == current_user
  end

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please Sign In"
    end
  end

  def not_signed_in_user
    if signed_in?
      redirect_to root_path
    end
  end

  def admin_user
    if current_user.nil? || !current_user.admin?
      redirect_to root_url
    end
  end

  def designer_user
    if current_user.nil? || !current_user.designer?
      flash[:error] = "디자이너로 등록된 사용자만 이용 가능합니다."
      redirect_to root_url
    end
  end

  def client_user
    if current_user.nil? || !current_user.client?
      flash[:error] = "클라이언트로 등록된 사용자만 이용 가능합니다."
      redirect_to root_url
    end
  end

  def active_user
    if current_user.nil? || !current_user.active?
      flash[:error] = "이메일 인증을 완료한 사용자만 이용 가능합니다."
      redirect_to root_url
    end
  end

  # Friendly Forwarding
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    session.delete(:return_to)
  end

  def store_location
    session[:return_to] = request.url if request.get?
  end
end
