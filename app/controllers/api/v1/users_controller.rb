# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :authenticate_with_token!, only: %i[update destroy]
      before_action :authorize_request, except: %i[create destroy]
      before_action :find_user, except: %i[create destroy]
      before_action :admin, only: %i[index]

      def index
        @users = User.all
        render json: @users, status: :ok
      end

      def create
        @user = User.new(user_params)
        @user.role = Role.create_or_find_by(name: 'user', description: 'usuario de la aplicacion')
        if @user.save
          render json: @user, status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def update
        if @user.update!(user_params)
          render json: UserSerializer.new(@user).serializable_hash.to_json
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        if @user.discarded?
          render json: { errors: @user.errors.full_messages }
        else
          @user.discard
          render json: { message: 'User deleted' }, status: :no_content
        end
      end

      private

      def find_user
        @user = User.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { errors: 'User not found' }, status: :not_found
      end

      def user_params
        params.require(:user).permit(:email, :password, :first_name, :last_name)
      end
    end
  end
end
