class CategoriesController < ApplicationController
  def index
    @categories = Category.scoped

    respond_to do |format|
      format.html #index.html.erb
      format.xml { render :xml => @categories }
    end
  end
end
