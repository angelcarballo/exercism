defmodule RobotSimulator do
  defstruct direction: :north, position: {0, 0}

  @directions [:north, :east, :south, :west]
  @movements [
    north: {0, 1},
    east: {1, 0},
    south: {0, -1},
    west: {-1, 0}
  ]

  defguard is_direction(d) when d in @directions
  defguard is_position(x,y) when is_integer(x) and is_integer(y)

  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0})
  def create(direction, {x, y}) when is_direction(direction) and is_position(x,y) do
      %RobotSimulator{direction: direction, position: {x, y}}
  end
  def create(_direction, {x,y}) when is_position(x,y), do: {:error, "invalid direction"}
  def create(_direction, _position), do: {:error, "invalid position"}

  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) when byte_size(instructions) > 1, do: robot |> simulate(String.codepoints(instructions))
  def simulate(robot, [h | t]), do: robot |> simulate(h) |> simulate(t)
  def simulate(robot, []), do: robot
  def simulate(robot = %{direction: :north}, "R"), do: %{robot | direction: :east}
  def simulate(robot = %{direction: :north}, "L"), do: %{robot | direction: :west}
  def simulate(robot = %{direction: :south}, "R"), do: %{robot | direction: :west}
  def simulate(robot = %{direction: :south}, "L"), do: %{robot | direction: :east}
  def simulate(robot = %{direction: :east}, "R"), do: %{robot | direction: :south}
  def simulate(robot = %{direction: :east}, "L"), do: %{robot | direction: :north}
  def simulate(robot = %{direction: :west}, "R"), do: %{robot | direction: :north}
  def simulate(robot = %{direction: :west}, "L"), do: %{robot | direction: :south}
  def simulate(robot = %{position: {x, y}}, "A") do
    {inc_x, inc_y} = @movements[robot.direction]
    %{robot | position: {x + inc_x, y + inc_y}}
  end
  def simulate(_robot, _instructions), do: {:error, "invalid instruction"}

  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction(%{direction: dir}), do: dir

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position(%{position: pos}), do: pos
end
