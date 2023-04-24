require_relative '../helpers/application_helper'

class SalarySerializer
  include JSONAPI::Serializer

  set_id { nil }
  set_type :salaries

  attribute :destination do |object|
    object[:location][:name]
  end

  attribute :forecast do |object|
    {
      summary: object[:current][:condition][:text],
      temperature: "#{object[:current][:temp_f].to_i} F"
    }
  end

  attribute :salaries do |object|
    object[:salaries].map do |salary|
      {
        title: salary[:job][:title],
          min: ApplicationHelper.format_dollars(salary[:salary_percentiles][:percentile_25]),
          max: ApplicationHelper.format_dollars(salary[:salary_percentiles][:percentile_75]),
      }
    end
  end
end