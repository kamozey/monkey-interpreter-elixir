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

    defimpl String.Chars do
      def to_string(stmt = %LetStatement{}) do
        "%LetStatement{token: #{stmt.token}, name: #{stmt.name}, value: #{stmt.value}}"
      end
    end
  end

  defmodule ReturnStatement do
    defstruct [:token, :returnValue]

    @type t :: %__MODULE__{
            token: Token.t(),
            returnValue: Expression.t()
          }

    defimpl String.Chars do
      def to_string(stmt = %ReturnStatement{}) do
        "%ReturnStatement{token: #{stmt.token}, returnValue: #{stmt.returnValue}}"
      end
    end
  end

  defmodule Identifier do
    defstruct [:token, :value]

    @type t :: %__MODULE__{
            token: Token.t(),
            value: String.t()
          }

    defimpl String.Chars do
      def to_string(stmt = %Identifier{}) do
        "%Identifier{token: #{stmt.token}, value: #{stmt.value}}"
      end
    end
  end

  defmodule Expression do
    defstruct [:placeholder]

    @type t :: %__MODULE__{
            placeholder: String.t()
          }

    defimpl String.Chars do
      def to_string(expr = %Expression{}) do
        "%Expression{placeholder: #{expr.placeholder}"
      end
    end
  end

  defmodule ExpressionStatement do
    defstruct [:token, :expression]

    @type t :: %__MODULE__{
            token: Token.t(),
            expression: Expression.t()
          }

    defimpl String.Chars do
      def to_string(stmt = %ExpressionStatement{}) do
        "%ExpressionStatement{token: #{stmt.token}, expression: #{stmt.expression}}"
      end
    end
  end
end
