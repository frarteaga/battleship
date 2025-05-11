defmodule BoardConfigurationTest do
  use ExUnit.Case

  alias Battleship.BoardConfiguration

  test "create_empty_board" do
    assert BoardConfiguration.create_empty_board(1) == %BoardConfiguration{size: 1, matrix: %{
      {1, 1} => :empty
    }}
  end

  def empty_board_1x1() do
    expected_string = """
        A
      +---+
    1 | ~ |
      +---+
    """
    expected_string
  end

  def empty_board_2x2() do
    expected_string = """
        A   B
      +---+---+
    1 | ~ | ~ |
      +---+---+
    2 | ~ | ~ |
      +---+---+
    """
    expected_string
  end

  test "transparent_board_to_string/0 with empty 1x1 board" do
    board = BoardConfiguration.create_empty_board(1)
    assert BoardConfiguration.transparent_board_to_string(board) == empty_board_1x1()
  end

  test "transparent_board_to_string/0 with empty 2x2 board" do
    board = BoardConfiguration.create_empty_board(2)
    assert BoardConfiguration.transparent_board_to_string(board) == empty_board_2x2()
  end

  test "get_pretty_printable_repr_header/1 with size 1" do
    first_line_of_1x1_board = empty_board_1x1() |> String.split("\n") |> List.first()
    assert BoardConfiguration.get_pretty_printable_repr_header(1) == first_line_of_1x1_board
  end

  test "get_pretty_printable_repr_header/1 with size 2" do
    first_line_of_2x2_board = empty_board_2x2() |> String.split("\n") |> List.first()
    assert BoardConfiguration.get_pretty_printable_repr_header(2) == first_line_of_2x2_board
  end
end
