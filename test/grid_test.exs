defmodule GridTest do
  use ExUnit.Case
  doctest Grid

  describe "Unbounded grid." do
    test "Is position inside bounds should always be true." do
      grid = Grid.init()
      assert Grid.is_position_inside_bounds?(grid, 1000, 1000)
    end
  end

  describe "Bounded grid." do
    test "Is position inside bounds should be true." do
      grid = Grid.init(5, 5)
      assert Grid.is_position_inside_bounds?(grid, 0, 0) == true
      assert Grid.is_position_inside_bounds?(grid, 4, 4) == true
    end

    test "Is position inside bounds should be false." do
      grid = Grid.init(5, 5)
      assert Grid.is_position_inside_bounds?(grid, 1000, 1000) == false
      assert Grid.is_position_inside_bounds?(grid, -1, 1000) == false
      assert Grid.is_position_inside_bounds?(grid, 5, 0) == false
    end
  end
end
