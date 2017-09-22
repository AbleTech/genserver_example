defmodule Mix.Tasks.GenExample.Ping do
  @moduledoc """
    Checks that Slack is going
  """

  @shortdoc "Runs example"
  def run(_args) do
    Mix.Task.run "app.start"

    SlackClient.start()

    case SlackClient.ping() do
      :ok -> IO.puts("Slack is up")
      :error -> IO.puts("Slack is down")
    end

    SlackClient.stop()
  end
end
