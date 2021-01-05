defmodule Rover.Server.Test do
  use ExUnit.Case
  doctest Rover.Server

  @east "E"
  @west "W"
  @north "N"
  @south "S"
  @left "L"
  @right "R"

  setup %{} do
    {:ok, pid} = Rover.Server.start_link(nil)
    on_exit(fn -> Process.exit(pid, :kill) end)
    %{}
  end

  test "Default state of rover is pointing to North direction." do
    rover = Rover.Server.get_current_state()
    assert rover.direction == @north
    assert rover.x == 0
    assert rover.y == 0
  end

  test "Persists the state of the rover after multiple move operations." do
    Rover.Server.move(@left, 5)
    Rover.Server.move(@right, 15)
    Rover.Server.move(@right, 10)

    rover = Rover.Server.get_current_state()
    assert rover.direction == @east
    assert rover.x == 5
    assert rover.y == 15
  end

  test "Returns an error if a rover is moved with invalid arguments." do
    response = Rover.Server.move("Z",-2)
    assert {:error, :invalid_input, _} = response
  end
  test "State is not disturbed if invalid arguments are used to move the rover." do
    rover = Rover.Server.get_current_state()
    Rover.Server.move("W",-22)
    new_rover = Rover.Server.get_current_state()

    assert rover.direction == new_rover.direction
    assert rover.x == new_rover.x
    assert rover.y == new_rover.y
  end
end
