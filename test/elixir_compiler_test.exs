defmodule ElixirCompilerTest do
  use ExUnit.Case
  doctest ElixirCompiler

  test "greets the world" do
    assert ElixirCompiler.hello() == :world
  end

  def initial_code_subset do
    ~S"""
      let five = 5;
      let ten = 1012389;

      let add = fn(x,y) {
        x+y;
      };

      let result = add(five, ten);
      """
  end

  def extended_code_subset do
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

end
