# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_with_token!, except: %i[create]
      before_action :find_user, except: %i[index create]
      before_action :admin, only: %i[index]
      before_action :ownership?, except: %i[create]

      def index
        @users = User.all
        render json: @users, status: :ok
      end

      # POST /api/v1/auth/register
      def create
        @user = User.new(user_params)
        @user.role = Role.find_or_create_by!(name: 'user', description: 'usuario de la aplicacion')
        @user.save!
        # token = JsonWebToken.encode(user_id: @user.id)
        @options = { meta: { jwt: JsonWebToken.encode(user_id: @user.id) } }
        UserWelcome.with(user: @user).send_user_welcome.deliver_later
        # render json: { serialize_user: serialize_user, token: token }, status: :created
        render json: serialize_user(@user, @options), status: :created
      end

      def update
        @user.update!(user_params)
        render json: serialize_user, status: :ok
      end

      def destroy
        @user.discard!

        head :no_content
      end

      private

      def find_user        
        @user = User.find(params[:id])
      end

      # def serialize_user
      #   UserSerializer.new(@user).serializable_hash.to_json
      # end

      def serialize_user(*args)
        UserSerializer.new(*args).serializable_hash.to_json
      end

      def user_params
        params.require(:user).permit(:email, :password, :first_name, :last_name)
      end
    end
  end
end
