class MainController < ApplicationController
  def index
    flash.now[:notice] = "Başarıyla Oturum Açıldı"
    flash.now[:alert] = "E-mail ya da Parola Yanlış"
  end
end