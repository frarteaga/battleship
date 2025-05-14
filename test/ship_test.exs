defmodule Battleship.ShipTest do
  use ExUnit.Case
  alias Battleship.Ship

  test "create_ship!/1 creates a ship of size 2 at a given position, to the right, at the beggining the ship is not hit" do
    size = 2
    position = {1, 1}
    direction = :right
    ship = Ship.create_ship!(size, position, direction)
    assert length(ship.positions) == size
    assert ship.positions == [{1, 1}, {1, 2}]
    assert ship.hits == []
  end

  test "create_ship!/1 creates a ship of size 2 at a given position, to the down, at the beggining the ship is not hit" do
    size = 2
    position = {1, 1}
    direction = :down
    ship = Ship.create_ship!(size, position, direction)
    assert length(ship.positions) == size
    assert ship.positions == [{1, 1}, {2, 1}]
    assert ship.hits == []
  end

  test "create_ship/1 no bang version, returns {:ok, ship} or {:error, reason}" do
    size = 2
    position = {1, 1}
    direction = :right
    {:ok, ship} = Ship.create_ship(size, position, direction)
    assert length(ship.positions) == size
  end

  test "prevent ship creation outside of the board, position values should be >= {1, 1}" do
    size = 2
    position = {0, 1}
    direction = :right
    {:error, reason} = Ship.create_ship(size, position, direction)
    assert reason == "Invalid position"
  end

  test "validate_position/1 returns false if the x position is invalid" do
    position = {0, 1}
    assert Ship.validate_position?(position) == false
  end

  test "validate_position/1 returns false if the y position is invalid" do
    position = {1, 0}
    assert Ship.validate_position?(position) == false
  end

  test "validate_position/1 returns true if the position is valid" do
    position = {1, 1}
    assert Ship.validate_position?(position) == true
  end
end
