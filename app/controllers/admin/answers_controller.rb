# frozen_string_literal: true

module Admin
  class AnswersController < ApplicationController
    def index_all
      @answers = Answer.all
    end

    def index
      @answers = Answer.all
    end

    def show
      @answer = Answer.find(params[:id])
    end

    def create
      @answer = Answer.new(permit_params)
      @answer.user_id = params[:user_id]
      @answer.question_id = params[:question_id]
      return redirect_to admin_answers_path if @answer.save

      render action: 'new'
    end

    def update; end

    def destroy; end

    private

    def permit_params
      params.require(:answer).permit(:description, :user_id, :question_id)
    end
  end
end
