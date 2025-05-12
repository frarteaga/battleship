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

  def add_ship(board, position, direction, size) do
    row = position |> elem(0)
    col = position |> elem(1)
    updated_matrix = case direction do
      :right ->
        Enum.reduce(0..(size - 1), board.matrix, fn i, acc ->
          Map.put(acc, {row, col + i}, :ship)
        end)
      :down ->
        Enum.reduce(0..(size - 1), board.matrix, fn i, acc ->
          Map.put(acc, {row + i, col}, :ship)
        end)
    end
    %__MODULE__{
      size: board.size,
      matrix: updated_matrix
    }
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
