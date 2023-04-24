module ApplicationHelper
  def self.format_dollars(float)
    formatted_string = format('%.2f', float)
    split_decimal = formatted_string.split(".")
    
  end
end