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
      response = Rover.Server.move("Z", -2)
      assert {:error, :invalid_input, _} = response
    end

    test "State is not disturbed if invalid arguments are used to move the rover." do
      rover = Rover.Server.get_current_state()
      Rover.Server.move("W", -22)
      new_rover = Rover.Server.get_current_state()

      assert rover.direction == new_rover.direction
      assert rover.x == new_rover.x
      assert rover.y == new_rover.y
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

      case move_response do
        {:ok, _} -> assert true
        _ -> assert false
      end
    end

    test "Moving a rover within bounds persists state." do
      Rover.Server.move(@right, 4)
      Rover.Server.move(@left, 3)
      new_rover = Rover.Server.get_current_state()

      assert new_rover.direction == @north
      assert new_rover.x == 4
      assert new_rover.y == 3
    end

    test "Trying to move a rover out of bounds is unsuccessfull." do
      move_response = Rover.Server.move(@left, 10)

      case move_response do
        {:error, _, _} -> assert true
        _ -> assert false
      end
    end

    test "Trying to move a rover out of bounds does not corrupt state." do
      rover = Rover.Server.get_current_state()
      move_response = Rover.Server.move(@right, 5)
      new_rover = Rover.Server.get_current_state()
      assert rover.direction == new_rover.direction
      assert rover.x == new_rover.x
      assert rover.y == new_rover.y
    end
  end
end
