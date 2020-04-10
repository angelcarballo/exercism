defmodule MatchingBrackets do
  @pairs %{"[" => "]", "{" => "}", "(" => ")"}
  @openers Map.keys(@pairs)
  @closers Map.values(@pairs)

  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(string) do
    check_brackets(String.codepoints(string), [])
  end

  def check_brackets([], []), do: true
  def check_brackets([], _pending), do: false

  def check_brackets([opener | chars], pending) when opener in @openers,
    do: check_brackets(chars, [Map.get(@pairs, opener) | pending])

  def check_brackets([closer | chars], [closer | pending]) when closer in @closers,
    do: check_brackets(chars, pending)

  def check_brackets([closer | _chars], _pending) when closer in @closers, do: false
  def check_brackets([_char | chars], pending), do: check_brackets(chars, pending)
end
