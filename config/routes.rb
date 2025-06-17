Rails.application.routes.draw do
  #Hakkımızda Syafasına yönlendirme
  get "/about", to: "about#index"
  
  #Ana sayfa yönlendirme
  root to:"main#index"
end
