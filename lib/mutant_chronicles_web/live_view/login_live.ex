defmodule MutantChroniclesWeb.LoginLive do
  use Phoenix.LiveView

    def render(assigns) do
    ~L"""
    Current temperature: <%= @temperature %>
    """
  end

  def mount(_params, %{}, socket) do
    IO.puts("MOUNT")
    if connected?(socket) do
      :timer.send_interval(1000, self(), :update)
    else
      IO.puts("Not connected")
    end

    case get_reading() do
      {:ok, temperature} ->
        {:ok, assign(socket, temperature: temperature)}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def handle_info(:update, socket) do
    IO.puts("UPDATE")
    {:ok, temperature} = get_reading()
    {:noreply, assign(socket, :temperature, temperature)}
  end

  defp get_reading() do
  {:ok, :rand.uniform(100)}
end

end
