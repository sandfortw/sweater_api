class SalaryFacade 

  def initialize(city_string)
    @city_string = city_string
  end

  def salaries
    forecast = ForecastFacade.new(@city_string).forecast
    salary =  SalaryService.new(@city_string).get_salaries
    forecast.merge(salary)
  end
end