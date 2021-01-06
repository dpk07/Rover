defmodule GridTest do
  use ExUnit.Case
  doctest Grid

  describe "Unbounded grid." do
    test "Validate position in grid should be ok." do
      grid = Grid.init()
      assert Grid.validate_position_on_grid(grid, 1000, 1000) == :ok
    end
  end

  describe "Bounded grid." do
    test "Validate position in grid should be ok." do
      grid = Grid.init(5, 5)
      assert Grid.validate_position_on_grid(grid, 0, 0) == :ok
      assert Grid.validate_position_on_grid(grid, 4, 4) == :ok
    end

    test "Validate position in grid should return error." do
      grid = Grid.init(5, 5)
      error = {:error, :invalid_operation, :position_out_of_bounds}
      assert Grid.validate_position_on_grid(grid, 1000, 1000) == error
      assert Grid.validate_position_on_grid(grid, -1, 1000) == error
      assert Grid.validate_position_on_grid(grid, 5, 0) == error
    end
  end
end
