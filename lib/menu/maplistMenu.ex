defmodule UserInterface.Menu.Maplist do

  def show(state) do
    cc = state[:controlcenter]
    maplist = cc.call(cc, {:get_maplist})
    state = state ++ [maplist: maplist]

    {menulist, _nr} = Enum.reduce(
      maplist, 
      {"Select the map you want to play:\n", 1}, 
      fn(item, {items, nr}) -> {items <> to_string(nr) <> ". " <> item <> "\n", nr + 1} end
    )

    input = IO.gets menulist
    handle_input(Integer.parse(input), state)
  end

  defp handle_input(:error, state) do
    IO.puts "please select the map you want to play by number\n"
    show(state)
  end

  defp handle_input(map_index, state) do
    cc = state[:controlcenter]
    map = Enum.at(state[:maplist], map_index - 1)
    game_id = cc.call(cc, {:start_map, {map}}
    UserInterface.render_gamestate state, game_id
  end

end
