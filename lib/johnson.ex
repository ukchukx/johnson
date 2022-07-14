defmodule Johnson do
  @moduledoc """
  Module to encode and decode JSON while preserving the key orders.
  """

  @count_key :kc

  defstruct data: []

  @type t :: %__MODULE__{data: keyword()}

  @doc """
  Decode a JSON string, while preserving the original key order.

  ## Examples

      iex> Johnson.decode!(~s({"a":"a","b":"b"}))
      %Johnson{data: [{"a", "a"}, {"b", "b"}]}
  """
  @spec decode!(binary()) :: t()
  def decode!(string) when is_bitstring(string) do
    Process.put(@count_key, 0)

    string
    |> Jason.decode!(
      keys: fn key ->
        @count_key
        |> Process.get()
        |> (& Process.put(@count_key, &1 + 1)).()
        |> (& {&1, key}).()
      end
    )
    |> new()
  end

  @doc """
  Transform a struct back to a JSON string.

  ## Examples

      iex> Johnson.encode!(%Johnson{data: [{"a", "a"}, {"b", "b"}]})
      ~s({"a":"a","b":"b"})
  """
  @spec encode!(t()) :: binary()
  def encode!(%__MODULE__{} = j), do: Jason.encode!(j)

  @doc """
  Get field.

  ## Examples

      iex> Johnson.get(%Johnson{data: [{"a", "a"}, {"b", "b"}]}, "a")
      "a"
  """
  @spec get(t(), binary()) :: any()
  def get(%__MODULE__{data: data}, key) when is_binary(key) do
    data
    |> List.keyfind(key, 0)
    |> case do
      {_, value} -> value
      x -> x
    end
  end

  defp new(conf) when is_map(conf) do
    data =
      conf
      |> Map.to_list()
      |> Enum.sort_by(fn {{idx, _}, _} -> idx end)
      |> Enum.map(fn {{_, k}, v} -> {k, new(v)} end)

    %__MODULE__{data: data}
  end

  defp new(list) when is_list(list), do: Enum.map(list, &new/1)

  defp new(value), do: value
end

defimpl Jason.Encoder, for: Johnson do
  def encode(%{data: value}, opts), do: Jason.Encode.keyword(value, opts)
end
