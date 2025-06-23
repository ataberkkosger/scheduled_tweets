class Tweet < ApplicationRecord
  belongs_to :user
  belongs_to :twitter_account

  validates :body, length: { minimum: 1, maximum: 280 }
  validates :publish_at, presence: true

  after_initialize do
    self.publish_at ||= 24.hours.from_now
  end

  after_create_commit do
    TweetJob.set(wait_until: publish_at).perform_later(id)
  end

  after_update_commit do
    if saved_change_to_publish_at?
      TweetJob.set(wait_until: publish_at).perform_later(id)
    end
  end

  def published?
    tweet_id.present?
  end

  def publish_to_twitter!
    conn = Faraday.new(url: "https://api.twitter.com")

    response = conn.post("/2/tweets") do |req|
      req.headers = twitter_account.oauth1_headers
      req.body = { text: body }.to_json
    end

    if response.status == 201
      json = JSON.parse(response.body)
      update(tweet_id: json["data"]["id"])
    else
      Rails.logger.error("Tweet gönderilemedi: #{response.status} - #{response.body}")
      false
    end
  end
end
