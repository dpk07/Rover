defmodule Rover.Server.Test do
  use ExUnit.Case
  doctest Rover.Server

  setup %{} do
    Rover.Server.start_link(nil)
    rover = Rover.Server.get_current_state()
    random_number = :rand.uniform(100)
    %{rover: rover, steps: random_number}
  end

  test "Creating a rover", %{rover: rover} do
    assert rover.direction == "N"
    assert rover.x == 0
    assert rover.y == 0
  end

  test "Moving a North-facing rover to the left.", %{
    rover: %Rover{direction: _direction, x: x, y: y},
    steps: steps
  } do
    rover = Rover.Server.move("L", steps)
    assert rover.direction == "W"
    assert rover.x == x - steps
    assert rover.y == y
  end

  test "Moving a South-facing rover to the left.", %{
    rover: %Rover{direction: _direction, x: x, y: y},
    steps: steps
  } do
    Rover.Server.move("L", 0)
    Rover.Server.move("L", 0)
    rover = Rover.Server.move("L", steps)
    assert rover.direction == "E"
    assert rover.x == x + steps
    assert rover.y == y
  end

  test "Moving an East-facing rover to the left.", %{
    rover: %Rover{direction: _direction, x: x, y: y},
    steps: steps
  } do
    Rover.Server.move("R", 0)
    rover = Rover.Server.move("L", steps)
    assert rover.direction == "N"
    assert rover.x == x
    assert rover.y == y + steps
  end

  test "Moving a West-facing rover to the left.", %{
    rover: %Rover{direction: _direction, x: x, y: y},
    steps: steps
  } do
    Rover.Server.move("L", 0)
    rover = Rover.Server.move("L", steps)
    assert rover.direction == "S"
    assert rover.x == x
    assert rover.y == y - steps
  end

  test "Moving a North-facing rover to the right.", %{
    rover: %Rover{direction: _direction, x: x, y: y},
    steps: steps
  } do
    rover = Rover.Server.move("R", steps)
    assert rover.direction == "E"
    assert rover.x == x + steps
    assert rover.y == y
  end

  test "Moving a South-facing rover to the right.", %{
    rover: %Rover{direction: _direction, x: x, y: y},
    steps: steps
  } do
    Rover.Server.move("L", 0)
    Rover.Server.move("L", 0)
    rover = Rover.Server.move("R", steps)
    assert rover.direction == "W"
    assert rover.x == x - steps
    assert rover.y == y
  end

  test "Moving an East-facing rover to the right.", %{
    rover: %Rover{direction: _direction, x: x, y: y},
    steps: steps
  } do
    Rover.Server.move("R", 0)
    rover = Rover.Server.move("R", steps)
    assert rover.direction == "S"
    assert rover.x == x
    assert rover.y == y - steps
  end

  test "Moving a West-facing rover to the right.", %{
    rover: %Rover{direction: _direction, x: x, y: y},
    steps: steps
  } do
    Rover.Server.move("L", 0)
    rover = Rover.Server.move("R", steps)
    assert rover.direction == "N"
    assert rover.x == x
    assert rover.y == y + steps
  end
end
