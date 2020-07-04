defmodule Bowling do
  defstruct frames: %{}, current_frame: 1, ended: false

  @pin_count_exceeded_error "Pin count exceeds pins on the lane"

  @max_pins 10
  @last_frame 10
  @bonus_frame 11
  @end_frame 12

  @doc """
    Creates a new game of bowling that can be used to store the results of
    the game
  """

  @spec start() :: any
  def start do
    %__MODULE__{}
  end

  @doc """
    Records the number of pins knocked down on a single roll. Returns `any`
    unless there is something wrong with the given number of pins, in which
    case it returns a helpful message.
  """

  @spec roll(any, integer) :: any | String.t()

  def roll(%{ended: true}, _roll), do: {:error, "Cannot roll after game is over"}
  def roll(_game, roll) when roll < 0, do: {:error, "Negative roll is invalid"}
  def roll(_game, roll) when roll > @max_pins, do: {:error, @pin_count_exceeded_error}

  def roll(game = %{frames: frames, current_frame: current}, roll) do
    case Map.get(frames, current) do
      [_x, _y] -> roll(%{game | current_frame: current + 1}, roll)
      [@max_pins] -> roll(%{game | current_frame: current + 1}, roll)
      [x] when x + roll > @max_pins -> {:error, @pin_count_exceeded_error}
      [x] -> %{game | frames: Map.put(frames, current, [x, roll])}
      nil -> %{game | frames: Map.put(frames, current, [roll])}
    end
    |> maybe_end
  end

  @doc """
    Returns the score of a given game of bowling if the game is complete.
    If the game isn't complete, it returns a helpful message.
  """

  @spec score(any) :: integer | String.t()

  def score(game = %{ended: true}) do
    1..game.current_frame
    |> Enum.reduce(0, fn frame, sum -> sum + score_frame(game, frame) end)
  end

  def score(_), do: {:error, "Score cannot be taken until the end of the game"}

  defp maybe_end(game) do
    if ended?(game), do: Map.put(game, :ended, true), else: game
  end

  defp ended?(%{current_frame: @end_frame}), do: true
  defp ended?(%{frames: %{@last_frame => [@max_pins], @bonus_frame => [_x, _y]}}), do: true
  defp ended?(%{frames: %{@last_frame => [@max_pins], @bonus_frame => _}}), do: false
  defp ended?(%{current_frame: @bonus_frame}), do: true
  defp ended?(%{frames: %{@last_frame => [x, y]}}) when x + y == @max_pins, do: false
  defp ended?(%{frames: %{@last_frame => [_]}}), do: false
  defp ended?(%{frames: %{@last_frame => _}}), do: true
  defp ended?(_), do: false

  defp score_frame(game, frame) when frame >= @last_frame do
    Map.get(game.frames, frame) |> Enum.sum()
  end

  defp score_frame(game, frame) do
    case Map.get(game.frames, frame) do
      [@max_pins] -> @max_pins + score_next_two_rolls(game, frame)
      [x, y] when x + y == @max_pins -> @max_pins + score_next_roll(game, frame)
      [x, y] -> x + y
    end
  end

  defp score_next_roll(game, frame) do
    game.frames |> Map.get(frame + 1) |> hd()
  end

  def score_next_two_rolls(game, frame) do
    case frame_rolls = Map.get(game.frames, frame + 1) do
      [@max_pins] -> @max_pins + score_next_roll(game, frame + 1)
      _ -> Enum.sum(frame_rolls)
    end
  end
end
