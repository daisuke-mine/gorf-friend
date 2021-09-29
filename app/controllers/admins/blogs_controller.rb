class Admins::BlogsController < ApplicationController

  before_action :authenticate_admin!

  def index

    @blogs = Blog.all.page(params[:page]).per(10).order('updated_at DESC')
    @blog_comment = BlogComment.all
  end

  def destroy
    @blog = Blog.find(params[:id])
    @blog.destroy
    redirect_to admins_blogs_path
  end
end
