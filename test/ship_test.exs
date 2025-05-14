defmodule Battleship.ShipTest do
  use ExUnit.Case
  alias Battleship.Ship

  test "create_ship/1 creates a ship of size 2 at a given position, to the right, at the beggining the ship is not hit" do
    size = 2
    position = {1, 1}
    direction = :right
    ship = Ship.create_ship(size, position, direction)
    assert length(ship.positions) == size
    assert ship.positions == [{1, 1}, {1, 2}]
    assert ship.hits == []
  end

  test "create_ship/1 creates a ship of size 2 at a given position, to the down, at the beggining the ship is not hit" do
    size = 2
    position = {1, 1}
    direction = :down
    ship = Ship.create_ship(size, position, direction)
    assert length(ship.positions) == size
    assert ship.positions == [{1, 1}, {2, 1}]
    assert ship.hits == []
  end
end
