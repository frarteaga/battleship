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

  def init(opts) do
    board_size = Keyword.get(opts, :board_size, 10)
    state = %{
      players: %{},
      board_config: %BoardConfiguration{
        size: board_size,
        matrix: BoardConfiguration.create_empty_board(board_size)
      },
      current_turn: nil,
      game_status: :waiting_for_players
    }
    {:ok, state}
  end

  # Server Callbacks
  def handle_call({:register_player, player_id}, _from, state) do
    if map_size(state.players) < 2 do
      new_state = put_in(state.players[player_id], %{
        board: BoardConfiguration.create_empty_board(state.board_config.size),
        ships: [],
        hits: [],
        misses: []
      })
      {:reply, :ok, new_state}
    else
      {:reply, {:error, :game_full}, state}
    end
  end
end
