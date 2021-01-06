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
  @valid_directions [@left, @right]
  defstruct direction: @north, x: 0, y: 0

  @doc """
  Initializes a rover with default direction as "N"
  and location as 0,0.

  ## Examples

      iex> Rover.init()
      %Rover{direction: "N", x: 0, y: 0}

  """
  def init(opts \\ %{}) do
    direction = Map.get(opts, :direction, @north)
    x = Map.get(opts, :x, 0)
    y = Map.get(opts, :y, 0)
    %Rover{direction: direction, x: x, y: y}
  end

  @doc """
  Moves the rover in the provided direction for provided steps.
  ## Examples
      iex> Rover.init(%Rover{direction: "W"}) |> Rover.move("R",1,%Grid{x: 2,y: 2})
      {:ok, %Rover{direction: "N", x: 0, y: 1}}

  """
  def move(rover, direction, steps, grid) do
    with :ok <- validate_steps(steps),
         :ok <- validate_direction(direction),
         {new_direction, new_x, new_y} <- get_next_position(rover, direction, steps),
         :ok <- validate_next_position(grid, new_x, new_y) do
      {:ok, do_move(rover, new_direction, new_x, new_y)}
    else
      err -> err
    end
  end

  defp validate_steps(steps) when steps >= 0, do: :ok

  defp validate_steps(_steps), do: invalid_input_error(:steps)

  defp validate_direction(direction) when direction in @valid_directions, do: :ok

  defp validate_direction(_direction), do: invalid_input_error(:direction)

  defdelegate validate_next_position(grid, new_x, new_y), to: Grid, as: :validate_position_on_grid

  defp get_next_position(%Rover{direction: @west, x: x, y: y}, @left, steps), do: {@south, x, y - steps}

  defp get_next_position(%Rover{direction: @east, x: x, y: y}, @left, steps), do: {@north, x, y + steps}

  defp get_next_position(%Rover{direction: @north, x: x, y: y}, @left, steps), do: {@west, x - steps, y}

  defp get_next_position(%Rover{direction: @south, x: x, y: y}, @left, steps), do: {@east, x + steps, y}

  defp get_next_position(%Rover{direction: @west, x: x, y: y}, @right, steps), do: {@north, x, y + steps}

  defp get_next_position(%Rover{direction: @east, x: x, y: y}, @right, steps), do: {@south, x, y - steps}

  defp get_next_position(%Rover{direction: @north, x: x, y: y}, @right, steps), do: {@east, x + steps, y}

  defp get_next_position(%Rover{direction: @south, x: x, y: y}, @right, steps), do: {@west, x - steps, y}

  defp do_move(rover, direction, x, y), do: %Rover{rover | direction: direction, x: x, y: y}

  defp invalid_input_error(attribute), do: {:error, :invalid_input, attribute}
end
