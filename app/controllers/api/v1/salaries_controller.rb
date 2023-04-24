
module Api
  module V1
    class SalariesController < ApplicationController
      def show
        salaries = SalaryFacade.new(params[:destination]).salaries
        render json: SalarySerializer.new(salaries).serializable_hash
      end
    end
  end
end