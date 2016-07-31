defmodule Slackkit.Web.RTM.Start do

  use Slackkit.Web.Endpoint, "rtm.start"

  defresponse [
    :url,
    self: User.spec,
    team: Team.spec,
    bots: [Bot.spec],
    channels: [Channel.spec],
    groups: [Group.spec],
    ims: [IM.spec],
    mpims: [MPIM.spec],
    users: [User.spec],
  ]

end
