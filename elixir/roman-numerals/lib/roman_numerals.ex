defmodule RomanNumerals do
  @int_to_roman_numeral_map %{
    1 => "I",
    5 => "V",
    10 => "X",
    50 => "L",
    100 => "C",
    500 => "D",
    1000 => "M"
  }

  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    number
    |> split_integer()
    |> multiply_by_ten_power()
    |> Enum.reject(fn int -> int == 0 end)
    |> Enum.map(&get_combined_numbers/1)
    |> List.flatten()
    |> Enum.map(&Map.get(@int_to_roman_numeral_map, &1, ""))
    |> Enum.join()
  end

  defp split_integer(int) do
    int
    |> Kernel.to_string()
    |> String.split("", trim: true)
    |> Enum.map(fn int_string ->
      Integer.parse(int_string)
      |> case do
        {int, _} ->
          int

        _ ->
          0
      end
    end)
  end

  defp multiply_by_ten_power(int_list) do
    int_list
    |> Enum.with_index(1)
    |> Enum.map(fn {int, index} ->
      ten_factor = :math.pow(10, length(int_list) - index) |> :erlang.floor()

      int * ten_factor
    end)
  end

  defp get_combined_numbers(int, acc \\ {[], 0}) do
    is_negative? = int < 0
    abs_int = :erlang.abs(int)
    number_pool = Map.keys(@int_to_roman_numeral_map)
    {acc_list, last_index_inserted} = acc
    {difference, closest_int} = get_difference_and_closest_int(abs_int, number_pool)

    index_to_insert =
      if is_negative? do
        last_index_inserted - 1
      else
        last_index_inserted + 1
      end

    acc_list = List.insert_at(acc_list, index_to_insert, closest_int)

    if difference == 0 do
      acc_list
    else
      get_combined_numbers(difference, {acc_list, index_to_insert})
    end
  end

  defp get_difference_and_closest_int(abs_int, number_pool) do
    number_pool_with_differences =
      number_pool
      |> Enum.map(fn int_to_compare ->
        {abs_int - int_to_compare, int_to_compare}
      end)

    {{difference, closest_int}, index} =
      number_pool_with_differences
      |> Enum.with_index()
      |> Enum.min_by(fn {{difference, _int_to_compare}, _index} ->
        :erlang.abs(difference)
      end)

    cond do
      difference == 0 ->
        {difference, closest_int}

      difference > 0 ->
        {difference, closest_int}

      difference < 0 ->
        # 85 => LXXXV
        # 85 => ... ___{35, 50}___, {-15, 100} ...
        #
        # 90 => XVC
        # 90 => ... {40, 50}, ___{-10, 100}___ ...
        abs_difference = :erlang.abs(difference)

        exact_match = Enum.find(number_pool, fn number -> number == abs_difference end)

        if not is_nil(exact_match) do
          {difference, closest_int}
        else
          Enum.at(number_pool_with_differences, index - 1)
        end
    end
  end
end
