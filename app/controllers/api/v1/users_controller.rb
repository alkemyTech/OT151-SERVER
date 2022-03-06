# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      def create
        @user = User.new(user_params)
        @user.role = Role.find_or_create_by!(name: 'invitado', description: 'invitado')
        @user.save!
        render json: serialize_user, status: :created
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :first_name, :last_name)
      end

      def serialize_user
        UserSerializer.new(@user).serializable_hash.to_json
      end
    end
  end
end
