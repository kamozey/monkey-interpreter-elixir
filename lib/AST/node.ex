defmodule AST do
  alias Token

  defmodule Program do
    defstruct [:statements]
  end

  defmodule LetStatement do
    defstruct [:token, :name, :value]

    @type t :: %__MODULE__{
      token: Token.t(),
      name: Identifier.t(),
      value: Expression.t()
    }
  end


  defmodule Identifier do
    defstruct [:token, :value]

    @type t :: %__MODULE__{
      token: Token.t(),
      value: String.t()
    }
  end

  defmodule Expression do
    defstruct [:placeholder]

      @type t :: %__MODULE__{
        placeholder: String.t()
      }
  end
end
