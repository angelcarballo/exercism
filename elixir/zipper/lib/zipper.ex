defmodule Zipper do
  @type trail :: [{:left, any, BinTree.t()} | {:right, any, BinTree.t()}]
  @type t :: %Zipper{trail: trail(), value: any, left: BinTree.t(), right: BinTree.t()}

  defstruct [:trail, :value, :left, :right]

  @doc """
  Get a zipper focused on the root node.
  """
  @spec from_tree(BinTree.t()) :: Zipper.t()
  def from_tree(bin_tree) do
    %Zipper{trail: [], value: bin_tree.value, left: bin_tree.left, right: bin_tree.right}
  end

  @doc """
  Get the complete tree from a zipper.
  """
  @spec to_tree(Zipper.t()) :: BinTree.t()
  def to_tree(%Zipper{trail: []} = zipper),
    do: %BinTree{value: zipper.value, left: zipper.left, right: zipper.right}

  def to_tree(zipper), do: zipper |> up() |> to_tree()

  @doc """
  Get the value of the focus node.
  """
  @spec value(Zipper.t()) :: any
  def value(%Zipper{value: value}), do: value

  @doc """
  Get the left child of the focus node, if any.
  """
  @spec left(Zipper.t()) :: Zipper.t() | nil
  def left(%Zipper{left: nil}), do: nil

  def left(%Zipper{trail: trail, value: value, left: left, right: right}) do
    %Zipper{
      trail: [{:left, value, right} | trail],
      value: left.value,
      left: left.left,
      right: left.right
    }
  end

  @doc """
  Get the right child of the focus node, if any.
  """
  @spec right(Zipper.t()) :: Zipper.t() | nil
  def right(%Zipper{right: nil}), do: nil

  def right(%Zipper{trail: trail, value: value, left: left, right: right}) do
    %Zipper{
      trail: [{:right, value, left} | trail],
      value: right.value,
      left: right.left,
      right: right.right
    }
  end

  @doc """
  Get the parent of the focus node, if any.
  """
  @spec up(Zipper.t()) :: Zipper.t() | nil
  def up(%Zipper{trail: []}), do: nil

  def up(%Zipper{
        trail: [{:left, parent_value, other_branch} | trail],
        value: value,
        left: left,
        right: right
      }) do
    %Zipper{
      trail: trail,
      value: parent_value,
      left: %BinTree{value: value, left: left, right: right},
      right: other_branch
    }
  end

  def up(%Zipper{
        trail: [{:right, parent_value, other_branch} | trail],
        value: value,
        left: left,
        right: right
      }) do
    %Zipper{
      trail: trail,
      value: parent_value,
      left: other_branch,
      right: %BinTree{value: value, left: left, right: right}
    }
  end

  @doc """
  Set the value of the focus node.
  """
  @spec set_value(Zipper.t(), any) :: Zipper.t()
  def set_value(zipper, value), do: %{zipper | value: value}

  @doc """
  Replace the left child tree of the focus node.
  """
  @spec set_left(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_left(zipper, left), do: %{zipper | left: left}

  @doc """
  Replace the right child tree of the focus node.
  """
  @spec set_right(Zipper.t(), BinTree.t() | nil) :: Zipper.t()
  def set_right(zipper, right), do: %{zipper | right: right}
end
