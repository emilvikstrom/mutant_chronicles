defmodule MutantChroniclesWeb.SimpleLive do

  use Phoenix.LiveView

  def mount(_params, _session, socket) do
    if connected?(socket), do: :timer.send_interval(3000, self(), :update)
    temp = random_number()

    {:ok, assign(socket, temp: temp)}
  end

   def render(assigns) do
    ~L"""
    Current temperature: <%= @temp %>
    """
  end
  def handle_info(:update, socket) do

  end

  defp random_number do
    :rand.uniform(100)
  end

end
