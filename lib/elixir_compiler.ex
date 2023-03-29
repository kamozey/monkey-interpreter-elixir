defmodule ElixirCompiler do
  alias Lexer
  alias Writer

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
    """
  end

  def parse do
    lexer =
      code_string()
      |> Lexer.new()

    lexer
    |> Lexer.parse_input()
    |> Writer.write_to_file(code_string(), @output_tokens_path)
  end
end
