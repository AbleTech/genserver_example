defmodule SlackClient do
  use GenServer

  @default_channel "#rapid-projects-bots"
  @default_username "elixir"
  @default_emoji ":elixir:"

  ##############
  # Client API #
  ##############

  def start() do
    GenServer.start(__MODULE__, %{}, name: __MODULE__)
  end

  def message(message_text, options \\ []) do
    GenServer.cast(__MODULE__, {:message, message_text, options})
  end

  def ping() do
    GenServer.call(__MODULE__, {:ping})
  end

  def stop do
    GenServer.stop(__MODULE__)
  end

  ####################
  # Server Callbacks #
  ####################

  def init(state) do
    new_state = state
    |> Map.put(:token, System.get_env("SLACK_TOKEN"))
    |> Map.put(:subdomain, "abletech")

    {:ok, new_state}
  end

  def handle_cast({:message, message_text, options}, state) do
    json = %{
      channel: Keyword.get(options, :channel, @default_channel),
      icon_emoji: Keyword.get(options, :icon_emoji, @default_emoji),
      username: Keyword.get(options, :username, @default_username),
      text: message_text
    }
    |> Poison.encode!

    url = "https://#{state.subdomain}.slack.com/services/hooks/incoming-webhook?token=#{state.token}"

    {:ok, _} = HTTPoison.post(url, json)

    {:noreply, state}
  end

  def handle_call({:ping}, _from, state) do
    url = "https://#{state.subdomain}.slack.com/api/api.test"

    result = case HTTPoison.get(url) do
      {:ok, response} -> :ok
      _ -> :error
    end

    {:reply, result, state}
  end
end
