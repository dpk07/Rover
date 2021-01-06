defmodule RoverTest do
  use ExUnit.Case
  doctest Rover

  @east "E"
  @west "W"
  @north "N"
  @south "S"
  @left "L"
  @right "R"

  setup(%{}) do
    grid = Grid.init(1000, 1000)
    %{grid: grid}
  end

  test "Creating a rover" do
    rover = Rover.init()
    expected_rover = %Rover{direction: @north, x: 0, y: 0}
    assert rover == expected_rover
  end

  test "Moving a North-facing rover to the left.", %{grid: grid} do
    {:ok, new_rover} =
      Rover.init(%Rover{direction: @north, x: 5, y: 4})
      |> Rover.move(@left, 2, grid)

    expected_rover = %Rover{direction: @west, x: 3, y: 4}
    assert new_rover == expected_rover
  end

  test "Moving a South-facing rover to the left.", %{grid: grid} do
    {:ok, new_rover} =
      Rover.init(%Rover{direction: @south, x: 3, y: 7})
      |> Rover.move(@left, 10, grid)

    expected_rover = %Rover{direction: @east, x: 13, y: 7}
    assert new_rover == expected_rover
  end

  test "Moving an East-facing rover to the left.", %{grid: grid} do
    {:ok, new_rover} =
      Rover.init(%Rover{direction: @east, x: 10, y: 20})
      |> Rover.move(@left, 100, grid)

    expected_rover = %Rover{direction: @north, x: 10, y: 120}
    assert new_rover == expected_rover
  end

  test "Moving a West-facing rover to the left.", %{grid: grid} do
    {:ok, new_rover} = Rover.init(%Rover{direction: @west, x: 0, y: 2}) |> Rover.move(@left, 2, grid)

    expected_rover = %Rover{direction: @south, x: 0, y: 0}
    assert new_rover == expected_rover
  end

  test "Moving a North-facing rover to the right.", %{grid: grid} do
    {:ok, new_rover} = Rover.init(%Rover{direction: @north, x: 205, y: 400}) |> Rover.move(@right, 129, grid)

    expected_rover = %Rover{direction: @east, x: 334, y: 400}
    assert new_rover == expected_rover
  end

  test "Moving a South-facing rover to the right.", %{grid: grid} do
    {:ok, new_rover} = Rover.init(%Rover{direction: @south, x: 1002, y: 729}) |> Rover.move(@right, 200, grid)

    expected_rover = %Rover{direction: @west, x: 802, y: 729}
    assert new_rover == expected_rover
  end

  test "Moving an East-facing rover to the right.", %{grid: grid} do
    {:ok, new_rover} = Rover.init(%Rover{direction: @east, x: 5, y: 5}) |> Rover.move(@right, 4, grid)

    expected_rover = %Rover{direction: @south, x: 5, y: 1}
    assert new_rover == expected_rover
  end

  test "Moving a West-facing rover to the right.", %{grid: grid} do
    {:ok, new_rover} = Rover.init(%Rover{direction: @west, x: 100, y: 247}) |> Rover.move(@right, 22, grid)

    expected_rover = %Rover{direction: @north, x: 100, y: 269}
    assert new_rover == expected_rover
  end

  test "Moving a rover in an invalid direction returns error.", %{grid: grid} do
    error = Rover.init() |> Rover.move("Z", 10, grid)
    assert {:error, :invalid_input, :direction} = error
  end

  test "Moving a rover by invalid number of steps returns error.", %{grid: grid} do
    error = Rover.init() |> Rover.move(@left, -10, grid)
    assert {:error, :invalid_input, :steps} = error
  end

  test "Moving a rover outside the grid returns error.", %{grid: grid} do
    error = Rover.init(%Rover{direction: @west, x: 100, y: 247}) |> Rover.move(@right, 1000, grid)
    assert {:error, :invalid_operation, :rover_position_out_of_bounds} = error
    error = Rover.init(%Rover{direction: @north, x: 0, y: 0}) |> Rover.move(@left, 1, grid)
    assert {:error, :invalid_operation, :rover_position_out_of_bounds} = error
  end
end
