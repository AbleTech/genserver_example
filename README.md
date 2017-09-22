# GenServer Example

Gives a very basic demonstration of using an Elixir GenServer process for sending messages to Slack.

## Usage

Send a message to Slack:

```
SLACK_TOKEN=xxxxxxxxxxxxxx mix gen_example.send Hello world
```

Ping Slack to check status:

```
mix gen_example.ping
```
