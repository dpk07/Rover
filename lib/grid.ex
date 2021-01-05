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
end
