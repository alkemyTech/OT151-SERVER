# frozen_string_literal: true

module Api
  module V1
    class AuthController < ApplicationController
      before_action :authenticate_with_token!, only: [:show]

      # POST api/v1/auth/login
      def create
        @user = User.find_by!(email: user_params[:email])
        if @user&.authenticate(user_params[:password])
          render json: {
            token: JsonWebToken.encode(user_id: @user.id),
            user: serialize_user(@user)
          }, status: :created
        else
          head :unauthorized
        end
      end

      # GET api/v1/auth/me
      def show
        user = @current_user
        render json: serialize_user(user), status: :ok
      end

      private

      def user_params
        params.permit(:email, :password)
      end

      def serialize_user(*args)
        UserSerializer.new(*args).serializable_hash.to_json
      end
    end
  end
end
