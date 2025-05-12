
defmodule Battleship.Ship do
  @moduledoc """
  Structure that represents a ship in the game.
  """
  defstruct [:type, :positions, :hits]

  @type ship_type :: :carrier | :battleship | :cruiser | :submarine | :destroyer
  @type t :: %__MODULE__{
    type: ship_type(),
    positions: list(Battleship.BoardConfiguration.position()),
    hits: list(Battleship.BoardConfiguration.position())
  }

  def get_ship_size(ship) do
    get_size(ship.type)
  end

  defp get_size(ship_type) do
    case ship_type do
      :carrier -> 5
      :battleship -> 4
      :cruiser -> 3
      :submarine -> 3
      :destroyer -> 1
    end
  end
end
