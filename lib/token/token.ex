defmodule Token do
  defstruct [:type, :value]

  defimpl String.Chars do
    def to_string(token = %Token{}) do
      "%Token{type: :#{token.type}, value: #{token.value}}"
    end
  end

  @type t :: %__MODULE__{
    type: String.t(),
    value: any()
  }
end
