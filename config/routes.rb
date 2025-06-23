Rails.application.routes.draw do
  # Ana sayfa yönlendirme
  root to: "main#index"

  # Hakkımızda Syafasına yönlendirme
  get "/about-us", to: "about#index", as: :about

  # kayıt sayfası yönlendirme
  get "/sign_up", to: "registrations#new"
  post "/sign_up", to: "registrations#create"

  # giriş sayfası yönlendirme
  get "/sign_in", to: "sessions#new"
  post "/sign_in", to: "sessions#create"

  # çıkış
  delete "/logout", to: "sessions#destroy"

  # şifre düzenleme
  get "/password", to: "passwords#edit", as: :edit_password
  patch "/password", to: "passwords#update"

  # şifre sıfırlama
  get "/password/reset", to: "password_resets#new"
  post "/password/reset", to: "password_resets#create"

  get "/password/reset/edit", to: "password_resets#edit"
  patch "/password/reset/edit", to: "password_resets#update"

  get "/auth/twitter/callback", to: "omniauth_callbacks#twitter"
  # get "/auth/:provider/callback", to: "omniauth_callbacks#twitter"

  resources :twitter_accounts
  resources :tweets
end
