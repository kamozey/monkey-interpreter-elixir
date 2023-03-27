defmodule ElixirCompilerTest do
  use ExUnit.Case
  doctest ElixirCompiler

  test "greets the world" do
    assert ElixirCompiler.hello() == :world
  end
end
