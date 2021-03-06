# frozen_string_literal: true

require 'json'
module Admin
  class UsersController < ApplicationController
    include UsersHelper
    include Api

    def new
      @user = User.new
    end

    def index
      @users = User.all
    end

    def show
      redirect_to edit_admin_user_path
    end

    def create
      @user = User.new(permit_params)
      if @user.save
        redirect_to edit_admin_user_path(@user)
      else
        render 'new'
      end
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update(permit_params)
        set_user_session if @user.id == session[:current_user]
        redirect_to edit_admin_user_path(@user), notice: 'Your details have been successfully updated'
      else
        render 'edit'
      end
    end

    def logout
      reset_user_session if params[:user_id] == session[:current_user].to_s
      redirect_to admin_login_path
    end

    def login
      if User.authenticate(permit_params[:email], permit_params[:password])
        @user = User.find_by_email(permit_params[:email])
        set_user_session
        redirect_to admin_questions_path
      else
        redirect_to admin_login_path, notice: 'Invalid Email or password'
      end
    end

    def forgot_password
      # render 'forgot_password'
    end

    def send_reset_password_mail
      user_email = permit_params[:email]
      url = URI(Rails.application.secrets.pepipost_url)
      pp_api_key = Rails.application.secrets.pepipost_api_key
      mail_body = MAILER_TEMPLATES[:reset_password][:body].merge(
        personalizations: [{ recipient: user_email }],
        content: 'Click on the below link to reset your password '
      )
      config = {
        'content-type' => 'application/json',
        'api_key' => pp_api_key,
        'body' => mail_body.to_json
      }
      # render plain: 'Reset password link has been sent to your email'

      response = ApiService.post(url, config)
      status_code = response.code.to_i
      if [200, 202].includes? status_code
        redirect_to :forgot_password,
                    alert: 'Reset password link has been sent to your email'
      else
        flash.now[:alert] = 'FAILED'
        render 'forgot_password'
      end
    end

    private

    def permit_params
      params.require(:user)
            .permit(:email, :firstname, :lastname, :password,
                    :password_confirmation, :avatar)
            .select { |_k, v| v.present? }
    end
  end
end
