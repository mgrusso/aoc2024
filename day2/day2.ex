defmodule Aoc2024.Day2 do
  def solve_a do
    reports =
      File.stream!("input")
      |> Enum.map(&String.trim(&1, "\n"))
      |> Enum.map(&String.split/1)

    check_a(reports, 0, 0)
  end

  @doc "Execute the checks recusively for each report"
  def check_a([h | t], s, u) do

    current_report =
      Enum.map(h, fn(x) -> String.to_integer(x) end)

    if safe?(current_report) do
      check_a(t, s+1, u)
    else
      check_a(t, s, u+1)
    end
  end
  def check_a([], safe, unsafe) do
    IO.puts "Safe: #{Integer.to_string(safe)} - Unsafe: #{Integer.to_string(unsafe)}"
  end

  def safe?([h1, h2 | t] = report) do
    if difference_safe?(h1, h2 , t) do
      if continuous?(report, :init) do
        true
      else
        false
      end
    else
      false
    end
  end

  def safe?([_ | []]) do
    true
  end

  def difference_safe?(a, b, [ h | t ]) do
    case abs(a - b) <= 3 do
      true -> difference_safe?(b, h, t)
      false -> false
    end
  end

  def difference_safe?(a, b, []) do
    case abs(a - b) <= 3 do
      true -> true
      false -> false
    end
  end

  def continuous?([a, b | t] = report, direction) do
    cond do
      a > b ->
        case direction do
          :asc ->  continuous?([b | t], :asc)
          :init ->  continuous?([b | t], :asc)
          _ ->  false
        end
      a < b ->
        case direction do
          :desc -> continuous?([b | t], :desc)
          :init -> continuous?([b | t], :desc)
          _ ->  false
        end
      a == b ->
        false
    end
  end

  def continuous?([ _ ], _) do
    true
  end
end
