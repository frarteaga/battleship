
defmodule Battleship.Ship do
  @moduledoc """
  Structure that represents a ship in the game.
  """
  defstruct [:positions, :hits]

  @type t :: %__MODULE__{
    positions: list(Battleship.BoardConfiguration.position()),
    hits: list(Battleship.BoardConfiguration.position())
  }

  def create_ship!(size, position, direction, board_size) do
    positions = case direction do
      :right -> Enum.map(0..(size - 1), fn i -> {position |> elem(0), (position |> elem(1)) + i} end)
      :down -> Enum.map(0..(size - 1), fn i -> {(position |> elem(0)) + i, position |> elem(1)} end)
    end
    %__MODULE__{positions: positions, hits: []}
  end

  def create_ship(size, position, direction, board_size) do
    if validate_ship_inside_the_board?(position, size, direction, board_size) do
      try do
        {:ok, create_ship!(size, position, direction, board_size)}
      rescue
        error -> {:error, error}
      end
    else
      {:error, "Invalid position"}
    end
  end

  def validate_ship_inside_the_board?(position, size, direction, board_size) do
    if position |> elem(0) < 1 || position |> elem(1) < 1 do
      false
    else
      final_position = case direction do
        :right -> {position |> elem(0), (position |> elem(1)) + size - 1}
        :down -> {(position |> elem(0)) + size - 1, position |> elem(1)}
      end
      final_position |> elem(0) <= board_size && final_position |> elem(1) <= board_size
    end
  end
end
