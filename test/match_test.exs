defmodule Battleship.MatchTest do
  use ExUnit.Case

  alias Battleship.Match
  alias Battleship.Ship
  alias Battleship.BoardConfiguration

  test "start_match/1 should create the right initial state" do
    {:ok, match} = Match.start_link([
      board_size: 20,
      ship_lengths: [2, 3, 3, 4, 5, 10]
    ])
    state = :sys.get_state(match)
    assert state == %{
      players: %{},
      board_size: 20,
      current_turn: nil,
      game_status: :registering_players,
      ship_lengths: [2, 3, 3, 4, 5, 10]
    }
  end

  test "register_player/2 should add the player to the match" do
    {:ok, match} = Match.start_link([
      board_size: 5,
      ship_lengths: [1, 2, 3]
    ])
    Match.register_player(match, "player1")
    state = :sys.get_state(match)
    assert state.players |> map_size() == 1
    assert state.players |> Map.get("player1") != nil
  end

  test "register_player/2 called twice should add two players and set the game status to :adding_ships" do
    {:ok, match} = Match.start_link([
      board_size: 5,
      ship_lengths: [1, 2, 3]
    ])
    Match.register_player(match, "player1", timeout: 1000000)
    Match.register_player(match, "player2", timeout: 1000000)
    state = :sys.get_state(match)
    assert state.players |> map_size() == 2
    assert state.players |> Map.get("player1") != nil
    assert state.players |> Map.get("player2") != nil
    assert state.game_status == :adding_ships
  end

  test "register_player/2 should do nothing if the player is already registered" do
    {:ok, match} = Match.start_link([
      board_size: 5,
      ship_lengths: [1, 2, 3]
    ])
    Match.register_player(match, "player1")
    Match.register_player(match, "player1")
    state = :sys.get_state(match)
    assert state.players |> map_size() == 1
    assert state.players |> Map.get("player1") != nil
  end

  test "register_player/2 should return an error if the match is full" do
    {:ok, match} = Match.start_link([
      board_size: 5,
      ship_lengths: [1, 2, 3]
    ])
    Match.register_player(match, "player1")
    Match.register_player(match, "player2")
    r = Match.register_player(match, "player3")
    assert r == {:error, :game_full}
    state = :sys.get_state(match)
    assert state.players |> map_size() == 2
    assert state.players |> Map.get("player1") != nil
    assert state.players |> Map.get("player2") != nil
    assert state.players |> Map.get("player3") == nil
  end

  test "add_ships can't be called in the wrong state" do
    {:ok, match} = Match.start_link([
      board_size: 5,
      ship_lengths: [1, 2, 3]
    ])
    Match.register_player(match, "player1")
    {:error, :wrong_state_to_add_ships} = Match.add_ships(match, "player1", [])
  end

  test "add_ships should allow to add a valid set of ships for a player" do
    board_size = 5
    ship_lengths = [1, 2, 3]
    {:ok, match} = Match.start_link([
      board_size: board_size,
      ship_lengths: ship_lengths
    ])
    Match.register_player(match, "player1")
    Match.register_player(match, "player2")
    player1_ships = Enum.with_index(ship_lengths, 1) |> Enum.map(fn({ship_length, row}) ->
      Ship.create_ship!(ship_length, {row, 1}, :right, board_size)
    end)
    assert player1_ships |> length() == length(ship_lengths)
    r = Match.add_ships(match, "player1", player1_ships)
    assert r == :ok
    state = :sys.get_state(match)
    assert state.players |> Map.get("player1") |> Map.get(:ships) |> length() == length(ship_lengths)
    board = state.players |> Map.get("player1") |> Map.get(:board)
    ship_cells_count = BoardConfiguration.get_ship_cells_count(board)
    assert ship_cells_count == Enum.sum(ship_lengths)
    assert state.players |> Map.get("player2") |> Map.get(:ships) == []
  end
end
