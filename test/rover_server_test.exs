defmodule Rover.Server.Test do
  use ExUnit.Case
  doctest Rover.Server

  @east "E"
  @west "W"
  @north "N"
  @south "S"
  @left "L"
  @right "R"

  describe "Rover without bounds" do
    setup %{} do
      {:ok, pid} = Rover.Server.start_link({1000, 1000})
      on_exit(fn -> Process.exit(pid, :kill) end)
      %{}
    end

    test "Default state of rover is pointing to North direction." do
      rover = Rover.Server.get_current_state()
      expected_rover = %Rover{direction: @north, x: 0, y: 0}
      assert rover == expected_rover
    end

    test "Persists the state of the rover after multiple move operations." do
      Rover.Server.move(@right, 15)
      Rover.Server.move(@left, 10)
      Rover.Server.move(@left, 5)
      expected_rover = %Rover{direction: @west, x: 10, y: 10}
      new_rover = Rover.Server.get_current_state()
      assert expected_rover == new_rover
    end

    test "Returns an error if a rover is moved with invalid arguments." do
      response = Rover.Server.move("Z", -2)
      assert {:error, :invalid_input, _} = response
    end

    test "State is not disturbed if invalid arguments are used to move the rover." do
      rover = Rover.Server.get_current_state()
      Rover.Server.move("W", -22)
      new_rover = Rover.Server.get_current_state()
      assert new_rover == rover
    end
  end

  describe "Rover with bounds." do
    setup %{} do
      {:ok, pid} = Rover.Server.start_link({5, 5})
      on_exit(fn -> Process.exit(pid, :kill) end)
      %{}
    end

    test "Moving a rover within bounds is successfull." do
      move_response = Rover.Server.move(@right, 4)
      assert move_response == {:ok, %Rover{x: 4, y: 0, direction: @east}}
    end

    test "Moving a rover within bounds persists state." do
      Rover.Server.move(@right, 4)
      Rover.Server.move(@left, 3)
      new_rover = Rover.Server.get_current_state()
      expected_rover = %Rover{direction: @north, x: 4, y: 3}
      assert new_rover == expected_rover
    end

    test "Trying to move a rover out of bounds is unsuccessfull." do
      move_response = Rover.Server.move(@left, 10)
      assert move_response == {:error, :invalid_operation, :position_out_of_bounds}
    end

    test "Trying to move a rover out of bounds does not corrupt state." do
      rover = Rover.Server.get_current_state()
      Rover.Server.move(@right, 5)
      new_rover = Rover.Server.get_current_state()
      assert rover == new_rover
    end
  end
end
