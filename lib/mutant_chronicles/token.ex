defmodule MutantChronicles.Token do
  use Joken.Config

  def create_token(user_id) do
    generate_and_sign(user_id)
  end
end
