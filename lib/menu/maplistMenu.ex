defmodule UserInterface.Menu.Maplist do

  def show(state) do
    cc = state[:controlcenter]
    maplist = GenServer.call(cc, {:get_maplist})
    state = state ++ [maplist: maplist]

    {menulist, _nr} = Enum.reduce(
      maplist, 
      {"Select the map you want to play:\n", 1}, 
      fn(item, {items, nr}) -> {items <> to_string(nr) <> ". " <> item <> "\n", nr + 1} end
    )

    get_input = fn
      menulist, is_debug where (is_debug === true) -> 1
      menulist, is_debug where (is_debug === false) -> IO.gets(menulist)
    end

    input = get_input menulist, state[:debug]

    handle_input(Integer.parse(input), state)
  end

  defp handle_input(:error, state) do
    IO.puts "please select the map you want to play by number\n"
    show(state)
  end

  defp handle_input({map_index, _}, state) do
    cc = state[:controlcenter]
    map = Enum.at(state[:maplist], map_index - 1)
    game_id = GenServer.call(cc, {:start_map, {map}})
    UserInterface.render_gamestate state, game_id
  end

end
