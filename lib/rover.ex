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
  def init(opts \\ %Rover{}) do
    rover = %Rover{}
    Map.merge(rover, opts)
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
         :ok <-
           validate_next_position(grid, new_x, new_y) do
      {:ok, do_move(rover, new_direction, new_x, new_y)}
    else
      err -> err
    end
  end

  defp validate_steps(steps) do
    if(steps >= 0) do
      :ok
    else
      invalid_input_error(:steps)
    end
  end

  defp validate_direction(direction) do
    if(Enum.any?(@valid_directions, fn x -> direction == x end)) do
      :ok
    else
      invalid_input_error(:direction)
    end
  end

  defp validate_next_position(grid, new_x, new_y) do
    if(Grid.is_position_inside_bounds?(grid, new_x, new_y)) do
      :ok
    else
      {:error, :invalid_operation, :rover_position_out_of_bounds}
    end
  end

  defp get_next_position(%Rover{direction: @west, x: x, y: y}, @left, steps) do
    {@south, x, y - steps}
  end

  defp get_next_position(%Rover{direction: @east, x: x, y: y}, @left, steps) do
    {@north, x, y + steps}
  end

  defp get_next_position(%Rover{direction: @north, x: x, y: y}, @left, steps) do
    {@west, x - steps, y}
  end

  defp get_next_position(%Rover{direction: @south, x: x, y: y}, @left, steps) do
    {@east, x + steps, y}
  end

  defp get_next_position(%Rover{direction: @west, x: x, y: y}, @right, steps) do
    {@north, x, y + steps}
  end

  defp get_next_position(%Rover{direction: @east, x: x, y: y}, @right, steps) do
    {@south, x, y - steps}
  end

  defp get_next_position(%Rover{direction: @north, x: x, y: y}, @right, steps) do
    {@east, x + steps, y}
  end

  defp get_next_position(%Rover{direction: @south, x: x, y: y}, @right, steps) do
    {@west, x - steps, y}
  end

  defp do_move(rover, direction, x, y) do
    %Rover{rover | direction: direction, x: x, y: y}
  end

  defp invalid_input_error(attribute) do
    {:error, :invalid_input, attribute}
  end
end
