module Admin
  class AnswersController < ApplicationController
    def index
      @answers = Answer.all
    end

    def show
      @answer = Answer.find(params[:id])
    end

    def create
    end

    def update
    end

    def destroy
    end
  end
end
