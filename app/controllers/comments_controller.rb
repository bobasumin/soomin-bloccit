class CommentsController < ApplicationController
  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments

    @comment = current_user.comments.build(params[:comment])
    @comment.post = @post

    authorize! :create, @comment, message: "You need be signed in to do that."
    if @comment.save
      flash[:notice] = "Comment was created."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the comment. Please try again."
      render 'posts/show'
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.find(params[:post_id])
    @comments = @post.comments.find(params[:id])

    authorize! :destroy, @comment, message: "You need to own this comment to do it."
    if @comment.destroy
      flash[:notice] = "Comment was deleted."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error deleting the comment."
      render [@topic, @post]
    end
  end
end