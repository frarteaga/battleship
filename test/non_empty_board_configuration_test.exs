defmodule NonEmptyBoardConfigurationTest do
  use ExUnit.Case

  alias Battleship.BoardConfiguration

  test "create_empty_board and add a ship of size 1" do
    board = BoardConfiguration.create_empty_board(1)
    position = {1, 1}
    direction = :right # or :down
    size = 1
    board = BoardConfiguration.add_ship(board, position, direction, size)
    expected_board = %BoardConfiguration{size: 1, matrix: %{
      {1, 1} => :ship
    }}
    assert board == expected_board
  end

  def non_empty_board_1x1(%BoardConfiguration{size: 1, matrix: %{
    {1, 1} => :ship
  }}) do
    expected_string = """
        A
      +---+
    1 | @ |
      +---+
    """
    expected_string
  end


end
