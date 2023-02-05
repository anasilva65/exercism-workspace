defmodule Lasagna do
  @time_default 40
  @layer_time 2

  @doc """
  Shows the expected minutes for lasagna
  ## Examples
     iex> Lasagna.expected_minutes_in_oven()
     40
  """
  @spec expected_minutes_in_oven :: integer()
  def expected_minutes_in_oven(), do: @time_default

  @doc """
  Shows the expected minutes for lasagna
  ## Examples
  iex> Lasagna.remaining_minutes_in_oven(10)
  30
  iex> Lasagna.remaining_minutes_in_oven(30)
  10
  """
  @spec remaining_minutes_in_oven(integer()) :: integer()
  def remaining_minutes_in_oven(minutes), do: @time_default - minutes

  @doc """
  Shows the expected minutes for lasagna by layers
  ## Examples
  iex> Lasagna.preparation_time_in_minutes(4)
  8
  iex> Lasagna.preparation_time_in_minutes(3)
  6
  """
  @spec preparation_time_in_minutes(integer()) :: integer()
  def preparation_time_in_minutes(layers), do: @layer_time * layers

  @doc """
  Shows the total minutes for lasagna preparation
  ## Examples
  iex> Lasagna.total_time_in_minutes(3, 3)
  9
  iex> Lasagna.total_time_in_minutes(8, 2)
  18
  """
  @spec total_time_in_minutes(integer(), integer()) :: integer()
  def total_time_in_minutes(number_of_layers, minutes) do
    preparation_time_in_minutes(number_of_layers) + minutes
  end

  @doc """
  Signal that lasagna is over
  ## Example
  iex> Lasagna.alarm()
  "Ding!"
  """
  @spec alarm() :: String.t()
  def alarm(), do: "Ding!"
end
