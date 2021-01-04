defmodule RoverTest do
  use ExUnit.Case
  doctest Rover

  @east "E"
  @west "W"
  @north "N"
  @south "S"
  @left "L"
  @right "R"

  test "Creating a rover" do
    rover = Rover.init()
    assert rover.direction == @north
    assert rover.x == 0
    assert rover.y == 0
  end

  test "Moving a North-facing rover to the left." do
    rover = Rover.init(%Rover{direction: @north, x: -5, y: 4}) |> Rover.move(@left, 2)
    assert rover.direction == @west
    assert rover.x == -7
    assert rover.y == 4
  end

  test "Moving a South-facing rover to the left." do
    rover = Rover.init(%Rover{direction: @south, x: 3, y: 7}) |> Rover.move(@left, 10)
    assert rover.direction == @east
    assert rover.x == 13
    assert rover.y == 7
  end

  test "Moving an East-facing rover to the left." do
    rover = Rover.init(%Rover{direction: @east, x: -10, y: -20}) |> Rover.move(@left, 100)
    assert rover.direction == @north
    assert rover.x == -10
    assert rover.y == 80
  end

  test "Moving a West-facing rover to the left." do
    rover = Rover.init(%Rover{direction: @west, x: 0, y: 0}) |> Rover.move(@left, 2)
    assert rover.direction == @south
    assert rover.x == 0
    assert rover.y == -2
  end

  test "Moving a North-facing rover to the right." do
    rover = Rover.init(%Rover{direction: @north, x: -205, y: 400}) |> Rover.move(@right, 129)
    assert rover.direction == @east
    assert rover.x == -76
    assert rover.y == 400
  end

  test "Moving a South-facing rover to the right." do
    rover = Rover.init(%Rover{direction: @south, x: 1002, y: 729}) |> Rover.move(@right, 200)
    assert rover.direction == @west
    assert rover.x == 802
    assert rover.y == 729
  end

  test "Moving an East-facing rover to the right." do
    rover = Rover.init(%Rover{direction: @east, x: -5, y: 4}) |> Rover.move(@right, 5)
    assert rover.direction == @south
    assert rover.x == -5
    assert rover.y == -1
  end

  test "Moving a West-facing rover to the right." do
    rover = Rover.init(%Rover{direction: @west, x: -100, y: 247}) |> Rover.move(@right, 22)
    assert rover.direction == @north
    assert rover.x == -100
    assert rover.y == 269
  end

  test "Moving a rover in an invalid direction." do
    rover = Rover.init() |> Rover.move("Z", 10)
    assert {:error, :invalid_input, :direction} = rover
  end

  test "Moving a rover by invalid number of steps." do
    rover = Rover.init() |> Rover.move(@left, -10)
    assert {:error, :invalid_input, :steps} = rover
  end
end
