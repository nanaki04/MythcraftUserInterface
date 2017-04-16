defmodule UserInterface.Receiver do
  use GenServer

  def start_link(ui_id) do
    GenServer.start_link(__MODULE__, [id: ui_id], name: ui_id)
  end

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:render_gamestate, {gamestate, gamestate_id}}, state) do
    # TODO implement task queue when performance issues arise
    UserInterface.render_gamestate gamestate, gamestate_id, state[:id]
    {:noreply, state}
  end

end
