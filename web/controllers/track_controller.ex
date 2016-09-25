defmodule Rtu.TrackController do
  use Rtu.Web, :controller
  alias Rtu.CurrentTrack

  def current(conn, _params) do
    render conn, track: CurrentTrack.get
  end
end
