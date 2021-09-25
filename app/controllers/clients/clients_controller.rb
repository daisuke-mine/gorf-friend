class Clients::ClientsController < ApplicationController

  def index
    @client = current_client
    @clients = Client.all
    @blog = Blog.new
    @blogs = Blog.all
    # @blog_find = Blog.find(params[:id])
    @blog_comment = BlogComment.all
  end
  
  def new
    @clients = Client.all
  end

  def show
    @client = Client.find(params[:id])
    @blogs = @client.blogs.all
    @blog_all = Blog.all
    @blog_comment = BlogComment.all

  end

  def edit
    @client = Client.find(params[:id])

  end

  def update
    @client = Client.find(params[:id])
    if @client.update(client_params)
      # flash[:notice] = "You have updated user successfully."
      redirect_to client_path(current_client)
    else
      render 'edit'
    end
  end

  private

  def client_params
    params.require(:client).permit(:name, :introduction, :profile_image)
  end

end
