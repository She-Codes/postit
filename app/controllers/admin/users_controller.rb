module Admin
  class UsersController < ApplicationController
    def index
      @users = User.all
    end

    def update
      #binding.pry
      # unless users_params[:users_to_delete].empty?
      # users = User.all
      # users_params[:users_to_delete].each {|u|
      #   users.destroy(u)
      # }
      # end
      if User.update(users_params[:users_to_update].keys, users_params[:users_to_update].values)
        flash[:notice] = "User roles have been updated."
        redirect_to admin_users_path
      else
        flash[:error] = "There was a problem."
        render admin_users_path
      end
    end

    private 

    def users_params
      params.require(:users).permit(users_to_delete: []).tap do |whitelisted| 
        whitelisted[:users_to_update] = params[:users][:users_to_update] 
      end
    end
  end
end

