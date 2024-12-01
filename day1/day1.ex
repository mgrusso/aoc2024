defmodule Aoc2024.Day1 do
  def getresult do
    {:ok, contents} = File.read("input")

    # [ %{left: 40094, right: 37480}, %{left: 52117, right: 14510}, ... ]
    itemlist =
      contents
      |> String.split("\n")
      |> Enum.map(fn(line) -> splitlist(line) end)

    # Sorted list with only left values
    left_items =
      itemlist
      |> Enum.sort(fn(i1, i2) -> order_items(i1, i2, :left) end)
      |> Enum.map(fn(i) -> i.left end)

    # same for the right values
    right_items =
      itemlist
      |> Enum.sort(fn(i1, i2) -> order_items(i1, i2, :right) end)
      |> Enum.map(fn(i) -> i.right end)

    # List of diff of each left and right value at the same list position
    difflist =
      Enum.zip(left_items, right_items)
      |> Enum.map(fn{li, ri} -> abs(li - ri) end)

    # sum the values via recursive add
    add_values(difflist, 0)
  end

  defp splitlist(line) do
    [left , right] = line |> String.split(" ", trim: true)
    %{left: String.to_integer(left) , right: String.to_integer(right)}
  end

  defp order_items(i1, i2, side) do
    case side do
      :left ->  i1.left <= i2.left
      :right -> i1.right <= i2.right
    end
  end

  defp add_values([h | t], result) do
    h + add_values(t, result)
  end
  defp add_values([], result) do
    result
  end
end

IO.puts(Integer.to_string(Aoc2024.Day1.getresult))
