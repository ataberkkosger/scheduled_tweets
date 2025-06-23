class TwitterAccount < ApplicationRecord
  has_many :tweets, dependent: :destroy
  belongs_to :user

  validates :username, uniqueness: true

  def oauth1_headers
    require 'simple_oauth'

    oauth = SimpleOAuth::Header.new(
      'POST',
      'https://api.twitter.com/2/tweets',
      {}, 
      {
        consumer_key: Rails.application.credentials.dig(:twitter, :api_key),
        consumer_secret: Rails.application.credentials.dig(:twitter, :api_secret),
        token: token,
        token_secret: secret
      }
    )

    {
      'Authorization' => oauth.to_s,
      'Content-Type' => 'application/json'
    }
  end
end
