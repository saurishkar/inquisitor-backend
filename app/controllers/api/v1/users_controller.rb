# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      skip_before_action :verify_authenticity_token, only: [:token, :create]

      def token
        @user = User.authenticate(params[:email], params[:password])
        if @user.nil?
          render json: { errors: 'Invalid Api Key' }, status: 401
        else
          render json: @user, serializer: UserLoginSerializer
        end
      end

      def create
        @user = User.new(permit_params)
        if User.already_exists?(params[:email])
          render json: { errors: 'Email already exists' }, status: 422
        elsif @user.save
          render json: @user, serializer: UserLoginSerializer
        else
          render json: { errors: 'Error' }, status: 422
        end
      end

      private

      def permit_params
        params.require(:user).permit(
          :email, :password, :password_confirmation, :firstname, :lastname
        )
      end
    end
  end
end
