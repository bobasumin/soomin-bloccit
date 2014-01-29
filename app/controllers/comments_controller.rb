class CommentsController < ApplicationController
  respond_to :html, :js

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments

    @comment = current_user.comments.build(params[:comment])
    @comment.post = @post
    
    @new_comment = Comment.new

    authorize! :create, @comment, message: "You need be signed in to do that."

    if @comment.save
      flash[:notice] = "Comment was created."
    else
      flash[:error] = "There was an error saving the comment. Please try again."
    end

    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post] }
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])

    authorize! :destroy, @comment, message: "You need to own this comment to do it."
    
    if @comment.destroy
      flash[:notice] = "Comment was deleted."
    else
      flash[:error] = "There was an error deleting the comment."
    end

    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post] }
    end
  end

end