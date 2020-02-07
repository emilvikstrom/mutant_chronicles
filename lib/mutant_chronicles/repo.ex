defmodule MutantChronicles.Repo do
  use Ecto.Repo,
    otp_app: :mutant_chronicles,
    adapter: Ecto.Adapters.Postgres
end
