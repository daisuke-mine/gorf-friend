class Clients::BlogsController < ApplicationController
  
  def index
  end
  
  def create
    @blog = Blog.new(blog_params)
    @blog.client_id = current_client.id
    if @blog.seve
      redirect_to cliens_path
    else
      redirect_to root_path
    end
  end
  
  
  private
  
  def blog_params
    params.require(:blog).permit(:title, :body)
  end
end
