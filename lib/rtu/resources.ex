defmodule Rtu.Track do
  defstruct title:  nil,
            artist: nil
end

defimpl String.Chars, for: Rtu.Track do
  def to_string(track), do: "#{track.title} - #{track.artist}"
end
