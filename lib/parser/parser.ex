defmodule Parser do
  defstruct [:lexer, :curToken, :remTokens]

  alias Lexer
  alias Token


  def new(lexerIn = %Lexer{}, [cur | rest] = tokens) when tokens != [] do
    %Parser{lexer: lexerIn, curToken: cur, remTokens: rest}
  end

  def new(lexerIn = %Lexer{}, tokens) when tokens == [] do
    raise "Empty Tokens array. Write code to be parsed"
  end

  def parse_program(parser = %Parser{}) do
    #TODO
  end

end
