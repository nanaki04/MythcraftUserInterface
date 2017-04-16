defmodule UserInterface do

  def start_link() do
    ui_id = generate_ui_id()
    {:ok, _pid} = UserInterface.Receiver.start_link ui_id
    {:ok, ui_id}
  end

  def render_gamestate(gamestate, gamestate_id, _ui_id) do
    IO.inspect(gamestate.export_gamestate(gamestate_id))
  end

  defp generate_ui_id() do
    {x, y, z} = :os.timestamp
    id = to_string(x) <> to_string(y) <> to_string(z) <> to_string(:rand.uniform)
    {:global, id}
  end

end
