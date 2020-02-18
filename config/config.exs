# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :mutant_chronicles,
  ecto_repos: [MutantChronicles.Repo]

# Configures the endpoint
config :mutant_chronicles, MutantChroniclesWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "1gJO0xzM0UeXUG7cIWDldzFCYy02XsQJvUp4QMY7mVcqe3n6UDb0oIWmEAs8HyVM",
  render_errors: [view: MutantChroniclesWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MutantChronicles.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [signing_salt: "C2wM21qFkMHSqjA/vv7jysN6bUpHr+AI"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Application.get_env(:mutant_chronicles, :secret_key_base)
config :joken, default_signer: "secret"

config :phoenix,
  template_engines: [leex: Phoenix.LiveView.Engine]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
