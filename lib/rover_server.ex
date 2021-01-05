defmodule Rover.Server do
  use GenServer

  @doc """
  Starts a Rover Server, locally registered as module name.
  ## Examples
      Rover.Server.start_link(nil)
      {:ok, _pid}
  """
  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg, name: __MODULE__)
  end

  @doc """
  Moves the rover in the provided direction for provided steps.
  ## Examples
       Rover.Server.start_link(nil)
       Rover.Server.move("L",0)
       Rover.Server.move("R",1)
      {:ok, %Rover{direction: "N", x: 0, y: 1}}
  """
  def move(direction, steps) do
    GenServer.call(__MODULE__, {:move, direction, steps})
  end

  @doc """
  Gets the current state(direction and location) of the Rover.
  ## Examples
       Rover.Server.start_link(nil)
       Rover.Server.get_current_state()
      %Rover{direction: "N", x: 0, y: 0}
  """
  def get_current_state() do
    GenServer.call(__MODULE__, {:get})
  end

  @impl true
  def init(arg) do
    case arg do
      nil -> {:ok, {Rover.init(), Grid.init()}}
      {x, y} when x > 0 and y > 0 -> {:ok, {Rover.init(), Grid.init(x, y)}}
      _ -> {:stop, "Invalid arguments, grid bounds should be greater than zero."}
    end
  end

  @impl true
  def handle_call({:get}, _, {rover, grid}) do
    {:reply, rover, {rover, grid}}
  end

  @impl true
  def handle_call({:move, direction, steps}, _, {rover, grid}) do
    move_response = Rover.move(rover, direction, steps)

    case move_response do
      {:error, _, _} = error ->
        {:reply, error, {rover, grid}}

      {:ok, new_rover} ->
        case validate_rover_position(new_rover, grid) do
          {:ok, new_rover} -> {:reply, {:ok, new_rover}, {new_rover, grid}}
          err -> {:reply, err, {rover, grid}}
        end
    end
  end

  defp validate_rover_position(%Rover{x: x, y: y, direction: _} = rover, grid) do
    case grid do
      %Grid{x: nil, y: nil} ->
        {:ok, rover}

      %Grid{x: grid_x, y: grid_y} ->
        if(x < 0 || y < 0 || x >= grid_x || y >= grid_y) do
          {:error, :invalid_operation, :rover_position_out_of_bounds}
        else
          {:ok, rover}
        end
    end
  end

  def child_spec(_) do
    %{id: __MODULE__, start: {__MODULE__, :start_link, [nil]}}
  end
end
