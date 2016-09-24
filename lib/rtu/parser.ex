defmodule Rtu.Parser do
  require Logger

  def parse(%{data: [], total: 0}), do: nil

  def parse(%{data: _data}) do
    Logger.debug("Parsing Deezer data")
  end

  def parse(%{collection: [], total_results: 0}), do: nil

  def parse(%{collection: _data}) do
    Logger.debug("Parsing Soundcloud data")
  end

  def parse(%{items: [], pageInfo: %{totalResults: 0}}), do: nil

  def parse(%{items: _data}) do
    Logger.debug("Parsing Youtube data")
  end
end
