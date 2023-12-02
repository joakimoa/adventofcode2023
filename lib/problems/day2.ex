defmodule Day2 do

  def n_color([head | tail]) when [head | tail] == [head, "blue"], do: {String.to_integer(head), :blue}
  def n_color([head | tail]) when [head | tail] == [head, "red"], do: {String.to_integer(head), :red}
  def n_color([head | tail]) when [head | tail] == [head, "green"], do: {String.to_integer(head), :green}
  def n_color([head | tail]) when [head | tail] == [head | tail], do: String.to_integer(head)

  def is_all_within?(list) do
    List.foldl(list, true, fn x, acc ->
      acc and List.foldl(x, true, fn y, acc2 -> acc2 and is_within?(y) end)
    end)
  end

  def is_within?({n, color}) do
    {n, color}
    lim = %{:red => 12, :green => 13, :blue => 14}
    n <= lim[color]
  end

  def minimum_rgb(list) do
    List.foldl(list, {0,0,0}, fn x, {r,g,b} ->
      List.foldl(x, {r,g,b}, fn {num, color}, {ar,ag,ab} ->
        ar = if (color == :red) and (num > ar), do: num, else: ar
        ag = if (color == :green) and (num > ag), do: num, else: ag
        ab = if (color == :blue) and (num > ab), do: num, else: ab
        {ar, ag, ab}
      end)
    end)
  end

  def part_two() do
    input = Util.load_input("./input/day2.txt")

    score = input
    |> Enum.map(& String.replace(&1, "Game ", ""))
    |> Enum.map(& String.split(&1, [": ", "; "]))
    |> Enum.map(& Enum.map(&1, fn x ->
      y = String.split(x, ", ")
      Enum.map(y, fn z -> n_color String.split(z, " ") end)
    end))
    |> Enum.map(fn [[a]|tail] -> [a|tail] end)
    |> Enum.map(fn [_|grabs] -> minimum_rgb(grabs) end)
    |> Enum.map(fn x ->
      Enum.reduce(Tuple.to_list(x), fn y, acc -> y*acc end)
    end)
    |> Enum.sum()
    IO.inspect score
  end

  def part_one() do
    input = Util.load_input("./input/day2.txt")

    score = input
    |> Enum.map(& String.replace(&1, "Game ", ""))
    |> Enum.map(& String.split(&1, [": ", "; "]))
    |> Enum.map(& Enum.map(&1, fn x ->
      y = String.split(x, ", ")
      Enum.map(y, fn z -> n_color String.split(z, " ") end)
    end))
    |> Enum.map(fn [[a]|tail] -> [a|tail] end)
    |> Enum.filter(fn [_|grabs] -> is_all_within?(grabs) end)
    |> Enum.reduce(0, fn [id|_], acc -> acc + id end)
    IO.inspect score
  end
end
