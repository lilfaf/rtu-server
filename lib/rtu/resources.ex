defmodule Rtu.Track do
  defstruct title:     nil,
            artist:    nil,
            metadatas: []
end

defmodule Rtu.Metadata do
  defstruct cover:    nil,
            link:     nil,
            provider: nil
end

defimpl String.Chars, for: Rtu.Track do
  def to_string(track), do: "#{track.title} - #{track.artist}"
end
