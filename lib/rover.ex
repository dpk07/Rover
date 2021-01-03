defmodule Rover do
  @moduledoc """
  This is the Mars Rover which can move in two directions "Left" and "Right".
  """

  @east "E"
  @west "W"
  @north "N"
  @south "S"
  @left "L"
  @right "R"

  defstruct direction: @north, x: 0, y: 0

  @doc """
  Initializes a rover with default direction as "N"
  and location as 0,0.

  ## Examples

      iex> Rover.init()
      %Rover{direction: "N", x: 0, y: 0}

  """
  def init(opts \\ %Rover{}) do
    rover = %Rover{}
    Map.merge(rover, opts)
  end

  @doc """
  Moves the rover in the provided direction for provided steps.
  ## Examples
      iex> Rover.init() |> Rover.move("L",0) |> Rover.move("R",1)
      %Rover{direction: "N", x: 0, y: 1}

  """
  def move(rover, direction, steps) do
    do_move(rover, direction, steps)
  end

  defp do_move(rover = %Rover{direction: @west, x: x, y: y}, @left, steps) do
    update(rover, @south, x, y - steps)
  end

  defp do_move(rover = %Rover{direction: @east, x: x, y: y}, @left, steps) do
    update(rover, @north, x, y + steps)
  end

  defp do_move(rover = %Rover{direction: @north, x: x, y: y}, @left, steps) do
    update(rover, @west, x - steps, y)
  end

  defp do_move(rover = %Rover{direction: @south, x: x, y: y}, @left, steps) do
    update(rover, @east, x + steps, y)
  end

  defp do_move(rover = %Rover{direction: @west, x: x, y: y}, @right, steps) do
    update(rover, @north, x, y + steps)
  end

  defp do_move(rover = %Rover{direction: @east, x: x, y: y}, @right, steps) do
    update(rover, @south, x, y - steps)
  end

  defp do_move(rover = %Rover{direction: @north, x: x, y: y}, @right, steps) do
    update(rover, @east, x + steps, y)
  end

  defp do_move(rover = %Rover{direction: @south, x: x, y: y}, @right, steps) do
    update(rover, @west, x - steps, y)
  end

  defp update(rover, direction, x, y) do
    %Rover{rover | direction: direction, x: x, y: y}
  end
end
