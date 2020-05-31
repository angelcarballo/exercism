defmodule Result do
  defstruct [:home, :visitor, :result]

  def parse(result_line) do
    if result_line =~ ~r/\A.+;.+;(loss|win|draw)\z/ do
      [home, visitor, result] = String.split(result_line, ";")
      %Result{home: home, visitor: visitor, result: result}
    else
      nil
    end
  end
end

defmodule TeamStats do
  defstruct [played: 0, won: 0, drawn: 0, lost: 0, points: 0]

  def process_home_result(stats, result), do: process_result(stats, result)
  def process_visitor_result(stats, "win"), do: process_result(stats, "loss")
  def process_visitor_result(stats, "loss"), do: process_result(stats, "win")
  def process_visitor_result(stats, "draw"), do: process_result(stats, "draw")

  def process_result(stats, "win"),
    do: %{stats | played: stats.played + 1, won: stats.won + 1, points: stats.points + 3}
  def process_result(stats, "draw"),
    do: %{stats | played: stats.played + 1, drawn: stats.drawn + 1, points: stats.points + 1}
  def process_result(stats, "loss"),
    do: %{stats | played: stats.played + 1, lost: stats.lost + 1}
end

defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
    lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    team_stats =
      input
      |> Enum.map(&Result.parse/1)
      |> Enum.filter(&(&1 != nil))
      |> Enum.reduce(%{}, fn result, teams ->
        teams
        |> init_stats(result.home)
        |> Map.update!(result.home, &(TeamStats.process_home_result(&1, result.result)))
        |> init_stats(result.visitor)
        |> Map.update!(result.visitor, &(TeamStats.process_visitor_result(&1, result.result)))
      end)
      |> Enum.sort_by(fn {_team, stats} ->  -stats.points end)
      |> Enum.map(&format_team_stats/1)
      |> Enum.join("\n")

    stats_header() <> "\n" <> team_stats
  end

  def init_stats(teams, team_name) do
    if Map.has_key?(teams, team_name) do
      teams
    else
      Map.put(teams, team_name, %TeamStats{})
    end
  end

  def stats_header(), do: "Team                           | MP |  W |  D |  L |  P"

  def format_team_stats({team, %TeamStats{} = stats}) do
    [
      String.pad_trailing(team, 30),
      String.pad_leading(to_string(stats.played), 2),
      String.pad_leading(to_string(stats.won), 2),
      String.pad_leading(to_string(stats.drawn), 2),
      String.pad_leading(to_string(stats.lost), 2),
      String.pad_leading(to_string(stats.points), 2)
    ] |> Enum.join(" | ")
  end
end

