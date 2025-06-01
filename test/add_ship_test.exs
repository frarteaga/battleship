defmodule Battleship.AddShipTest do
  use ExUnit.Case
  alias Battleship.BoardConfiguration
  alias Battleship.Ship

  test "add a ship of size 1 to the board" do
    board = BoardConfiguration.create_empty_board(1)
    ship = Ship.create_ship!(1, {1, 1}, :right, 1)
    board = BoardConfiguration.add_ship(board, ship)
    assert board.matrix == %{{1, 1} => :ship}
  end

  test "add a ship of size 2 to the board to the right" do
    board = BoardConfiguration.create_empty_board(2)
    ship = Ship.create_ship!(2, {1, 1}, :right, 2)
    board = BoardConfiguration.add_ship(board, ship)
    assert board.matrix == %{
      {1, 1} => :ship, {1, 2} => :ship,
      {2, 1} => :empty, {2, 2} => :empty
    }
  end

  test "add a ship of size 2 to the board to the down" do
    board = BoardConfiguration.create_empty_board(2)
    ship = Ship.create_ship!(2, {1, 1}, :down, 2)
    board = BoardConfiguration.add_ship(board, ship)
    assert board.matrix == %{
      {1, 1} => :ship, {1, 2} => :empty,
      {2, 1} => :ship, {2, 2} => :empty
    }
  end

  # test "add a ship out of bounds should raise an error" do
  #   board_size = 1
  #   board = BoardConfiguration.create_empty_board(board_size)
  #   ship = Ship.create_ship!(2, {1, 1}, :right, board_size)
  #   assert_raise RuntimeError, fn ->
  #     BoardConfiguration.add_ship(board, ship)
  #   end
  # end
end
