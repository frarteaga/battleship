
defmodule Battleship.Player do
  @moduledoc """
  Structure that represents a player in the game.
  """
  defstruct [:id, :board, :ships, :hits, :misses]

  @type t :: %__MODULE__{
    id: String.t(),
    board: %{Battleship.BoardConfiguration.position() => Battleship.BoardConfiguration.cell_state()},
    ships: list(Battleship.Ship.t()),
    hits: list(Battleship.BoardConfiguration.position()),
    misses: list(Battleship.BoardConfiguration.position())
  }
end
