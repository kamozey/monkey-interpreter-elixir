defmodule Lexer.LexerTest do
  use ExUnit.Case

  test "first subset test" do
    code = ~S"""
      let five = 5;
      let ten = 10;

      let add = fn(x,y) {
        x+y;
      };

      let result = add(five, ten);
    """
    
  end

end
