defmodule Mix.Tasks.GenExample.Send do
  @moduledoc """
    Sends a Slack message
  """

  @shortdoc "Runs example"
  def run(args) do
    Mix.Task.run "app.start"

    SlackClient.start()

    args
    |> Enum.join(" ")
    |> SlackClient.message(channel: "#rapid-projects-bots")

    # IO.puts "All done"

    SlackClient.stop()
  end
end
