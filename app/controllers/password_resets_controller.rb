class PasswordResetsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user.present?
      # mail yolla
      PasswordMailer.with(user: @user).reset.deliver_later
    end
    redirect_to root_path, notice: "sıfırlama maili gönderildi"
  end
  def edit
    @user = User.find_signed!(params[:token], purpose: "password_reset")
  rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to sign_in_path, alert: "bu bağlantının kullanım süresi dolmuş. lütfen tekrar deneyin"
  end
  def update
    @user = User.find_signed!(params[:token], purpose: "password_reset")
    if @user.update(password_params)
      redirect_to sign_in_path, notice: "parola başarı ile değiştirildi. lütfen giriş yapın"
    else
      render :edit
    end
  end
  private

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
