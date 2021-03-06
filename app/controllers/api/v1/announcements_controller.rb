# frozen_string_literal: true

module Api
  module V1
    class AnnouncementsController < ApplicationController
      before_action :authenticate_with_token!, only: %i[create update]
      before_action :admin, only: %i[create]
      before_action :set_announcement, only: %i[show update]

      def show
        render json: serialize_announcement, status: :ok
      end

      def create
        @announcement = Announcement.new(announcement_params)
        @announcement.announcement_type = 'news'
        @announcement.upload_image(params[:announcement][:image])
        @announcement.save!
        render json: serialize_announcement, status: :created
      end

      def update
        @announcement.update!(announcement_params)
        render json: serialize_announcement, status: :ok
      end

      private

      def set_announcement
        @announcement = Announcement.find(params[:id])
      end

      def serialize_announcement
        AnnouncementSerializer.new(@announcement).serializable_hash.to_json
      end

      def announcement_params
        params.require(:announcement).permit(:content, :name, :category_id)
      end
    end
  end
end
