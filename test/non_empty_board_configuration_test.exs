defmodule NonEmptyBoardConfigurationTest do
  use ExUnit.Case

  alias Battleship.BoardConfiguration
   # ttest
  test "create_empty_board" do
    assert BoardConfiguration.create_empty_board(1) == %BoardConfiguration{size: 1, matrix: %{
      {1, 1} => :empty
    }}
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
