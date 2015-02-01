module Admin
  class CategoriesController < ApplicationController
    before_action :require_admin_mod
    def index
      @categories = Category.all
    end

    def destroy
      if categories_params[:cats_to_delete].empty?
        flash[:error] = "No categories were selected."
        render admin_categories_path
      else
        # Destroy post associations to category
        categories_params[:cats_to_delete].each{|cat|
          PostCategory.destroy_all(category_id: cat)
        }
        # Delete Categories
        Category.destroy(categories_params[:cats_to_delete])
        
        flash[:notice] = "Categories have been deleted."
        redirect_to admin_categories_path
      end
    end

    private 

    def categories_params
      params.require(:categories).permit(cats_to_delete: [])
    end
  end
end

