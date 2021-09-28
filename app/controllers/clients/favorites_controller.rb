class Clients::FavoritesController < ApplicationController
  
  before_action :authenticate_client!

  def create
    @blog = Blog.find(params[:blog_id])
    favorite = current_client.favorites.new(blog_id: @blog.id)
    favorite.save
  end

  def destroy
    @blog = Blog.find(params[:blog_id])
    favorite = current_client.favorites.find_by(blog_id: @blog.id)
    favorite.destroy

  end

end
