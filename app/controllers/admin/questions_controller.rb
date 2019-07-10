module Admin
  class QuestionsController < ApplicationController
    def index
      @questions = Question.all
    end

    def create
      @question = Question.new(permit_params)
      @question.save
      redirect_to @question
    end

    def show
      @question = Question.find(params[:id])
    end

    def edit
      @question = Question.find(params[:id])
    end

    def update
      @question = Question.find(params[:id])
      @question.update
      redirect_to @question
    end

    private

    def permit_params
      params.require(:question).permit(:title, :description)
    end
  end
end