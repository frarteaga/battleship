defmodule Battleship.BoardConfiguration do
  @moduledoc """
  Structure that holds the board configuration and state.
  """
  defstruct [:size, :matrix]

  @type position :: {integer(), integer()}
  @type cell_state :: :empty | :ship | :hit | :miss

  @type t :: %__MODULE__{
    size: integer(),
    matrix: %{position() => cell_state()}
  }
end
