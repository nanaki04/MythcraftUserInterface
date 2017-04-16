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

    input = IO.gets menulist
    handle_input(Integer.parse(input), state)
  end

  defp handle_input(:error, state) do
    IO.puts "please select the menu item by typing its number\n"
    show(state)
  end

  defp handle_input(1, state) do
    UserInterface.Menu.SelectMap.show(state)
  end

end
