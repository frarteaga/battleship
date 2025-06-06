defmodule Battleship.BoardConfiguration do
  @moduledoc """
  Structure that holds the board configuration and state.
  """
  alias Battleship.Ship

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

  def add_ship_obsolete(board, position, direction, size) do
    ship = Ship.create_ship!(size, position, direction, size)
    add_ship(board, ship)
  end

  def add_ship(board, ship) do
    updated_matrix = Enum.reduce(ship.positions, board.matrix, fn position, acc ->
      if acc[position] != :empty do
        raise "Ship already exists at position #{position}"
      end
      Map.put(acc, position, :ship)
    end)
    %__MODULE__{
      size: board.size,
      matrix: updated_matrix
    }
  end

  def add_ships(board, ships) do
    Enum.reduce(ships, board, fn(ship, acc) ->
      add_ship(acc, ship)
    end)
  end

  def get_ship_cells_count(board) do
    Enum.reduce(board.matrix, 0, fn({_key, value}, acc) ->
      if value == :ship do
        acc + 1
      else
        acc
      end
    end)
  end

  def transparent_board_to_string(board) do
    size = board.size
    matrix = board.matrix

    header = get_pretty_printable_repr_header(size)
    row_separator = get_pretty_printable_row_separator(size)
    res = header <> "\n" <> row_separator
    res = Enum.reduce(1..size, res, fn row_number, acc ->
      acc <> "\n" <> get_pretty_printable_row(row_number, board) <> "\n" <> row_separator
    end)
    res <> "\n"
  end

  def get_pretty_printable_repr_header(size) do
    res = for i <- 1..size, into: "", do: "   #{<<?A + i - 1>>}"
    " #{res}"
  end

  def get_pretty_printable_row_separator(size) do
    "  " <> String.duplicate("+---", size) <> "+"
  end

  def get_pretty_printable_row(row_number, board) do
    size = board.size
    matrix = board.matrix

    res = "#{row_number} |"
    Enum.reduce(1..size, res, fn col_number, acc ->
      acc <> " #{get_pretty_printable_cell(matrix[{row_number, col_number}])} |"
    end)
  end

  defp create_empty_matrix(size) do
    for i <- 1..size, j <- 1..size, into: %{} do
      {{i, j}, :empty}
    end
  end

  defp get_pretty_printable_cell(:empty), do: "~"
  defp get_pretty_printable_cell(:ship), do: "@"
  defp get_pretty_printable_cell(:hit), do: "*"
  defp get_pretty_printable_cell(:miss), do: "^"
end
