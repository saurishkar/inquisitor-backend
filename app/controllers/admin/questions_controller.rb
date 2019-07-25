# frozen_string_literal: true

module Admin
  class QuestionsController < ApplicationController
    def index
      @questions = Question.all
    end

    def create
      @question = Question.new(permit_params)
      redirect_to admin_question_path id: @question.id if @question.save
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
      params.require(:question).permit(:title, :description)
    end
  end
end
