defmodule Writer do
  def write_to_file(tokens, code_string, path) do
    {:ok, file} = File.open(Path.absname(path), [:write, :bianry])
    IO.puts(file, "--- Code Start:\n")
    IO.puts(file, code_string)
    IO.puts(file, "--- Code End\n")
    IO.puts(file, "--- Tokens Start: \n")
    token_print(tokens, file)
    File.close(file)

    # return tokens
    tokens
  end

  def token_print([token | rest], file) do
    IO.puts(file, token)
    token_print(rest, file)
  end

  def token_print([], file) do
    IO.puts(file, "\n--- Tokens End")
  end

end
