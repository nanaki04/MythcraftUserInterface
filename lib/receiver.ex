defmodule UserInterface.Receiver do
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: state[:ui_id])
  end

  def init(state) do
    {:ok, state}
  end

  def handle_cast({:render_gamestate, {gamestate_id}}, state) do
    # TODO implement task queue when performance issues arise
    UserInterface.render_gamestate gamestate_id, state
    {:noreply, state}
  end

end
