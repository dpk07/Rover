defmodule Rover.Server do
  use GenServer

  @doc """
  Starts a Rover Server, locally registered as module name.
  ## Examples
      Rover.Server.start_link(nil)
      {:ok, _pid}
  """
  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  @doc """
  Moves the rover in the provided direction for provided steps.
  ## Examples
      iex> Rover.Server.start_link(nil)
      ...> Rover.Server.move("L",0)
      ...> Rover.Server.move("R",1)
      %Rover{direction: "N", x: 0, y: 1}
  """
  def move(direction, steps) do
    GenServer.call(__MODULE__, {:move, direction, steps})
  end

  @doc """
  Gets the current state(direction and location) of the Rover.
  ## Examples
      iex> Rover.Server.start_link(nil)
      ...> Rover.Server.get_current_state()
      %Rover{direction: "N", x: 0, y: 0}
  """
  def get_current_state() do
    GenServer.call(__MODULE__, {:get})
  end

  @impl true
  def init(_) do
    {:ok, Rover.init()}
  end

  @impl true
  def handle_call({:get}, _, rover) do
    {:reply, rover, rover}
  end

  @impl true
  def handle_call({:move, direction, steps}, _, rover) do
    rover = Rover.move(rover, direction, steps)
    {:reply, rover, rover}
  end

  def child_spec(_) do
    %{id: __MODULE__, start: {__MODULE__, :start_link, [nil]}}
  end
end
