defmodule Day1 do
  def replace_text(str) do
    # Mega-hack due to realizing too late that "oneight" should
    # turn into "18", not "1ight" due to reusing the overlapping "e"
    replacements = [
      {"zero", "0ero"},
      {"one", "1ne"},
      {"two", "2wo"},
      {"three", "3hree"},
      {"four", "4our"},
      {"five", "5ive"},
      {"six", "6ix"},
      {"seven", "7even"},
      {"eight", "8ight"},
      {"nine", "9ine"}
    ]

    # Have an accumulator that we keep runnning all possible replacements on,
    # the accumulator starts like "", becomes "e", "ei", "eig"... "eight", "8", "8t"...
    ret = List.foldl(String.graphemes(str), "", fn x, acc ->
      buff = acc<>x
      Enum.reduce(replacements, buff, fn {t, n}, acc ->
        String.replace(acc, t, n)
      end)
    end)

    IO.inspect {str, ret}
    ret
  end

  def is_digit(a) do
    case Integer.parse(a) do
      {_, ""} -> true
      _ -> false
    end
  end

  def get_number(list) do
    case list do
      [a] -> String.to_integer(a <> a)
      l -> String.to_integer(List.first(l) <> List.last(l))
    end
  end

  def part_one() do
    input = Util.load_input("./input/day1.txt")

    num =
      input
      |> Enum.map(&String.graphemes/1)
      |> Enum.map(&Enum.filter(&1, fn x -> is_digit(x) end))
      |> Enum.map(&get_number/1)
      |> List.foldl(0, fn x, acc -> acc + x end)

    IO.inspect(num)
  end

  def part_two() do
    input = Util.load_input("./input/day1.txt")

    num =
      input
      |> Enum.map(&replace_text/1)
      |> Enum.map(&String.graphemes/1)
      |> Enum.map(&Enum.filter(&1, fn x -> is_digit(x) end))
      |> Enum.map(&get_number/1)
      |> List.foldl(0, fn x, acc -> acc + x end)

    IO.inspect(num)
  end
end
