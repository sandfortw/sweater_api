module ApplicationHelper
  def self.format_dollars(float)
    formatted_string = format('%.2f', float)
    split_decimal = formatted_string.split(".")
    int_with_commas = split_decimal[0].reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
    "$#{int_with_commas}.#{split_decimal[1]}"
  end
end