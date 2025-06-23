# email:string
# password_digets:string

# password:string virtual
# password_confirmation:string virtual

class User < ApplicationRecord
  has_many :twitter_accounts
  has_many :tweets

  has_secure_password

  validates :email, presence: true, format: { with: /\A[^@\s]+@[^@\s]+\z/, message: "hatalı lütfen geçerli bir eposta giriniz"}
end
