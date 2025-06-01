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
      game_status: :waiting_for_players,
      ship_lengths: ship_lengths
    }}
  end

  def register_player(match, player_id) do
    GenServer.call(match, {:register_player, player_id})
  end

  # Server Callbacks
  def handle_call({:register_player, player_id}, _from, state) do
    new_state = put_in(state.players[player_id], %{
      board: BoardConfiguration.create_empty_board(state.board_size),
      ships: [],
      hits: [],
      misses: []
    })
    {:reply, :ok, new_state}
  end
end
