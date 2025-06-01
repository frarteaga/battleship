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

  test "add a ship that collides with another ship should raise an error" do
    board = BoardConfiguration.create_empty_board(2)
    ship = Ship.create_ship!(2, {1, 1}, :right, 2)
    board = BoardConfiguration.add_ship(board, ship)
    try do
      BoardConfiguration.add_ship(board, ship)
      assert false
    rescue
      error -> IO.inspect(error)
    end
  end
end
