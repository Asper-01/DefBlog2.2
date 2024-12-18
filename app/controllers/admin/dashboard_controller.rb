# app/controllers/admin/dashboard_controller.rb
module Admin
  class DashboardController < ApplicationController
    before_action :authenticate_user!
    before_action :check_admin

    def index
      # Code pour afficher le dashboard
    end

    private

    def check_admin
      unless current_user.admin?
        redirect_to root_path, alert: "Vous n'avez pas l'autorisation d'accéder à cette page."
      end
    end
  end
end
