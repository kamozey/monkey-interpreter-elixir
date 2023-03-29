defmodule TokenType do
  alias Token

  defp get_keywords_set do
    map_set = MapSet.new()

    map_set
    |> MapSet.put(:let)
    |> MapSet.put(:fn)
    |> MapSet.put(:true)
    |> MapSet.put(:false)
    |> MapSet.put(:return)
    |> MapSet.put(:if)
    |> MapSet.put(:else)
  end

  defp get_valid_2char_token_set do
    map_set = MapSet.new()

    map_set
    |> MapSet.put("!=")
    |> MapSet.put("==")
    |> MapSet.put(">=")
    |> MapSet.put("<=")
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

  def tokenize(char) when char == "-" do
    %Token{type: :minus, value: "-"}
  end

  def tokenize(char) when char == "*" do
    %Token{type: :asterisk, value: "*"}
  end

  def tokenize(char) when char == "/" do
    %Token{type: :slash, value: "/"}
  end

  def tokenize(char) when char == " " or char == "\n" or char == "\r" or char == "\t" do
  end

  def tokenize(char) when char == nil do
    %Token{type: :eof}
  end

  def tokenize(char) when char == "!=" do
    %Token{type: :neq, value: "!="}
  end

  def tokenize(char) when char == "==" do
    %Token{type: :eq, value: "=="}
  end

  def tokenize(char) when char == ">=" do
    %Token{type: :gte, value: ">="}
  end

  def tokenize(char) when char == "<=" do
    %Token{type: :lte, value: "<="}
  end

  def tokenize(char) when char == "=" or char == "<" or char == ">" or char == "!" do
    tokenize(char, :first)
  end

  def tokenize(char) do
    %Token{type: :illegal, value: char}
  end

  def tokenize(char, atom) when char == "=" do
    token = %Token{type: :assign, value: char}

    case atom do
      :peek -> token
      :first -> {:peekahead, token}
    end
  end

  def tokenize(char, atom) when char == "<" do
    token = %Token{type: :lt, value: "<"}

    case atom do
      :peek -> token
      :first -> {:peekahead, token}
    end
  end

  def tokenize(char, atom) when char == ">" do
    token = %Token{type: :gt, value: ">"}

    case atom do
      :peek -> token
      :first -> {:peekahead, token}
    end
  end

  def tokenize(char, atom) when char == "!" do
    token = %Token{type: :bang, value: "!"}

    case atom do
      :peek -> token
      :first -> {:peekahead, token}
    end
  end

  def tokenize(char, _), do: tokenize(char)

  def tokenize(char, token, :peekahead) do
    peek_token = tokenize(char, :peek)

    if peek_token != nil do
      new_value = to_string(token.value) <> to_string(peek_token.value)

      new_value
      |> valid_2char_token?()
      |> case do
        {:ok, new_token} -> {:peeked, new_token, 1}
        :error -> {:peeked, token, 0}
      end
    else
      {:peeked, token, 0}
    end
  end

  defp valid_2char_token?(value) do
    get_valid_2char_token_set()
    |> MapSet.member?(value)
    |> case do
      true -> {:ok, tokenize(value, :peek)}
      false -> :error
    end
  end
end
