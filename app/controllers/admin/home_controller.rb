module Admin
  class HomeController < ApplicationController
    before_action :check_auth, only: :index

    def index
      render 'admin/users/login'
    end

    private

    def check_auth
      if session[:current_user]
        redirect_to admin_users_path
      end
    end
  end
end
