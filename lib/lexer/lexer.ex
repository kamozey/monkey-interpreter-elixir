defmodule Lexer do
  alias Token
  alias TokenType

  defstruct [:input, :input_length, :position]

  def new(code) do
    %Lexer{input: code, input_length: String.length(code)}
  end

  def parse_input(lexer = %Lexer{}) do
    parse_input(lexer, 0)
  end

  def parse_input(lexer = %Lexer{}, posn) do
    cond do
      posn > lexer.input_length ->
        []

      true ->
        {:ok, token, next} =
          tokenize(String.at(lexer.input, posn), %Lexer{lexer | position: posn})

        if token == nil, do: parse_input(lexer, next), else: [token] ++ parse_input(lexer, next)
    end
  end

  def tokenize(char, lexer = %Lexer{})
      when (char >= "a" and char <= "z") or (char >= "A" and char <= "Z") do
    [string_value, skip] =
      Enum.reduce_while(lexer.position..lexer.input_length, ["", 0], fn ch, [acc, skip] ->
        char = String.at(lexer.input, ch)

        cond do
          (char >= "a" && char <= "z") || (char >= "A" && char <= "Z") ->
            {:cont, [acc <> char, skip + 1]}

          true ->
            {:halt, [acc, skip]}
        end
      end)

    token =
      string_value
      |> TokenType.tokenize_letters()

    {:ok, token, lexer.position + skip + 1}
  end

  def tokenize(char, lexer = %Lexer{}) when char >= "0" and char <= "9" do
    [string_value, skip] =
      Enum.reduce_while(lexer.position..lexer.input_length, ["", 0], fn ch, [acc, skip] ->
        char = String.at(lexer.input, ch)

        cond do
          char >= "0" && char <= "9" -> {:cont, [acc <> char, skip+1]}
          true -> {:halt, [acc, skip]}
        end
      end)

    token =
      string_value
      |> TokenType.tokenize_digits()

    {:ok, token, lexer.position + skip + 1}
  end

  def tokenize(char, lexer = %Lexer{}) do
    token = TokenType.tokenize(char)

    case token do
      nil -> {:ok, nil, lexer.position + 1}
      _ -> {:ok, token, lexer.position + 1}
    end
  end
end
