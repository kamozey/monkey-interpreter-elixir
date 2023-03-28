defmodule TokenType do
  alias Token

  defp get_keywords_set do
    map_set = MapSet.new()

    map_set
    |> MapSet.put(:let)
    |> MapSet.put(:fn)
  end

  def tokenize_letters(string_value) do
    atom = String.to_atom(string_value)

    get_keywords_set()
    |> MapSet.member?(atom)
    |> case do
      true -> %Token{type: atom, value: string_value}
      false -> %Token{type: :ident, value: string_value}
    end
  end

  def tokenize_digits(string_value) do
    {int, _} = Integer.parse(string_value)
    %Token{type: :int, value: int}
  end

  def tokenize(char) when char == "=" do
    %Token{type: :assign, value: char}
  end

  def tokenize(char) when char == ";" do
    %Token{type: :semicolon, value: char}
  end

  def tokenize(char) when char == "(" do
    %Token{type: :lparen, value: char}
  end

  def tokenize(char) when char == ")" do
    %Token{type: :rparen, value: char}
  end

  def tokenize(char) when char == "{" do
    %Token{type: :lbrace, value: char}
  end

  def tokenize(char) when char == "}" do
    %Token{type: :rbrace, value: char}
  end

  def tokenize(char) when char == "," do
    %Token{type: :comma, value: char}
  end

  def tokenize(char) when char == "+" do
    %Token{type: :plus, value: char}
  end

  def tokenize(char) when char == " " or char == "\n" or char == "\r" or char == "\t" do
  end

  def tokenize(char) when char == nil do
    %Token{type: :eof}
  end

  def tokenize(char) do
    %Token{type: :illegal, value: char}
  end
end
