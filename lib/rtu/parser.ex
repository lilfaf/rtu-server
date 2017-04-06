defmodule Rtu.Parser do
  require Logger

  alias Rtu.Metadata

  def parse(%{data: [], total: 0}), do: nil

  def parse(%{data: data}) do
    Logger.info("Parsing Deezer data...")
    data
    |> List.first
    |> map_to_struct(:deezer)
  end

  def parse(%{collection: [], total_results: 0}), do: nil

  def parse(%{collection: data}) do
    Logger.info("Parsing Soundcloud data...")
    data
    |> Enum.reject(fn(item) -> empty_artwork_url(item) end)
    |> List.first
    |> map_to_struct(:soundcloud)
  end

  def parse(%{items: [], pageInfo: %{totalResults: 0}}), do: nil

  def parse(%{items: data}) do
    Logger.info("Parsing Youtube data...")
    data
    |> List.first
    |> map_to_struct(:youtube)
  end

  defp empty_artwork_url(item) do
    !Map.has_key?(item, :artwork_url) || item.artwork_url == nil
  end

  defp map_to_struct(data, :deezer) do
    %Metadata{
      cover:    data.album.cover_big,
      link:     data.link,
      provider: "deezer"
    }
  end

  defp map_to_struct(nil, :soundcloud), do: nil

  defp map_to_struct(data, :soundcloud) do
    %Metadata{
      cover:    String.replace(data.artwork_url, "large", "t500x500"),
      link:     data.permalink_url,
      provider: "soundcloud"
    }
  end

  defp map_to_struct(data, :youtube) do
    %Metadata{
      cover:    data.snippet.thumbnails.medium.url,
      link:     "https://www.youtube.com/watch?v=#{data.id.videoId}",
      provider: "youtube"
    }
  end
end
