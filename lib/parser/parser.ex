defmodule Parser do
  defstruct [:tokens, :curToken, :remTokens, :ast]

  alias Token
  alias AST.Program
  alias AST.LetStatement

  def new([cur | rest] = tokens) when tokens != [] do
    %Parser{tokens: tokens, curToken: cur, remTokens: rest, ast: %Program{statements: []}}
  end

  def new(tokens) when tokens == [] do
    raise "Empty Tokens array. Write code to be parsed"
  end

  def parse_program(parser = %Parser{}) do
    parse_program(parser, parser.tokens, [])
  end

  def parse_program(parser = %Parser{}, [cur | rest] = tokens, statements) do
    case cur.type do
      :let ->
        (fn ->
           {:ok, parsed_statements, rem_tokens} = parse_let_statement(parser, tokens)
           [statements | parsed_statements]
         end).()
    end
  end

  def parse_let_statement(parser, [cur | rest] = tokens) do
    {yes, next_atom} = check_valid_next?(cur.type, rest)

    if(!yes, do: raise("Invalid token after #{cur.type}, expected :ident, got #{next_atom}"))

    [ident, assign | rem_tokens] = rest

    if(!assign.type == :assign, do: raise("Expected :assign but got #{assign.type}"))

    expression = parse_expression(rem_tokens , 0)

    # implement "moving forward" after parsing
    # TODO return {:ok, stmts, rem_tokens}
    %LetStatement{token: cur, name: cur.value, value: expression}
  end

  defp parse_expression(tokens, precedence) do
    # TODO
  end

  defp check_valid_next?(atom, [next | rest]) do
    case atom do
      :let -> {next.type == :ident, next.type}
    end
  end
end
