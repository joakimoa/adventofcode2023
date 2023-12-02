defmodule Adventofcode2023 do
  use Application

  def start(_type, _args) do
    Day2.part_one()
    Supervisor.start_link [], strategy: :one_for_one
  end
end
