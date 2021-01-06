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
  def init(x, y), do: %Grid{x: x, y: y}

  @doc """
  Initializes a Grid with no bounds.

  ## Examples

      iex(1)> Grid.init()
      %Grid{x: nil, y: nil}

  """
  def init(), do: %Grid{}

  def validate_position_on_grid(grid, x, y) do
    cond do
      grid_unbounded?(grid) -> :ok
      position_inside_grid_boundary?(grid, x, y) -> :ok
      true -> {:error, :invalid_operation, :position_out_of_bounds}
    end
  end

  defp position_inside_grid_boundary?(grid, x, y), do: x >= 0 && y >= 0 && x < grid.x && y < grid.y

  defp grid_unbounded?(grid), do: grid.x == nil && grid.y == nil
end
