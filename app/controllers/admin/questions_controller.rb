# frozen_string_literal: true

module Admin
  class QuestionsController < ApplicationController
    # before_action :authenticate, only: %i[create]

    def index
      @questions = Question.all.select { |q| q.user_id == params[:user_id] }
    end

    def index_all
      @questions = Question.all
    end

    def create
      @question = Question.new(permit_params)
      redirect_to admin_user_question_path id: @question.id if @question.save
    end

    def show
      @question = Question.find(params[:id])
    end

    def edit
      @question = Question.find(params[:id])
    end

    def update
      @question = Question.find(params[:id])
      @question.update(permit_params)
      redirect_to admin_question_path id: @question.id
    end

    private

    def permit_params
      params.require(:question).permit(:title, :description, :user_id)
    end
  end
end
