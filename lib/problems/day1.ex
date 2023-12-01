defmodule Day1 do
  def replace_text(str) do
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
    # IO.inspect str
    ret = List.foldl(String.graphemes(str), "", fn x, acc ->
      # IO.inspect x
      # buff = IO.inspect acc<>x
      buff = acc<>x
      # Enum.each(replacements, fn {t, n} ->
      #   ^buff = String.replace(buff, t, n)
      # end)
      buff = Enum.reduce(replacements, buff, fn {t, n}, acc ->
        # IO.inspect {t, n}
        # {t, n} = IO.inspect Enum.at(replacements, 2)
        acc = String.replace(acc, t, n)
        # IO.inspect acc
      end)
      # IO.inspect buff
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
