class Clients::BlogCommentsController < ApplicationController

  def create
    @blog_comment = Blog.find(params[:blog_id])
    comment = BlogComment.new(blog_comment_params)
    comment.blog_id = @blog_comment.id
    comment.client_id = current_client.id
    comment.save
    redirect_to blog_path(@blog_comment)
  end

  def destroy
    @blog_comment = Blog.find(params[:id])
    BlogComment.find_by(id: params[:id], blog_id: params[:blog_id]).destroy
  end

  private

  def blog_comment_params
    params.require(:blog_comment).permit(:comment)
  end

end
