class Clients::BlogsController < ApplicationController

  def index
  end

  def show
    @blog = Blog.find(params[:id])
    @comment = BlogComment.all

  end

  def create
    @blog = Blog.new(blog_params)
    @blog.client_id = current_client.id
    if @blog.save
      redirect_to clients_path
    else
      redirect_to clients_path
    end
  end


  private

  def blog_params
    params.require(:blog).permit(:title, :body, :images)
  end
end
