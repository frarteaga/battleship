defmodule NonEmptyBoardConfigurationTest do
  use ExUnit.Case

  alias Battleship.BoardConfiguration

  @non_empty_board_1x1 %BoardConfiguration{size: 1, matrix: %{
    {1, 1} => :ship
  }}

  @non_empty_board_1x1_repr """
      A
    +---+
  1 | @ |
    +---+
  """

  @non_empty_board_2x2_repr_right %BoardConfiguration{size: 2, matrix: %{
    {1, 1} => :ship,
    {1, 2} => :ship,
    {2, 1} => :empty,
    {2, 2} => :empty
  }}

  @non_empty_board_2x2_repr_right_repr """
      A   B
    +---+---+
  1 | @ | @ |
    +---+---+
  2 | ~ | ~ |
    +---+---+
  """

  @non_empty_board_2x2_repr_down %BoardConfiguration{size: 2, matrix: %{
    {1, 1} => :ship,
    {2, 1} => :ship,
    {1, 2} => :empty,
    {2, 2} => :empty
  }}

  @non_empty_board_2x2_repr_down_repr """
      A   B
    +---+---+
  1 | @ | ~ |
    +---+---+
  2 | @ | ~ |
    +---+---+
  """

  test "create_empty_board and add a ship of size 1 to the right" do
    board = BoardConfiguration.create_empty_board(1)
    position = {1, 1}
    direction = :right # or :down
    size = 1
    board = BoardConfiguration.add_ship(board, position, direction, size)
    assert board == @non_empty_board_1x1
  end

  test "create_empty_board and add a ship of size 1 to the down" do
    board = BoardConfiguration.create_empty_board(1)
    position = {1, 1}
    direction = :down
    size = 1
    board = BoardConfiguration.add_ship(board, position, direction, size)
    assert board == @non_empty_board_1x1
  end

  test "create_empty_board and add a ship of size 2 to the right" do
    board = BoardConfiguration.create_empty_board(2)
    position = {1, 1}
    direction = :right
    size = 2
    board = BoardConfiguration.add_ship(board, position, direction, size)
    assert board == @non_empty_board_2x2_repr_right
  end

  test "create_empty_board and add a ship of size 2 to the down" do
    board = BoardConfiguration.create_empty_board(2)
    position = {1, 1}
    direction = :down
    size = 2
    board = BoardConfiguration.add_ship(board, position, direction, size)
    assert board == @non_empty_board_2x2_repr_down
  end

end
