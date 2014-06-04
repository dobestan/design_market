class UserMailer < ActionMailer::Base
  default from: "no-reply@artinckle.com"

  def activation_email(user)
    @user = user
    @email = @user.email
    @activation_url = activate_url(activation_token: @user.activation_token, host: "http://artinkle.herokuapp.com")
    mail(to: @email, subject: "[Artinckle] Activate your Account!")
  end
end
