defmodule Util do
  def load_input(path) do
    {:ok, text} = File.read(path)
    String.split(text, ["\n", "\r", "\r\n"])
  end
end
