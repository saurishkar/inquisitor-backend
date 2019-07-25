# frozen_string_literal: true

module Admin
  class HomeController < ApplicationController
    before_action :check_auth, only: :index

    def index
      render 'admin/users/login'
    end

    private

    def check_auth
      redirect_to admin_users_path if session[:current_user]
    end
  end
end
