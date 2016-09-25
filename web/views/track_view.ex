defmodule Rtu.TrackView do
  use Rtu.Web, :view

  def render("current.json", %{track: track}) do
    track
  end
end
