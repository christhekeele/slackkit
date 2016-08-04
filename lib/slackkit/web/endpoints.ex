defmodule Slackkit.Web.Endpoints do
  @moduledoc false

  defmacro __using__([]) do
    quote location: :keep do

      use Slackkit.Web.API.Test

      use Slackkit.Web.Auth.Test
      use Slackkit.Web.Auth.Revoke

      use Slackkit.Web.Bots.Info

      use Slackkit.Web.Channels.Archive
      use Slackkit.Web.Channels.Create
      use Slackkit.Web.Channels.History
      use Slackkit.Web.Channels.Info
      use Slackkit.Web.Channels.Invite
      use Slackkit.Web.Channels.Join
      use Slackkit.Web.Channels.Kick
      use Slackkit.Web.Channels.Leave
      use Slackkit.Web.Channels.List
      use Slackkit.Web.Channels.Mark
      use Slackkit.Web.Channels.Rename
      use Slackkit.Web.Channels.SetPurpose
      use Slackkit.Web.Channels.SetTopic
      use Slackkit.Web.Channels.Unarchive

      use Slackkit.Web.Chat.Delete
      use Slackkit.Web.Chat.MeMessage
      use Slackkit.Web.Chat.PostMessage
      use Slackkit.Web.Chat.Update

      use Slackkit.Web.DND.EndDND
      use Slackkit.Web.DND.EndSnooze
      use Slackkit.Web.DND.Info
      use Slackkit.Web.DND.SetSnooze
      use Slackkit.Web.DND.TeamInfo

      use Slackkit.Web.Emoji.List

      use Slackkit.Web.Files.Comments.Add
      use Slackkit.Web.Files.Comments.Delete
      use Slackkit.Web.Files.Comments.Edit

      use Slackkit.Web.Files.Delete
      use Slackkit.Web.Files.Info
      use Slackkit.Web.Files.List
      use Slackkit.Web.Files.RevokePublicURL
      use Slackkit.Web.Files.SharedPublicURL
      use Slackkit.Web.Files.Upload

      use Slackkit.Web.Groups.Archive
      use Slackkit.Web.Groups.Close
      use Slackkit.Web.Groups.Create
      use Slackkit.Web.Groups.CreateChild
      use Slackkit.Web.Groups.History
      use Slackkit.Web.Groups.Info
      use Slackkit.Web.Groups.Invite
      use Slackkit.Web.Groups.Kick
      use Slackkit.Web.Groups.Leave
      use Slackkit.Web.Groups.List
      use Slackkit.Web.Groups.Mark
      use Slackkit.Web.Groups.Open
      use Slackkit.Web.Groups.Rename
      use Slackkit.Web.Groups.SetPurpose
      use Slackkit.Web.Groups.SetTopic
      use Slackkit.Web.Groups.Unarchive

      use Slackkit.Web.IM.Close
      use Slackkit.Web.IM.History
      use Slackkit.Web.IM.List
      use Slackkit.Web.IM.Mark
      use Slackkit.Web.IM.Open

      use Slackkit.Web.MPIM.Close
      use Slackkit.Web.MPIM.History
      use Slackkit.Web.MPIM.List
      use Slackkit.Web.MPIM.Mark
      use Slackkit.Web.MPIM.Open

      use Slackkit.Web.OAuth.Access

      use Slackkit.Web.Pins.Add
      use Slackkit.Web.Pins.List
      use Slackkit.Web.Pins.Remove
      
      use Slackkit.Web.Reactions.Add
      use Slackkit.Web.Reactions.Get
      use Slackkit.Web.Reactions.List
      use Slackkit.Web.Reactions.Remove
      
      use Slackkit.Web.Reminders.Add
      use Slackkit.Web.Reminders.Complete
      use Slackkit.Web.Reminders.Delete
      use Slackkit.Web.Reminders.Info
      use Slackkit.Web.Reminders.List

      use Slackkit.Web.RTM.Start
      
      use Slackkit.Web.Search.All
      use Slackkit.Web.Search.Files
      use Slackkit.Web.Search.Messages

      use Slackkit.Web.Stars.Add
      use Slackkit.Web.Stars.List
      use Slackkit.Web.Stars.Remove
      
      use Slackkit.Web.Team.AccessLogs
      use Slackkit.Web.Team.BillableInfo
      use Slackkit.Web.Team.Info
      use Slackkit.Web.Team.IntegrationLogs
      
      use Slackkit.Web.Team.Profile.Get
      use Slackkit.Web.Team.Profile.Set
      
      use Slackkit.Web.UserGroups.Create
      use Slackkit.Web.UserGroups.Disable
      use Slackkit.Web.UserGroups.Enable
      use Slackkit.Web.UserGroups.List
      use Slackkit.Web.UserGroups.Update
      
      use Slackkit.Web.UserGroups.Users.List
      use Slackkit.Web.UserGroups.Users.Update
      
      use Slackkit.Web.Users.GetPresence
      use Slackkit.Web.Users.Identity
      use Slackkit.Web.Users.Info
      use Slackkit.Web.Users.List
      use Slackkit.Web.Users.SetActive
      use Slackkit.Web.Users.SetPresence
      
      use Slackkit.Web.Users.Profile.Get
      use Slackkit.Web.Users.Profile.Set
      
      

    end
  end

end
