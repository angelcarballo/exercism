defmodule ExampleTest do
  use ExUnit.Case
  doctest Example

  test "sets and gets" do
    Example.start_link()
    Example.put(:foo, "foo")
    assert Example.get(:foo) == "foo"
    Example.put(:foo, "bar")
    assert Example.get(:foo) == "bar"
  end
end
