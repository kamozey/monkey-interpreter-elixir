defmodule ElixirCompiler do
  alias Lexer
  alias Writer
  alias Parser

  @output_tokens_path "out/tokens.txt"

  def hello do
    :world
  end

  def code_string do
    ~S"""
      let five = 5;
      let ten = 1012389;

      let add = fn(x,y) {
        x+y;
      };

      let result = add(five, ten);

      !-/*5;
      5 < 10 > 5;
      if (5 < 10) {
      return true;
      } else {
      return false;
      }
      10 == 10;
      10 != 9;
      102 >= 1;
      1 <= 21;
    """
  end

  def let_statements do
    ~S"""
    let x = 5;
    let y = 10;
    let foobar = 838383;
    """
  end

  def parse do
    lexer =
      let_statements()
      |> Lexer.new()

    lexer
    |> Lexer.parse_input()
    |> Writer.write_to_file(let_statements(), @output_tokens_path)
    |> Parser.new()
    |> Parser.parse_program()
  end
end
