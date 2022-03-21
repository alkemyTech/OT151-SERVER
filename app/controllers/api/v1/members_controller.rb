# frozen_string_literal: true

module Api
  module V1
    class MembersController < ApplicationController
      before_action :authenticate_with_token!, only: %i[create]


      def index
        @members = Member.kept.page(params[:page])
        @options = get_links_serializer_options('api_v1_members_path', @members)
        render json: serialize_members(@members, @options), status: :ok
      end

      def create
        @member = Member.new(member_params)
        @member.upload_image(params[:member][:image])
        @member.save!
        render json: serialize_members(@member), status: :created
      end
      private

      def member_params
        params.require(:member).permit(:name, :description, :facebook_url, :instagram_url, :linkedin_url)
      end
      def serialize_members(*args)
        MembersSerializer.new(*args).serializable_hash.to_json
      end
    end
  end
end
