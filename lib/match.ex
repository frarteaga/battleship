defmodule Battleship.Match do
  @moduledoc """
  GenServer that manages a Battleship match between two players.
  """
  use GenServer

  alias Battleship.BoardConfiguration

  # Client API
  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts)
  end

  @spec init(any()) :: {:ok, any()}
  def init(opts) do
    board_size = Keyword.get(opts, :board_size, 10)
    ship_lengths = Keyword.get(opts, :ship_lengths, [2, 3, 3, 4, 5])
    {:ok, %{
      players: %{},
      board_size: board_size,
      current_turn: nil,
      game_status: :registering_players,
      ship_lengths: ship_lengths
    }}
  end

  def register_player(match, player_id, opts \\ []) do
    timeout = Keyword.get(opts, :timeout, 5000)
    GenServer.call(match, {:register_player, player_id}, timeout)
  end

  # Server Callbacks
  def handle_call({:register_player, player_id}, _from, state) do
    if map_size(state.players) == 2 do
      {:reply, {:error, :game_full}, state}
    else
      new_state = put_in(state.players[player_id], %{
        board: BoardConfiguration.create_empty_board(state.board_size),
        ships: [],
        hits: [],
        misses: []
      })
      if map_size(new_state.players) == 2 do
        {:reply, :ok, %{new_state | game_status: :adding_ships}}
      else
        {:reply, :ok, new_state}
      end
    end
  end
end
