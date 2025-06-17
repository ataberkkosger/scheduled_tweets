Rails.application.routes.draw do
  #Hakkımızda Syafasına yönlendirme
  get "/about-us", to: "about#index", as: :about 

  #Ana sayfa yönlendirme
  root to:"main#index"
end
