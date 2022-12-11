class QuantityConverter
  UNIT_TO_GRAMS = {
    'cup' => 500,
    'teaspoons' => 5,
    'gram' => 1,
    'kilogram' => 1000
  }

  def initialize(quantity)
    @quantity = quantity
  end

  def time_converter
    calc_time = 0
    if @quantity.include?('hours')
      split_time_arr = @quantity.split(' hours ')
      calc_time += (split_time_arr[0].to_i * 60)
      split_time_arr[1].slice!(' mins').slice!(' min')
      calc_time + split_time_arr[1].to_i
    elsif @quantity.include?('hour')
      split_time_arr = @quantity.split(' hour ')
      calc_time += (split_time_arr[0].to_i * 60)
      split_time_arr[1].slice!(' mins').slice!(' min')
      calc_time + split_time_arr[1].to_i
    else
      @quantity.slice!(' mins').slice!(' min')
      calc_time + @quantity.to_i
    end
  end

  def weight_converter(from_unit, to_unit)
    return "Unknown #{to_unit}" unless Ingredient.units.keys.include?(to_unit)

    @quantity * UNIT_TO_GRAMS[from_unit] / UNIT_TO_GRAMS[to_unit]
  end
end
