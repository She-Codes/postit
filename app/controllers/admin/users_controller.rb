module Admin
  class UsersController < ApplicationController
    before_action :require_admin
    def index
      @users = User.all
    end

    def update
      # update roles then delete if any are selected
      # mass update of users at once
      if User.update(users_params[:users_to_update].keys, users_params[:users_to_update].values)
        # delete
        if users_params[:users_to_delete]
          unless users_params[:users_to_delete].empty?
            User.destroy(users_params[:users_to_delete])
          end
        end
        flash[:notice] = "Users have been updated."
        redirect_to admin_users_path
      else
        flash[:error] = "There was a problem."
        render admin_users_path
      end
    end

    private 

    # using strong parameters to permit nested hashes in params
    #   "users"=> {
    #     "users_to_update"=> {
    #        "1"=>{"role"=>"admin"},
    #        "2"=>{"role"=>"moderator"},
    #        "3"=>{"role"=>"moderator"},
    #        "4"=>{"role"=>"moderator"},
    #        "5"=>{"role"=>"moderator"},
    #        "6"=>{"role"=>"user"},
    #        "7"=>{"role"=>"user"},
    #        "8"=>{"role"=>"user"},
    #        "9"=>{"role"=>"user"},
    #        "10"=>{"role"=>"user"},
    #        "11"=>{"role"=>"admin"},
    #        "12"=>{"role"=>"user"},
    #        "13"=>{"role"=>"user"},
    #        "16"=>{"role"=>"moderator"}
    #    },
    #   "users_to_delete"=>["6"]
    # }
    #
    # users_params hash:
    # users_params => {
    #   "users_to_delete"=>["6"],
    #   "users_to_update"=>
    #     {"1"=>{"role"=>"admin"},
    #      "2"=>{"role"=>"moderator"},
    #      "3"=>{"role"=>"moderator"},
    #      "4"=>{"role"=>"moderator"},
    #      "5"=>{"role"=>"moderator"},
    #      "6"=>{"role"=>"user"},
    #      "7"=>{"role"=>"user"},
    #      "8"=>{"role"=>"user"},
    #      "9"=>{"role"=>"user"},
    #      "10"=>{"role"=>"user"},
    #      "11"=>{"role"=>"admin"},
    #      "12"=>{"role"=>"user"},
    #      "13"=>{"role"=>"user"},
    #      "16"=>{"role"=>"moderator"}
    #    }
    # }

    def users_params
      params.require(:users).permit(users_to_delete: []).tap do |whitelisted| 
        whitelisted[:users_to_update] = params[:users][:users_to_update] 
      end
    end
  end
end

