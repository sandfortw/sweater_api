
module Api
  module V1
    class SalariesController < ApplicationController
      def show
        salaries = SalaryFacade.new(params[:destination]).salaries
        render json: SalarySerializer.new(salaries).serializable_hash
      rescue
        render json: { error: 'Bad Request' }, status: :bad_request
      end
    end
  end
end