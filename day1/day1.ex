defmodule Aoc2024.Day1 do
  def getresults do
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

    result_a = part_a(left_items, right_items)

    result_b = part_b(left_items, right_items)

    [result_a | result_b]
  end

  defp part_a(left_items, right_items) do
    # Build a list of differences and add the items to a sum
    Enum.zip(left_items, right_items)
    |> Enum.map(fn{li, ri} -> abs(li - ri) end)
    |> add_values(0)
  end

  defp part_b(left_items, right_items) do
    right_freq = Enum.frequencies(right_items)

    left_items
    |> Enum.map(fn(x) -> x * Map.get(right_freq, x, 0) end)
    |> add_values(0)
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

[ h | t ] = Aoc2024.Day1.getresults
IO.puts "Part a: #{Integer.to_string(h)} - Part b #{Integer.to_string(t)}"
