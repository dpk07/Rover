defmodule RoverTest do
  use ExUnit.Case
  doctest Rover

  test "Creating a rover" do
    rover = Rover.init()
    assert rover.direction == "N"
    assert rover.x == 0
    assert rover.y == 0
  end

  test "Moving a new rover" do
    rover = Rover.init()
    rover = Rover.move(rover, "L", 0)
    assert rover.direction == "W"
    assert rover.x == 0
    assert rover.y == 0
    rover = Rover.move(rover, "R", 1)
    assert rover.direction == "N"
    assert rover.x == 0
    assert rover.y == 1
  end
end
