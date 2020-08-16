defmodule BinarySearch do
  @doc """
    Searches for a key in the tuple using the binary search algorithm.
    It returns :not_found if the key is not in the tuple.
    Otherwise returns {:ok, index}.

    ## Examples

      iex> BinarySearch.search({}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 2)
      :not_found

      iex> BinarySearch.search({1, 3, 5}, 5)
      {:ok, 2}

  """

  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search({}, _key), do: :not_found
  def search(numbers, key), do: search(numbers, key, 0, tuple_size(numbers) - 1)
  def search(numbers, key, index, index) when elem(numbers, index) == key, do: {:ok, index}
  def search(numbers, key, index, index), do: :not_found

  def search(numbers, key, first, last) do
    middle = div(first + last, 2)
    middle_value = elem(numbers, middle)

    cond do
      middle_value > key -> search(numbers, key, first, middle)
      middle_value == key -> {:ok, middle}
      middle_value < key -> search(numbers, key, middle + 1, last)
    end
  end
end
