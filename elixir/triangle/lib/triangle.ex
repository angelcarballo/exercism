defmodule Triangle do
  @type kind :: :equilateral | :isosceles | :scalene

  defguard positive_number(n) when is_number(n) and n > 0

  defguard all_positive(a, b, c)
           when positive_number(a) and positive_number(b) and positive_number(c)

  defguard can_form_triangle(a, b, c) when a + b > c and b + c > a and a + c > b

  defguard is_triangle(a, b, c) when all_positive(a, b, c) and can_form_triangle(a, b, c)

  defguard two_equal(a, b, c) when a == b or a == c or b == c

  @doc """
  Return the kind of triangle of a triangle with 'a', 'b' and 'c' as lengths.
  """
  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, a, a) when is_triangle(a, a, a), do: {:ok, :equilateral}
  def kind(a, b, c) when is_triangle(a, b, c) and two_equal(a, b, c), do: {:ok, :isosceles}
  def kind(a, b, c) when is_triangle(a, b, c), do: {:ok, :scalene}

  def kind(a, b, c) when not all_positive(a, b, c),
    do: {:error, "all side lengths must be positive"}

  def kind(a, b, c) when not can_form_triangle(a, b, c),
    do: {:error, "side lengths violate triangle inequality"}
end
