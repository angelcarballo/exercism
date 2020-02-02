defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  @dice_sides 6
  @lots 4

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @spec modifier(pos_integer()) :: integer()
  def modifier(score) do
    (score - 10) / 2.0
    |> Float.floor
    |> Kernel.trunc
  end

  @spec ability :: pos_integer()
  def ability do
    1..@lots
    |> Enum.map(fn _x -> roll_dice() end)
    |> Enum.sort
    |> Enum.take(-3)
    |> Enum.sum
  end

  @spec character :: t()
  def character do
    constitution = ability()
    %{
      strength: ability(),
      dexterity: ability(),
      constitution: constitution,
      intelligence: ability(),
      wisdom: ability(),
      charisma: ability(),
      hitpoints: (10 + modifier(constitution)),
    }
  end

  defp roll_dice do
    Enum.random(1..@dice_sides)
  end
end
