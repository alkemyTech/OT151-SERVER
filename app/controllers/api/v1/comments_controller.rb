# frozen_string_literal: true

module Api
  module V1
    class CommentsController < ApplicationController
      before_action :authenticate_with_token!, only: %i[create]
      before_action :find_announcement, only: %i[create]

      def create
        @comment = Comment.create!(comment_params)
        render json: @comment.to_json, status: :created
      end

      private

      def comment_params
        params.require(:comment).permit(:body).merge(user_id: @current_user.id,
                                                     announcement_id: @announcement.id)
      end

      def find_announcement
        @announcement = Announcement.find(params[:announcement_id])
      end
    end
  end
end
