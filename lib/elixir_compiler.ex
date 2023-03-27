defmodule ElixirCompiler do
  alias Lexer

  def hello do
    :world
  end

  def parse do
    code = ~S"""
      let five = 5;
      let ten = 1012389;

      let add = fn(x,y) {
        x+y;
      };

      let result = add(five, ten);
    """

    lexer = Lexer.new(code)

    lexer
    |> Lexer.parse_input()
    |> IO.inspect()
  end
end
