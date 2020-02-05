defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count([]), do: 0
  def count([_h|t]), do: 1 + count(t)

  @spec reverse(list) :: list
  def reverse(l), do: reduce(l, [], fn x, acc -> [x | acc] end)

  @spec map(list, (any -> any)) :: list
  def map([], _f), do: []
  def map([h|t], f), do: [f.(h) | map(t,f)]

  @spec filter(list, (any -> as_boolean(term))) :: list
  def filter([], _f), do: []
  def filter([h|t], f) do
    if f.(h), do: [h | filter(t,f)], else: filter(t,f)
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _f), do: acc
  def reduce([h|t], acc, f), do: reduce(t, f.(h,acc), f)

  @spec append(list, list) :: list
  def append([], b), do: b
  def append([h|t], b), do: [h | append(t,b)]

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([h|t]), do: append(h, concat(t))
end
