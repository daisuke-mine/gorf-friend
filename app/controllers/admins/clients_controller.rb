class Admins::ClientsController < ApplicationController

  before_action :authenticate_admin!

  def index
    @clients = Client.page(params[:page])
  end

  def show
    @client = Client.find(params[:id])
    @blogs = @client.blogs.all.page(params[:page]).per(5).order('updated_at DESC')
    @blog_all = Blog.all
    @blog_comment = BlogComment.all
  end

  def destroy
    @client = Client.find(params[:id])
    @client.destroy
    redirect_to admins_clients_path
  end
end
