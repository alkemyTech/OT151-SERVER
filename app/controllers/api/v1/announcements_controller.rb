# frozen_string_literal: true

module Api
  module V1
    class AnnouncementsController < ApplicationController
      before_action :sauthenticate_with_token!, only: %i[update]
      before_action :admin?, only: %i[update]
      before_action :set_announcement, only: %i[update]
      def update
        @announcement.update!(announcement_params)
        render json: serialize_announcement, status: :ok
      end

      private

      def serialize_announcement
        AnnouncementSerializer.new(@announcement).serializable_hash.to_json
      end

      def set_announcement
        @announcement = Announcement.find_by!(id: params[:id])
      end

      def announcement_params
        params.require(:announcement).permit(:content, :name, :category_id)
      end
    end
  end
end
