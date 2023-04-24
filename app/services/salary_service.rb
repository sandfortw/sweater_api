class SalaryService

  def initialize(info)
    @info = info
  end

  def get_salaries
    response = conn.get do |req|
      req.url "slug:#{@info}/salaries"
    end
    json = JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new(url: "https://api.teleport.org/api/urban_areas/")
  end
end