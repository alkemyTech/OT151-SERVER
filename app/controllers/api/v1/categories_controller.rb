# frozen_string_literal: true

module Api
  module V1
    class CategoriesController < ApplicationController
      def destroy
        if @category.present?
          render json: { errors: @category.errors.full_messages }
        else
          @category.destroy
          render json: {}, status: :no_content
        end
      end
    end
  end
end
