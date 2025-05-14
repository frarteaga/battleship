defmodule Battleship.ShipTest do
  use ExUnit.Case
  alias Battleship.Ship

  test "create_ship!/1 creates a ship of size 2 at a given position, to the right, at the beggining the ship is not hit" do
    size = 2
    position = {1, 1}
    direction = :right
    board_size = 2
    ship = Ship.create_ship!(size, position, direction, board_size)
    assert length(ship.positions) == size
    assert ship.positions == [{1, 1}, {1, 2}]
    assert ship.hits == []
  end

  test "create_ship!/1 creates a ship of size 2 at a given position, to the down, at the beggining the ship is not hit" do
    size = 2
    position = {1, 1}
    direction = :down
    board_size = 2
    ship = Ship.create_ship!(size, position, direction, board_size)
    assert length(ship.positions) == size
    assert ship.positions == [{1, 1}, {2, 1}]
    assert ship.hits == []
  end

  test "create_ship/1 no bang version, returns {:ok, ship} or {:error, reason}" do
    size = 2
    position = {1, 1}
    direction = :right
    board_size = 2
    {:ok, ship} = Ship.create_ship(size, position, direction, board_size)
    assert length(ship.positions) == size
  end

  test "prevent ship creation outside of the board, position values should be >= {1, 1}" do
    size = 2
    position = {0, 1}
    direction = :right
    board_size = 2
    {:error, reason} = Ship.create_ship(size, position, direction, board_size)
  end

  test "validate_ship_inside_the_board? returns false if the x position is below 1" do
    position = {0, 1}
    size = 2
    direction = :right
    board_size = 10
    assert Ship.validate_ship_inside_the_board?(position, size, direction, board_size) == false
  end

  test "validate_ship_inside_the_board? returns false if the y position is below 1" do
    position = {1, 0}
    size = 2
    direction = :right
    board_size = 10
    assert Ship.validate_ship_inside_the_board?(position, size, direction, board_size) == false
  end

  test "validate_position_size? returns true if the ship is inside the board" do
    position = {1, 1}
    size = 10
    direction = :right
    board_size = 10
    assert Ship.validate_ship_inside_the_board?(position, size, direction, board_size) == true
  end
end
