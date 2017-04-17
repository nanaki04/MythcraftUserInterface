defmodule UserInterface.Menu.Main do

  def show(state) do
    menu_items = [
      "Start Game"
    ]

    {menulist, _nr} = Enum.reduce(
      menu_items,
      {"", 1},
      fn(item, {items, nr}) -> {items <> to_string(nr) <> ". " <> item <> "\n", nr + 1} end
    )

    get_input = fn
      menulist, debug_mode when(debug_mode === true) -> 1
      menulist, debug_mode when(debug_mode === false) -> IO.gets(menulist)
    end

    input = get_input.(menulist, state[:debug])
    handle_input(Integer.parse(input), state)
  end

  defp handle_input(:error, state) do
    IO.puts "please select the menu item by typing its number\n"
    show(state)
  end

  defp handle_input({nr = 1, _}, state) do
    UserInterface.Menu.Maplist.show(state)
  end

end
