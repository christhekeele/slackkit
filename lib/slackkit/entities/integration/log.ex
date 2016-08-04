defmodule Slackkit.Integration.Log do

  use Slackkit.Entity, [
    :service_id,
    :service_type,
    :app_id,
    :app_type,
    :rss_feed_change_type,
    :rss_feed_title,
    :rss_feed_url,
    :user_id,
    :user_name,
    :channel,
    :date,
    :change_type,
    :scope,
    rss_feed: false,
  ]

end
