class TweetJob < ApplicationJob
  queue_as :default

  def perform(tweet_id)
    tweet = Tweet.find(tweet_id)

    return if tweet.published?
    return if tweet.publish_at > Time.current

    tweet.publish_to_twitter!
  end
end
