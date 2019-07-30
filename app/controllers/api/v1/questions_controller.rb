# frozen_string_literal: true

module Api
  module V1
    class QuestionsController < ApplicationController
      before_action authorize, only: %i[create]

      def index
        render json: Question.all
      end

      def show
        render json: Question.find(permit_params)
      end

      def create
        @question = Question.new(permit_params)
        @question.user_id = @user.id
        redirect_to admin_question_path id: @question.id if @question.save
      end

      private

      def permit_params
        params.require(:question).permit(:id, :title, :description)
      end

      def authorize
        user = User.find_by(api_key: params[:api_key])
        if user.nil?
          render json: { errors: 'Invalid Api Key' }, status: 401
        else
          @user = user
        end
      end
    end
  end
end
