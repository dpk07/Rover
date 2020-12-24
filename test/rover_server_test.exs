defmodule Rover.Server.Test do
  use ExUnit.Case
  doctest Rover.Server

  test "Creating a rover" do
    Rover.Server.start_link()
    rover = Rover.Server.get_current_state()
    assert rover.direction == "N"
    assert rover.x == 0
    assert rover.y == 0
  end

  test "Moving a new rover" do
    Rover.Server.start_link()
    Rover.Server.move("L", 0)
    rover = Rover.Server.get_current_state()
    assert rover.direction == "W"
    assert rover.x == 0
    assert rover.y == 0
    Rover.Server.move("R", 1)
    rover = Rover.Server.get_current_state()
    assert rover.direction == "N"
    assert rover.x == 0
    assert rover.y == 1
  end
end
