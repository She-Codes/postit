module Admin
  class UsersController < ApplicationController
    def index
      @users = User.all
    end

    def create
      if User.update(users_params.keys, users_params.values)
        flash[:notice] = "User roles have been updated."
        redirect_to admin_users_path
      else
        flash[:error] = "There was a problem."
        render admin_users_path
      end
    end

    private 

    def users_params
      params.require(:users)
    end
  end
end