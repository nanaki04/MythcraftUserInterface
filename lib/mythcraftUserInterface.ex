defmodule UserInterface do

  def start_link(state) do
    state = state ++ [ui_id: generate_ui_id()]
    {:ok, _pid} = UserInterface.Receiver.start_link state
    UserInterface.Menu.Main.show state
    # Task.start_link(UserInterface.Menu.Main, :show, [state])
    {:ok, state[:ui_id]}
  end

  def render_gamestate(state, gamestate_id) do
    IO.inspect(state[:gamestate].export_gamestate(gamestate_id, state))
  end

  defp generate_ui_id() do
    {x, y, z} = :os.timestamp
    id = "ui_id: " <> to_string(x) <> to_string(y) <> to_string(z) <> to_string(:rand.uniform)
    {:global, id}
  end

end
