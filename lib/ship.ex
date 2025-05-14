
defmodule Battleship.Ship do
  @moduledoc """
  Structure that represents a ship in the game.
  """
  defstruct [:positions, :hits]

  @type t :: %__MODULE__{
    positions: list(Battleship.BoardConfiguration.position()),
    hits: list(Battleship.BoardConfiguration.position())
  }

  def create_ship!(size, position, direction) do
    positions = case direction do
      :right -> Enum.map(0..(size - 1), fn i -> {position |> elem(0), (position |> elem(1)) + i} end)
      :down -> Enum.map(0..(size - 1), fn i -> {(position |> elem(0)) + i, position |> elem(1)} end)
    end
    %__MODULE__{positions: positions, hits: []}
  end

  def create_ship(size, position, direction) do
    if validate_position?(position) do
      try do
        {:ok, create_ship!(size, position, direction)}
      rescue
        error -> {:error, error}
      end
    else
      {:error, "Invalid position"}
    end
  end

  def validate_position?(position) do
    x = elem(position, 0)
    y = elem(position, 1)
    x >= 1 && y >= 1
  end
end
