class CommentsController < ApplicationController
  before_action :set_post, only: [:create, :destroy]
  def create
    @comment = @post.comments.build comment_params
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash[:alert] = "Check the comment form, something went wrong."
      render root_path
    end
  end

  def destroy
    @comment = @post.comments.find_by id: params[:id]
    if @comment.delete
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit :content
  end

  def set_post
    @post = Post.find_by id: params[:post_id]
  end
end
