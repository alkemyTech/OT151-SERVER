# frozen_string_literal: true

module Api
  module V1
    class AuthController < ApplicationController
      before_action :authenticate_with_token!, only: [:show]
      before_action :login_params, only: [:create]
      before_action :user, only: [:create]

      # POST api/v1/auth/login
      def create
        raise AuthenticationError unless auth_user

        @options = { meta: { jwt: JsonWebToken.encode(user_id: @user.id) } }
        render json: serialize_user(@user, @options), status: :created
      end

      # GET api/v1/auth/me
      def show
        if @current_user
          render json: serialize_user(@current_user), status: :ok
        else
          render json: { ok: false }
        end
      end

      private

      def auth_user
        @user.authenticate(params[:password])
      end

      def login_params
        params.require(%i[email password])
      end

      def user
        @user = User.find_by!(email: params.require(:email))
      end

      def serialize_user(*args)
        UserSerializer.new(*args).serializable_hash.to_json
      end
    end
  end
end
