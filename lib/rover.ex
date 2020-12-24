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
  def init() do
    %Rover{}
  end

  @doc """
  Moves the rover in the provided direction for provided steps.
  ## Examples
      iex> Rover.init()
      %Rover{direction: "N", x: 0, y: 0}

      iex> Rover.move(rover,"L",0)
      %Rover{direction: "W", x: 0, y: 0}

  """
  def move(rover, direction, steps) do
    do_move(rover, direction, steps)
  end

  defp do_move(rover, @left, steps) do
    case rover.direction do
      @north -> update(rover, @west, rover.x - steps, rover.y)
      @south -> update(rover, @east, rover.x + steps, rover.y)
      @east -> update(rover, @north, rover.x, rover.y + steps)
      @west -> update(rover, @south, rover.x, rover.y - steps)
    end
  end

  defp do_move(rover, @right, steps) do
    case rover.direction do
      @north -> update(rover, @east, rover.x + steps, rover.y)
      @south -> update(rover, @west, rover.x - steps, rover.y)
      @east -> update(rover, @south, rover.x, rover.y - steps)
      @west -> update(rover, @north, rover.x, rover.y + steps)
    end
  end

  defp update(rover, direction, x, y) do
    rover
    |> Map.update!(:direction, fn _ -> direction end)
    |> Map.update!(:x, fn _ -> x end)
    |> Map.update!(:y, fn _ -> y end)
  end
end
