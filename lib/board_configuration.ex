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

  def create_empty_board(size) do
    %__MODULE__{
      size: size,
      matrix: create_empty_matrix(size)
    }
  end

  def transparent_board_to_string(board) do

  end


  def get_pretty_printable_repr_header(size) do
    res = for i <- 1..size, into: "", do: "   #{<<?A + i - 1>>}"
    " #{res}"
  end

  defp create_empty_matrix(size) do
    for i <- 1..size, j <- 1..size, into: %{} do
      {{i, j}, :empty}
    end
  end
end
