defmodule Grid do
  @moduledoc """
  This is the Grid which will denote the bounds of the rover.
  """
  defstruct x: nil, y: nil

  @doc """
  Initializes a Grid with given bounds.

  ## Examples

      iex> Grid.init(1,2)
      %Grid{x: 1, y: 2}

  """
  def init(x, y) do
    %Grid{x: x, y: y}
  end

  @doc """
  Initializes a Grid with no bounds.

  ## Examples

      iex(1)> Grid.init()
      %Grid{x: nil, y: nil}

  """
  def init() do
    %Grid{}
  end

  def is_position_inside_bounds?(grid, x, y) do
    if(is_grid_unbounded?(grid)) do
      true
    else
      x >= 0 && y >= 0 && x < grid.x && y < grid.y
    end
  end

  defp is_grid_unbounded?(grid) do
    grid.x == nil && grid.y == nil
  end
end
