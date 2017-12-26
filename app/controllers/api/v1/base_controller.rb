module Api
  module V1
    class BaseController < ApplicationController
      include Swagger::Docs::ImpotentMethods

      class << self
        Swagger::Docs::Generator::set_real_methods

        def inherited(subclass)
          super
          subclass.class_eval do
            setup_base_api_actions
          end
        end

        private
        def setup_base_api_actions
          [:index, :show, :create, :update, :delete].each do |action|
            swagger_api action do
              param :header, 'Accept', :string, :optional, 'application/vnd.course-management.v1'
              param :header, 'Content-Type', :string, :optional, Mime[:json].to_s

              response :not_acceptable, "This request is not acceptable"
            end
          end
        end
      end
    end
  end
end
